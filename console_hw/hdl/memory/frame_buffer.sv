

`default_nettype none

// all of these are in terms of words, since a pixel is 16 bits
package hdmi_const;
    parameter VCOUNT_WIDTH = 1280;
    parameter VCOUNT_HEIGHT = 720;
    parameter FB_WIDTH = 320;
    parameter FB_HEIGHT = 180;
    parameter FB_SIZE = $clog2(FB_WIDTH*FB_HEIGHT);
endpackage

interface frame_buffer_bus();

    logic write_clk;
    logic read_clk;

    // writing to frame buffer
    logic[15:0] write_data; // 565 format rgb input
    logic[2*hdmi_const::FB_SIZE-1:0] write_addr; // an address within 320x180
    logic write_enable; // single pulse write
    logic [15:0] debug_read;

    // reading to frame buffer
    logic[$clog2(hdmi_const::VCOUNT_HEIGHT)-1:0] vcount;
    logic[$clog2(hdmi_const::VCOUNT_WIDTH)-1:0] hcount;
    logic [7:0] red, green, blue;

    logic swap_buffer; // single pulse signal that tells us to swap frame buffers

    modport READ (
        input red, green, blue, 
        output vcount, hcount, read_clk
    ); 
    modport WRITE (
        output write_data, write_addr, write_enable, write_clk, swap_buffer,
        input debug_read
    );
    modport FRAME_BUFFER (
        input write_data, write_addr, write_enable, vcount, hcount, swap_buffer, write_clk, read_clk,
        output red, green, blue, debug_read
    );
endinterface

// this module acts like a full 720x1280 frame buffer when being read from
// However, on write, it acts like a 180x320 buffer.
// Internally uses two frame buffers, that can be swapped. This means you never
// write to the same frame buffer that someone else is reading from
module frame_buffer
(
    input wire rst_in,
    frame_buffer_bus.FRAME_BUFFER bus
);
    logic buffer_flag; // flip flops depending on which buffer is reading/writing
    logic blk_we[1:0];
    logic[15:0] blk_data_out[1:0];
    logic[15:0] blk_data_debug_out[1:0];
    logic[15:0] frame_buff_raw;
    logic [hdmi_const::FB_SIZE-1:0] read_addr;

    always_ff @(posedge bus.write_clk) begin
        if (rst_in) begin
            buffer_flag <= 0;
        end
        else begin
            if (bus.swap_buffer) begin
                buffer_flag <= !buffer_flag;
            end
        end
    end

    always_comb begin
        read_addr = ((bus.hcount>>2)) + hdmi_const::FB_WIDTH*(bus.vcount>>2); // TODO - Violate timing?
        blk_we[0] = buffer_flag && bus.write_enable;
        blk_we[1] = !buffer_flag  && bus.write_enable;

        //frame_buff_raw = bus.hcount[2:0] < 4 ? 16'h6690 : 16'hFFFF;

        if (buffer_flag) begin
            frame_buff_raw = blk_data_out[1]; // TODO- this should be 1, but have them write and read same one for testing
            bus.debug_read =  blk_data_debug_out[1];
        end
        else begin
            frame_buff_raw = blk_data_out[0];
            bus.debug_read =  blk_data_debug_out[0];
        end
        bus.red   = { frame_buff_raw[15:11], 3'b0 };
        bus.green = { frame_buff_raw[10:5],  2'b0 };
        bus.blue  = { frame_buff_raw[4:0],   3'b0 };
    end

    // 2 cycles
    generate
        for (genvar i = 0; i < 2; i++) begin
            blk_mem_gen_0 frame_buffer(
                .clka(bus.write_clk),
                .addra(bus.write_addr >> 1), //pixels are stored using this math
                .wea(blk_we[i]),
                .dina(bus.write_data),
                .ena(1'b1),
                .douta(blk_data_debug_out[i]), //never read from this side

                .clkb(bus.read_clk),
                .addrb(read_addr),//transformed lookup pixel
                .dinb(16'b0),
                .web(1'b0),
                .enb(1'b1),
                .doutb(blk_data_out[i])
            );
        end
    endgenerate

endmodule


`default_nettype wire