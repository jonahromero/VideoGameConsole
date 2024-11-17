
module memory_system(
    input wire clk_in,
    input wire rst_in,
    frame_buffer_bus fb_bus
);
    always_comb begin
        fb_bus.write_clk = clk_in;
        fb_bus.write_addr = 0;
        fb_bus.write_data = 0;
        fb_bus.write_enable = 0;
    end

endmodule