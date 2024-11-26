
//test cpu
module cpu(
    input logic rst_in,
    input logic clk_in,
    input logic[1:0] debug_btns,
    memory_bus mem_bus,
    program_memory_bus program_mem_bus
);
    parameter SWITCH_ADDR = ;

    always_ff @ (posedge clk_in) begin
        if (rst_in) begin
        end
        else begin
            if (debug_btns[0]) begin
                mem_bus.addr <= SWICH_ADDR;
                mem_bus.dispatch_write <= 1;
                mem_bus.write_data <= 1;
            end
            if (mem_bus.dispatch_read) begin
                mem_bus.dispatch_read <= 0;
            end
            if (mem_bus.dispatch_write) begin
                mem_bus.dispatch_write <= 0;
            end
        end
    end
    always_comb begin
        // program memory
        //program_mem_bus.addr = 0;
        //program_mem_bus.read_request = 0;
        // memory
        mem_bus.addr = 0;
        mem_bus.write_data = 0;
        mem_bus.dispatch_read = 0; 
        mem_bus.dispatch_write = 0;
    end
endmodule