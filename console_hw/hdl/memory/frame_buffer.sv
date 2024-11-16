
// this module acts like a full 720x1280 frame buffer when being read from
// However, on write, it acts like a 180x320 buffer.
// Internally uses two frame buffers, that can be swapped. This means you never
// write to the same frame buffer that someone else is reading from
module frame_buffer (
    input wire write_clk_in,
    input wire read_clk_in,
    input wire rst_in,

    // writing to frame buffer
    input wire[15:0] data_in, // 565 format rgb input
    input wire[FB_SIZE-1:0] write_addr_in, // an address within 320x180
    input wire write_enable, // single pulse write

    // reading to frame buffer
    input wire[$clog2(VCOUNT_WIDTH)-1:0] vcount_in,
    input wire[$clog2(VCOUNT_HEIGHT)-1:0] hcount_in,
    output logic [7:0] red_out,
    output logic [7:0] green_out,
    output logic [7:0] blue_out,

    input wire swap_buffer, // single pulse signal that tells us to swap frame buffers
);
    localparam VCOUNT_WIDTH = 1280;
    localparam VCOUNT_HEIGHT = 720;
    localparam FB_WIDTH = 320
    localparam FB_HEIGHT = 180;
    localparam FB_SIZE = $clog2(FB_WIDTH*FB_HEIGHT);

    logic buffer_flag; // flip flops depending on which buffer is reading/writing
    logic blk_we[1:0];
    logic[15:0] blk_data_out[1:0];
    logic[15:0] frame_buff_raw,
    logic [FB_SIZE-1:0] read_addr;

    always_ff @(posedge write_clk_in) begin
        if (rst_in) begin
            buffer_flag <= 0;
        end
        else begin
            if (swap_buffer) begin
                buffer_flag <= !buffer_flag;
            end
        end
    end

    always_comb begin
        read_addr = ((FB_WIDTH-1)-(hcount_in>>2)) + FB_WIDTH*(vcount_in>>2);
        blk_we = {!buffer_flag, buffer_flag};
        frame_buff_raw = buffer_flag ? blk_data_out[0] : blk_data_out[1];
            
        red_out   = {frame_buff_raw[15:11], 3'b0};
        green_out = {frame_buff_raw[10:5],  2'b0};
        blue_out  = {frame_buff_raw[4:0],   3'b0};
    end

    // 2 cycles
    generate
        for (genvar i = 0; i < 2; i++) begin
            blk_mem_gen_0 frame_buffer (
                .clka(write_clk_in),
                .addra(write_addr_in), //pixels are stored using this math
                .wea(blk_we[i]),
                .dina(data_in),
                .ena(1'b1),
                .douta(), //never read from this side

                .clkb(read_clk_in),
                .addrb(read_addr),//transformed lookup pixel
                .dinb(16'b0),
                .web(1'b0),
                .enb(1'b1),
                .doutb(blk_data_out[i])
            );
        end
    endgenerate

endmodule