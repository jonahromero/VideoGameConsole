`timescale 1ns / 1ps
`default_nettype none

module top_level
  (
   input wire          clk_100mhz,
   output logic [15:0] led,
   
   input wire [15:0]   sw,
   input wire [3:0]    btn,
   output logic [2:0]  rgb0,
   output logic [2:0]  rgb1,
   // seven segment
   output logic [3:0]  ss0_an,//anode control for upper four digits of seven-seg display
   output logic [3:0]  ss1_an,//anode control for lower four digits of seven-seg display
   output logic [6:0]  ss0_c, //cathode controls for the segments of upper four digits
   output logic [6:0]  ss1_c, //cathod controls for the segments of lower four digits
   // hdmi port
   output logic [2:0]  hdmi_tx_p, //hdmi output signals (positives) (blue, green, red)
   output logic [2:0]  hdmi_tx_n, //hdmi output signals (negatives) (blue, green, red)
   output logic        hdmi_clk_p, hdmi_clk_n //differential hdmi clock
);
  logic sys_rst;
  assign sys_rst = btn[0];
  // shut up those RGBs
  assign rgb0 = 0;
  assign rgb1 = 0;
  
  frame_buffer_bus fb_bus();
  frame_buffer m_frame_buffer(
    .rst_in(sys_rst),
    .bus(fb_bus.FRAME_BUFFER)
  );
  hdmi m_hdmi(
    .clk_100mhz(clk_100mhz),
    .rst_in(sys_rst),
    .hdmi_tx_p,
    .hdmi_tx_n,
    .hdmi_clk_p, 
    .hdmi_clk_n,
    .bus(fb_bus.READ)
  );
  memory_system ms(
    .rst_in(sys_rst), .clk_in(clk_100mhz),
    .fb_bus(fb_bus.WRITE)
  );
endmodule // top_level


`default_nettype wire

