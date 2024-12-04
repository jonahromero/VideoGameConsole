

// helpful addresses:
// rom:   0x0FFFF - 0x00000
// ram:   0x1FFFF - 0x10000
// frame: 0x2FFFF - 0x20000
// io:    0x3FFFF - 0x30000

// FB SWAP: 0x2FFFF
// 

//test cpu
module cpu(
    input wire rst_in,
    input wire clk_in,
    // debug
    input wire[1:0] debug_btns,
    input wire[15:0] debug_sw,
    output logic[31:0] debug_display,

    memory_bus.CONSUMER mem_bus,
    program_memory_bus.CONSUMER_A program_mem_bus
);
    parameter SWITCH_FB_ADDR = 32'h2FFFF;
    parameter FRAME_BUFFER_ADDR = 32'h2_0000;
    parameter PROGRAM_START = 32'h0_0000;
    parameter PROGRAM_END = PROGRAM_START + 32'd8192;

    enum {READ_ADDR = 1, WRITE_ADDR = 2, WAITING = 4} state;
    logic[31:0] offset;

    assign debug_display = mem_bus.read_data;
    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
            offset <= 0;
            state <= READ_ADDR;
            //init bus
            mem_bus.addr <= 0;
            mem_bus.dispatch_read <= 0;
            mem_bus.dispatch_write <= 0;
            mem_bus.write_data <= 0;
            mem_bus.mem_width <= 0;
        end
        else begin
            case (state)
            WAITING: begin
                if (debug_btns[0]) begin
                    if (!mem_bus.busy) begin
                        mem_bus.mem_width <= mem::BYTE;
                        mem_bus.addr <= SWITCH_FB_ADDR;
                        mem_bus.dispatch_write <= 1;
                        mem_bus.write_data <= 1;
                    end
                end
                if (debug_btns[1]) begin // deug write
                    if (!mem_bus.busy) begin
                        mem_bus.mem_width <= mem::WORD;
                        mem_bus.addr <= {debug_sw, 2'b00};
                        mem_bus.dispatch_write <= 1;
                        mem_bus.write_data <= 16'hF7_F5;
                    end
                end
                else begin // debug read
                    if (!mem_bus.busy) begin
                        mem_bus.mem_width <= mem::DWORD;
                        mem_bus.addr <= {debug_sw, 2'b00};
                        mem_bus.dispatch_read <= 1;
                    end
                end
            end
            READ_ADDR: begin
                if (!mem_bus.busy) begin
                    mem_bus.mem_width <= mem::WORD;
                    mem_bus.addr <= PROGRAM_START + offset;
                    mem_bus.dispatch_read <= 1;
                    state <= WRITE_ADDR;
                end
            end
            WRITE_ADDR: begin
                if (!mem_bus.busy) begin
                    mem_bus.write_data <= mem_bus.read_data; //(offset[1:0] < 2 ? 16'hF8_00 : 16'h08_0F); // mem_bus.read_data; //
                    mem_bus.mem_width <= mem::WORD;
                    mem_bus.addr <= FRAME_BUFFER_ADDR + offset;
                    mem_bus.dispatch_write <= 1;
                    // special code
                    if (offset + 2 == PROGRAM_END) begin
                        state <= WAITING;
                    end
                    else begin
                        offset <= offset + 2;
                        state <= READ_ADDR;
                    end
                end
            end
            endcase
            // single pulses
            if (mem_bus.dispatch_read) begin
                mem_bus.dispatch_read <= 0;
            end
            if (mem_bus.dispatch_write) begin
                mem_bus.dispatch_write <= 0;
            end
        end
    end
endmodule