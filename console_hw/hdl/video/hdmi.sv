

module hdmi(
   input wire clk_100mhz,
   input wire rst_in,

   output logic [2:0]  hdmi_tx_p, //hdmi output signals (positives) (blue, green, red)
   output logic [2:0]  hdmi_tx_n, //hdmi output signals (negatives) (blue, green, red)
   output logic        hdmi_clk_p, hdmi_clk_n, //differential hdmi clock

   output logic signal_clk,
   frame_buffer_bus bus
);
  // buffer the clk_100mhz
  logic clk_100mhz_buf;
  IBUF clk_ibuf (
    .I(clk_100mhz),      // External input clock
    .O(clk_100mhz_buf)   // Buffered input clock
  );
  

  // Clock and Reset Signals
  logic          clk_pixel;
  logic          clk_5x;

  cw_hdmi_clk_wiz wizard_hdmi
    (.sysclk(clk_100mhz_buf),
     .clk_pixel(clk_pixel),
     .clk_tmds(clk_5x),
     .reset(0));

  // video signal generator signals
  logic          hsync_hdmi;
  logic          vsync_hdmi;
  logic [10:0]  hcount_hdmi;
  logic [9:0]    vcount_hdmi;
  logic          active_draw_hdmi;
  logic          new_frame_hdmi;
  logic [5:0]    frame_count_hdmi;
  logic          nf_hdmi;

  // HDMI video signal generator
   video_sig_gen vsg(
      .pixel_clk_in(clk_pixel),
      .rst_in(sys_rst_pixel),
      .hcount_out(hcount_hdmi),
      .vcount_out(vcount_hdmi),
      .vs_out(vsync_hdmi),
      .hs_out(hsync_hdmi),
      .nf_out(nf_hdmi),
      .ad_out(active_draw_hdmi),
      .fc_out(frame_count_hdmi)
   );

  // rgb output values
  logic [7:0]          red,green,blue;

   // read bus values
   always_comb begin
      red = bus.red; 
      green = bus.green; 
      blue = bus.blue; 
      bus.vcount = vcount_hdmi;
      bus.hcount = hcount_hdmi;
      bus.read_clk = clk_pixel;
   end


  logic[7:0] fb_red_pipe, fb_green_pipe, fb_blue_pipe;
  pipeline #(.STAGES(3), .WIDTH(8)) ps1_1(.clk_in(clk_pixel), .sig_in(red), .sig_out(fb_red_pipe));
  pipeline #(.STAGES(3), .WIDTH(8)) ps1_2(.clk_in(clk_pixel), .sig_in(green), .sig_out(fb_green_pipe));
  pipeline #(.STAGES(3), .WIDTH(8)) ps1_3(.clk_in(clk_pixel), .sig_in(blue), .sig_out(fb_blue_pipe));

  // ENDPOINT 2
  logic [$clog2(1700)-1:0] hcount_pipe;
  logic [$clog2(755)-1:0] vcount_pipe;
  logic vs_pipe; //vertical sync out
  logic hs_pipe; //horizontal sync out
  logic ad_pipe;
  logic nf_pipe; //single cycle enable signal
  pipeline #(.STAGES(8), .WIDTH($clog2(1700))) ps3_1(.clk_in(clk_pixel), .sig_in(hcount_hdmi), .sig_out(hcount_pipe));
  pipeline #(.STAGES(8), .WIDTH($clog2(755))) ps3_2(.clk_in(clk_pixel), .sig_in(vcount_hdmi), .sig_out(vcount_pipe));
  pipeline #(.STAGES(8), .WIDTH(1)) ps3_3(.clk_in(clk_pixel), .sig_in(vsync_hdmi), .sig_out(vs_pipe));
  pipeline #(.STAGES(8), .WIDTH(1)) ps3_4(.clk_in(clk_pixel), .sig_in(hsync_hdmi), .sig_out(hs_pipe));
  pipeline #(.STAGES(8), .WIDTH(1)) ps3_5(.clk_in(clk_pixel), .sig_in(active_draw_hdmi), .sig_out(ad_pipe));
  pipeline #(.STAGES(8), .WIDTH(1)) ps3_6(.clk_in(clk_pixel), .sig_in(nf_hdmi), .sig_out(nf_pipe));

   // HDMI Output: just like before!
   logic [9:0] tmds_10b [0:2]; //output of each TMDS encoder!
   logic       tmds_signal [2:0]; //output of each TMDS serializer!

   //three tmds_encoders (blue, green, red)
   //note green should have no control signal like red
   //the blue channel DOES carry the two sync signals:
   //  * control_in[0] = horizontal sync signal
   //  * control_in[1] = vertical sync signal
   tmds_encoder tmds_red(
       .clk_in(clk_pixel),
       .rst_in(sys_rst_pixel),
       .data_in(red),
       .control_in(2'b0),
       .ve_in(ad_pipe),
       .tmds_out(tmds_10b[2]));

   tmds_encoder tmds_green(
         .clk_in(clk_pixel),
         .rst_in(sys_rst_pixel),
         .data_in(green),
         .control_in(2'b0),
         .ve_in(ad_pipe),
         .tmds_out(tmds_10b[1]));

   tmds_encoder tmds_blue(
        .clk_in(clk_pixel),
        .rst_in(sys_rst_pixel),
        .data_in(blue),
        .control_in({vs_pipe,hs_pipe}),
        .ve_in(ad_pipe),
        .tmds_out(tmds_10b[0]));

   //three tmds_serializers (blue, green, red):
   //MISSING: two more serializers for the green and blue tmds signals.
   tmds_serializer red_ser(
         .clk_pixel_in(clk_pixel),
         .clk_5x_in(clk_5x),
         .rst_in(sys_rst_pixel),
         .tmds_in(tmds_10b[2]),
         .tmds_out(tmds_signal[2]));
   tmds_serializer green_ser(
         .clk_pixel_in(clk_pixel),
         .clk_5x_in(clk_5x),
         .rst_in(sys_rst_pixel),
         .tmds_in(tmds_10b[1]),
         .tmds_out(tmds_signal[1]));
   tmds_serializer blue_ser(
         .clk_pixel_in(clk_pixel),
         .clk_5x_in(clk_5x),
         .rst_in(sys_rst_pixel),
         .tmds_in(tmds_10b[0]),
         .tmds_out(tmds_signal[0]));

   //output buffers generating differential signals:
   //three for the r,g,b signals and one that is at the pixel clock rate
   //the HDMI receivers use recover logic coupled with the control signals asserted
   //during blanking and sync periods to synchronize their faster bit clocks off
   //of the slower pixel clock (so they can recover a clock of about 742.5 MHz from
   //the slower 74.25 MHz clock)
   OBUFDS OBUFDS_blue (.I(tmds_signal[0]), .O(hdmi_tx_p[0]), .OB(hdmi_tx_n[0]));
   OBUFDS OBUFDS_green(.I(tmds_signal[1]), .O(hdmi_tx_p[1]), .OB(hdmi_tx_n[1]));
   OBUFDS OBUFDS_red  (.I(tmds_signal[2]), .O(hdmi_tx_p[2]), .OB(hdmi_tx_n[2]));
   OBUFDS OBUFDS_clock(.I(clk_pixel), .O(hdmi_clk_p), .OB(hdmi_clk_n));

endmodule