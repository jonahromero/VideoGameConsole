
interface memory_bus();
    logic[31:0] addr,
    logic[7:0] write_data,
    logic dispatch_write,
    logic dispatch_read,
    
    logic[7:0] read_data,
    logic finished_op,

    modport MEMORY_SYSTEM (
        input addr, write_data, dispatch_read, dispatch_write,
        output read_data, finished_op
    );
    modport CONSUMER (
        output addr, write_data, dispatch_read, dispatch_write,
        input read_data, finished_op
    );
endinterface

module mmio_enables(
    input logic[31:0] addr,
    output logic ram_enable,
    output logic frame_buffer_enable,
    output logic io_enable
);
    always_comb begin
        io_enable = addr[31:8] == 24'hFF_FF_FF;
        // ram is only 64kb
        frame_buffer_enable = addr[31:16] == 8'h00_00;
        ram_enable = !io_enable && !frame_buffer_enable;
    end
endmodule

module memory_system (
    input wire clk_in,
    input wire rst_in,

    memory_bus mem_bus,
    frame_buffer_bus fb_bus,
    sys_io_bus io_bus
);
    logic[31:0] addr_latched;
    logic[7:0] data_latched;
    // write enables
    logic io_enable, frame_buffer_enable, ram_enable;
    mmio_enables mmio_en(
        .addr(addr_latched),
        .ram_enable(ram_enable),
        .frame_buffer_enable(frame_buffer_enable),
        .io_enable(io_enable)
    );

    typedef enum {
        WAITING, READ_MEM, WRITE_MEM
    } mem_sys_state state;

    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            data_out <= 0;
            finished_op <= 0;
            state <= WAITING;
        end
        else begin
            case (state)
            READ_MEM: begin
                
            end
            WRITE_MEM: begin
                
            end
            WAITING: begin
                addr_latched <= addr;
                data_latched <= data_in;
                if (dispatch_read) begin
                    state <= WRITE_MEM;
                end
                else if (dispatch_write) begin
                    state <= READ_MEM;
                end
            end
            endcase
        end
    end

    logic[15:0] write_addr;
    logic[15:0] write_data;
    logic[15:0] read_addr;
    logic[15:0] blk_data_out[BLK_BUFFERS-1:0];
    logic blk_we[BLK_BUFFERS-1:0];

    always_comb begin
        write_addr = 0;
        write_data = 0;
        read_addr = 0;
        
        for (int i = 0; i < BLK_BUFFERS; i++) begin
            blk_data_out[i] = 0;
            blk_we[i] = 0;
        end
    end

    // THE REST OF THIS IS INTERACTING WITH THE MEMORY
    // io devices


    // frame buffer
    always_comb begin
        fb_bus.write_clk = clk_in;
        fb_bus.write_addr = addr_latched;
        fb_bus.write_data = data_latched;
        fb_bus.write_enable = frame_buffer_enable && (state == WRITE_MEM);
    end

    // internal ram
    xilinx_single_port_ram_read_first #(
        .RAM_WIDTH(8),                      // Specify RAM data width
        .RAM_DEPTH(64*1024),                      // Specify RAM depth (number of entries)
        .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    ) ram (
        .addra(addr_latched),     // Address bus, width determined from RAM_DEPTH
        .dina(0),       // RAM input data, width determined from RAM_WIDTH
        .wea(0),         // Write enable
        .douta(palette_out)      // RAM output data, width determined from RAM_WIDTH

        .clka(clk_in),       // Clock
        .ena(1),         // RAM Enable, for additional power savings, disable port when not in use
        .rsta(rst_in),       // Output reset (does not affect memory contents)
        .regcea(1),   // Output register enable
    );

endmodule