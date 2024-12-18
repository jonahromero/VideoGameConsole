
`default_nettype none

package mem;
    typedef enum {
        BYTE = 0, WORD = 1, DWORD = 2
    } mem_width_t;

    typedef enum {
        IO, FB, RAM, ROM, UNKNOWN
    } addr_type_t;
endpackage

interface memory_bus();
    logic[31:0] addr;
    logic[31:0] write_data;
    logic dispatch_write;
    logic dispatch_read;
    mem::mem_width_t mem_width;
    
    logic[31:0] read_data;
    logic busy;

    modport MEMORY_SYSTEM (
        input addr, write_data, dispatch_read, dispatch_write, mem_width,
        output read_data, busy
    );
    modport CONSUMER (
        output addr, write_data, dispatch_read, dispatch_write, mem_width,
        input read_data, busy
    );
endinterface : memory_bus

module mmio_mappings(
    input wire[31:0] addr,
    output mem::addr_type_t addr_type,
    output logic[27:0] real_addr
);
    logic[1:0] mem_sel;
    logic[1:0] unused;
    always_comb begin
        // final addr: MX_XX_XX_XX
        unused = addr[31:30];
        mem_sel = addr[29:28]; // top nibble
        real_addr = addr[27:0]; // XX_XX_XX
        case (mem_sel) 
            0: addr_type = mem::ROM;
            1: addr_type = mem::RAM;
            2: addr_type = mem::FB;
            3: addr_type = mem::IO;
            default: addr_type = mem::UNKNOWN; 
        endcase
    end
endmodule : mmio_mappings

module memory_system (
    input wire clk_in,
    input wire rst_in,

    output logic[12:0] debug_led,
    input wire[31:0] debug_display,

    memory_bus.MEMORY_SYSTEM bus,
    frame_buffer_bus.WRITE fb_bus,
    sys_io_bus.CONSUMER io_bus,
    program_memory_bus.CONSUMER_B program_mem_bus
);

//    ila_0 debugger (
//        .clk(clk_in), // input wire clk

//        .trig_in(rst_in),// input wire trig_in 
//        .trig_in_ack(),// output wire trig_in_ack 
//        .probe0(addr_type), // input wire [7:0]  probe0  
//        .probe1(counter), // input wire [7:0]  probe1 
//        .probe2({7'd0, ram_data_out}), // input wire [15:0]  probe2 
//        .probe3(bus.read_data), // input wire [31:0]  probe3 
//        .probe4(bus.write_data), // input wire [31:0]  probe4 
//        .probe5(data_latched), // input wire [31:0]  probe5 
//        .probe6(addr_latched), // input wire [31:0]  probe6 
//        .probe7(bus.addr[30:0]), // input wire [31:0]  probe7 // fucked up this is 30:0

//        .probe8(bus.busy), // input wire [0:0]  probe8 
//        .probe9(we), // input wire [0:0]  probe9 
//        .probe10(fb_we), // input wire [0:0]  probe10 
//        .probe11(ram_we), // input wire [0:0]  probe11 
//        .probe12(rst_in), // input wire [0:0]  probe12 
//        .probe13(bus.dispatch_write), // input wire [0:0]  probe13 
//        .probe14(bus.dispatch_read), // input wire [0:0]  probe14 
//        .probe15(ram_read_buffer) // input wire [0:0]  probe15
//    );

    enum {
        WAITING = 1, READ_MEM = 2, WRITE_MEM = 4, SEND_WE = 8
    } state;

    // info gathered during WAITING state
    logic[31:0] addr_latched;
    logic[31:0] data_latched;
    logic[2:0] mem_width_latched;
    logic[2:0] bytes_to_send;

    // MMIO outputs. These are derived from addr_latched and can be used however.
    logic[27:0] real_addr; // Lower byte of addr_latched, but used in all sub-memory-systems since theyre <64kb
    mem::addr_type_t addr_type;

    mmio_mappings mmio(
        // if incoming request, change this immediately
        .addr((bus.dispatch_read || bus.dispatch_write) ? bus.addr : addr_latched),
        .addr_type(addr_type),
        .real_addr(real_addr)
    );
    
    // io bus helpers
    logic[31:0] io_read_data;
    // TODO - PLEASE REMOVE THIS ALWAYS FALSE
    logic debug;
    assign debug = 0;
    assign io_read_data = (debug ?  32'h00_09_07_02 : ((real_addr < 4) ? {
        8'h00,
        io_bus.controller.joystick_x,
        io_bus.controller.joystick_y,
        io_bus.controller.buttons
    } : 32'h00_00_00_00 )) >> 8 * (real_addr) /*adjust for addr offset*/;
    
    assign debug_display = {
        8'h00,
        io_bus.controller.joystick_x,
        io_bus.controller.joystick_y,
        io_bus.controller.buttons
    };

    // Write enables for memory sub-systems
    logic ram_we, fb_we;
    always_comb begin
        fb_we =  bus.dispatch_write && (addr_type == mem::FB) && 
        (!bus.busy || bus.dispatch_read || bus.dispatch_write); // make sure we dont write frame buffer while we're busy
    end

    // Helper for counting cycles
    logic[7:0] counter;
    logic[31:0] ram_read_buffer;

    assign bus.busy = (state != WAITING) || bus.dispatch_read || bus.dispatch_write;
    always_ff @(posedge clk_in) begin
        if (rst_in) begin
            state <= WAITING;
            debug_led <= 0;
            bus.read_data <= 0;
        end
        else begin
            case (state)
            WAITING: begin
                if (bus.dispatch_read || bus.dispatch_write) begin
                    addr_latched <= bus.addr;
                    data_latched <= bus.write_data;
                    ram_read_buffer <= 0;
                    case (bus.mem_width)
                        mem::BYTE: mem_width_latched <= 1;
                        mem::WORD: mem_width_latched <= 2;
                        mem::DWORD: mem_width_latched <= 4;
                    endcase
                    case (bus.mem_width)
                        mem::BYTE: bytes_to_send <= 1;
                        mem::WORD: bytes_to_send <= 2;
                        mem::DWORD: bytes_to_send <= 4;
                    endcase
                    counter <= 0;
                end
                if (bus.dispatch_read) begin
                    state <= READ_MEM;
                end
                else if (bus.dispatch_write) begin
                    if (addr_type == mem::RAM) begin
                        state <= SEND_WE;
                    end
                    else begin
                        state <= WAITING;
                    end
                end
            end
            READ_MEM: begin
                counter <= counter + 1;
                case (addr_type)
                    mem::IO : begin
                        bus.read_data <= io_read_data;
                        state <= WAITING;
                    end
                    mem::FB : begin
                        if (counter + 1 == 3) begin // wait 4 cycles
                            bus.read_data <= fb_bus.debug_read;
                            state <= WAITING;
                        end
                    end
                    mem::RAM : begin
                        if (counter + 1 == 3) begin // wait 2 cycles
                            counter <= 0;
                            if (bytes_to_send != 1) begin
                                bytes_to_send <= bytes_to_send - 1;
                            end
                            else begin
                                bus.read_data <= ({ram_data_out, ram_read_buffer[31:8] } >> (8 * (4 - mem_width_latched)));
                                state <= WAITING;
                            end

                            ram_read_buffer <= {ram_data_out, ram_read_buffer[31:8] };
                            addr_latched <= addr_latched + 1;
                        end
                    end
                    mem::ROM : begin
                        if (counter + 1 == 3) begin // wait 2 cycles
                            // the program instruction ram reads 4 byte instructions,
                            // ignoring the bottom 2 bits, so we offset based on address
                            // we also dont have to worry about partials, since riscv requires aligned access
                            bus.read_data <= (program_mem_bus.instr_b >> (8 * real_addr[1:0]));
                            state <= WAITING;
                        end
                    end
                    mem::UNKNOWN : begin
                        bus.read_data <= 16'hF8_00;
                        state <= WAITING;
                    end
                    default: begin
                        bus.read_data <= 16'hFF_FF;
                        state <= WAITING;
                    end
                endcase
            end
            SEND_WE : begin
                ram_we <= 1;
                state <= WRITE_MEM;
            end
            WRITE_MEM: begin
                counter <= counter + 1;
                case (addr_type)
                    mem::RAM: begin
                        //if (counter == 3) begin // wait 2 cycles
                        //    counter <= 0;
                            if (bytes_to_send != 1) begin
                                bytes_to_send <= bytes_to_send - 1;
                                data_latched  <= (data_latched >> 8);
                                addr_latched <= addr_latched + 1;
                                state <= SEND_WE;
                            end
                            else begin
                                state <= WAITING;
                            end
                        //end
                    end
                    mem::IO:      state <= WAITING;
                    mem::FB:      state <= WAITING;
                    mem::ROM:     state <= WAITING;
                    mem::UNKNOWN: state <= WAITING;
                endcase
            end
            endcase
            if (ram_we) begin
                ram_we <= 0;
            end
        end
    end
    
    //// The following code, utilizes the several busses it manages, to forward correct data
    // Program Memory
    always_comb begin
        program_mem_bus.addr_b = real_addr;
    end

    // Frame Buffer. Two-cycle read and one-cycle write
    parameter FB_SWAP_ADDR = 28'hF_FF_FF_FF;
    always_comb begin
        fb_bus.write_clk = clk_in;
        fb_bus.write_addr = real_addr;
        // mem width implicitly word size
        fb_bus.write_data = bus.write_data[15:0];

        fb_bus.write_enable = fb_we && (real_addr != FB_SWAP_ADDR);
        fb_bus.swap_buffer  = fb_we && (real_addr == FB_SWAP_ADDR);
    end

    // Internal RAM. Two-cycle read and one-cycle write.
    logic[7:0] ram_data_out;
    xilinx_single_port_ram_read_first #(
        .RAM_WIDTH(8),
        .RAM_DEPTH(64*1024),
        .RAM_PERFORMANCE("HIGH_PERFORMANCE")
    ) ram (
        .addra(real_addr),
        .dina(data_latched[7:0]),
        .wea(ram_we),
        .douta(ram_data_out),

        .clka(clk_in),
        .rsta(rst_in),
        .ena(1),
        .regcea(1)
    );

endmodule : memory_system


`default_nettype wire