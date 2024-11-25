
module cpu(
    input logic rst_in,
    input logic clk_in,
    memory_bus mem_bus,
    program_memory_bus program_mem_bus
);
    always_comb begin
        // program memory
        program_mem_bus.addr = 0;
        program_mem_bus.read_request = 0;
        // memory
        mem_bus.addr = 0;
        mem_bus.write_data = 0;
        mem_bus.dispatch_read = 0; 
        mem_bus.dispatch_write = 0;
    end
endmodule;