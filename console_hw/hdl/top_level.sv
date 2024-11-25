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
   // gpio
   input wire [7:0] pmodb, pmoda,

   // hdmi port
   output logic [2:0]  hdmi_tx_p, //hdmi output signals (positives) (blue, green, red)
   output logic [2:0]  hdmi_tx_n, //hdmi output signals (negatives) (blue, green, red)
   output logic        hdmi_clk_p, hdmi_clk_n //differential hdmi clock
);
  logic sys_rst;
  assign rgb0 = 0;
  assign rgb1 = 0;
  logic clk_in;

  // debug numbers
  logic [31:0] val_to_display; //either the spi data or the btn_count data (default)
  // assign val_to_display = {};
  assign val_to_display = 32'hFF_FF_FF_FA;
  logic [6:0] ss_c;
  seven_segment_controller mssc(.clk_in(clk_in),
                                .rst_in(sys_rst),
                                .val_in(val_to_display),
                                .cat_out(ss_c),
                                .an_out({ss0_an, ss1_an}));
  assign ss0_c = ss_c;
  assign ss1_c = ss_c;

  // define high level busses
  memory_bus mem_bus();
  frame_buffer_bus fb_bus();
  sys_io_bus io_bus(
    .chip_data_raw(pmoda[2]),
    .chip_clk_raw(pmoda[3])
  );
  program_memory_bus program_mem_bus();
  rom_io_bus rom_io(.data(0));

  sys_io system_io(
    .clk_in(clk_in), .rst_in(sys_rst),
    .io_bus(io_bus.SYS_IO)
  );
  program_memory program_mem(
    .clk_in(clk_in),
    .rst_in(btn[0]),
    .sys_rst_out(sys_rst),
    .rom_io(rom_io.READER),
    .bus(program_mem_bus.PROGRAM_MEMORY_BUS)
  );
  frame_buffer m_frame_buffer(
    .rst_in(sys_rst),
    .bus(fb_bus.FRAME_BUFFER)
  );
  hdmi m_hdmi(
    .clk_100mhz(clk_100mhz),
    .new_clk_100mhz(clk_in),
    .rst_in(sys_rst),
    .hdmi_tx_p,
    .hdmi_tx_n,
    .hdmi_clk_p, 
    .hdmi_clk_n,
    .bus(fb_bus.READ)
  );
  memory_system ms(
    .rst_in(sys_rst), .clk_in(clk_in),
    .bus(mem_bus.MEMORY_SYSTEM),
    .fb_bus(fb_bus.WRITE),
    .io_bus(io_bus.CONSUMER)
  );
  cpu m_cpu(
    .rst_in(sys_rst), .clk_in(clk_in),
    .mem_bus(mem_bus.CONSUMER),
    .program_mem_bus(program_mem_bus.CONSUMER)
  );
endmodule // top_level


`default_nettype wire

