
interface memory_bus();
    logic[31:0] addr;
    logic[7:0] write_data;
    logic dispatch_write;
    logic dispatch_read;
    
    logic[7:0] read_data;
    logic busy;

    modport MEMORY_SYSTEM (
        input addr, write_data, dispatch_read, dispatch_write,
        output read_data, busy
    );
    modport CONSUMER (
        output addr, write_data, dispatch_read, dispatch_write,
        input read_data, busy
    );
endinterface

module mmio_mappings(
    input logic[31:0] addr,

    output logic ram_enable,
    output logic frame_buffer_enable,
    output logic io_enable,
    output logic[15:0] real_addr
);
    logic[1:0] mem_sel;
    always_comb begin
        mem_sel = addr[17:16];
        real_addr = addr[15:0];

        io_enable = mem_sel == 0;
        ram_enable = mem_sel == 1;
        frame_buffer_enable = mem_sel == 2;
    end
endmodule

module memory_system (
    input wire clk_in,
    input wire rst_in,

    memory_bus bus,
    frame_buffer_bus fb_bus,
    sys_io_bus io_bus
);
    logic[31:0] addr_latched;
    logic[7:0] data_latched;
    logic[7:0] ram_data_out;
    logic[7:0] counter;
    logic we;
    // write enables
    logic[15:0] real_addr;
    logic is_io_addr, is_frame_buffer_addr, is_ram_addr;
    mmio_mappings mmio(
        .addr(addr_latched),
        .real_addr(real_addr),
        .ram_enable(is_ram_addr),
        .frame_buffer_enable(is_frame_buffer_addr),
        .io_enable(is_io_addr)
    );

    enum {
        WAITING, READ_MEM, WRITE_MEM
    } state;

    assign bus.busy = (state != WAITING);
    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            bus.read_data <= 0;
            counter <= 0;
            we <= 0;
            state <= WAITING;
        end
        else begin
            if (we) begin
                we <= 0;
            end
            case (state)
            READ_MEM: begin
                if (is_io_addr) begin
                    case (real_addr)
                        0: bus.read_data <= io_bus.controller.joystick_x;
                        1: bus.read_data <= io_bus.controller.joystick_y;
                        2: bus.read_data <= io_bus.controller.buttons;
                        default: bus.read_data <= 0;
                    endcase
                    state <= WAITING;
                end
                else if (is_frame_buffer_addr) begin
                    bus.read_data <= 0;
                    state <= WAITING;
                end
                else if (is_ram_addr) begin
                    if (counter + 1 == 2) begin // wait 2 cycles
                        bus.read_data <= ram_data_out;
                        state <= WAITING;
                    end
                    counter <= counter + 1;
                end
            end
            WRITE_MEM: begin
                // all of these are 1 cycle.
                state <= WAITING;
            end
            WAITING: begin
                counter <= 0;
                addr_latched <= bus.addr;
                data_latched <= bus.write_data;
                if (bus.dispatch_read) begin
                    state <= READ_MEM;
                end
                else if (bus.dispatch_write) begin
                    state <= WRITE_MEM;
                    we <= 1;
                end
            end
            endcase
        end
    end

    // THE REST OF THIS IS INTERACTING WITH THE MEMORY
    // frame buffer. 1 cycle write
    parameter FB_SWAP_ADDR = 16'hFF_FF;
    always_comb begin
        fb_bus.write_clk = clk_in;
        fb_bus.write_addr = real_addr;
        fb_bus.write_data = data_latched;

        fb_bus.write_enable = we && is_frame_buffer_addr && (real_addr != FB_SWAP_ADDR);
        fb_bus.swap_buffer = we && (real_addr == FB_SWAP_ADDR);
    end

    // internal ram. 2 cycle read, 1 cycle write
    xilinx_single_port_ram_read_first #(
        .RAM_WIDTH(8),                      // Specify RAM data width
        .RAM_DEPTH(64*1024),                      // Specify RAM depth (number of entries)
        .RAM_PERFORMANCE("HIGH_PERFORMANCE") // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    ) ram (
        .addra(real_addr),        // Address bus, width determined from RAM_DEPTH
        .dina(data_latched),      // RAM input data, width determined from RAM_WIDTH
        .wea(we && is_ram_addr),  // Write enable
        .douta(ram_data_out),      // RAM output data, width determined from RAM_WIDTH

        .clka(clk_in),       // Clock
        .ena(1),         // RAM Enable, for additional power savings, disable port when not in use
        .rsta(rst_in),       // Output reset (does not affect memory contents)
        .regcea(1)   // Output register enable
    );

endmodule