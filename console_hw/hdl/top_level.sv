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
   output logic [7:0] pmoda,
   input  wire  [7:0] pmodb,
   input  wire  [2:0] jab_in,
   output logic [2:0] jab_out,

   // hdmi port
   output logic [2:0]  hdmi_tx_p, //hdmi output signals (positives) (blue, green, red)
   output logic [2:0]  hdmi_tx_n, //hdmi output signals (negatives) (blue, green, red)
   output logic        hdmi_clk_p, hdmi_clk_n //differential hdmi clock
);
  logic sys_rst;
  assign rgb0 = 0;
  assign rgb1 = 0;
  logic clk_in;
  logic [31:0] reg_file [31:0];
  logic [31:0] pc;

  // DEBUGGING
  // DEBUGGING SPI
  logic [31:0] val_to_display; //either the spi data or the btn_count data (default)
  /*logic[7:0] last_spi_byte;
  always_ff @(posedge clk_in) begin
    if (sw[0]) begin
      last_spi_byte <= io_bus.last_raw_byte;
    end
  end
  assign val_to_display = {io_bus.controller.buttons, io_bus.controller.joystick_x, io_bus.controller.joystick_y, last_spi_byte};*/
  // DEBUGGING ROM
  /*assign val_to_display = program_mem_bus.instr;
  assign program_mem_bus.addr = sw;
  assign program_mem_bus.read_request = 1;*/

  // DEBUGGING SYS_RST
  logic was_reset;
  always_ff @ (posedge clk_in) begin
    if (btn[0]) begin
      was_reset <= 0;
    end
    if (sys_rst) begin
      was_reset <= 1;
    end
  end
  assign led[0] = 1;
  assign led[1] = was_reset;

  logic [6:0] ss_c;
  seven_segment_controller mssc(.clk_in(clk_in),
                                .rst_in(sys_rst),
                                .val_in(val_to_display),
                                .cat_out(ss_c),
                                .an_out({ss0_an, ss1_an}));
  assign ss0_c = ss_c;
  assign ss1_c = ss_c;
  // DEBUGGING END

  // define high level busses
  memory_bus mem_bus();
  frame_buffer_bus fb_bus();
  sys_io_bus io_bus(
    .chip_data_raw(jab_in[1]),
    .chip_clk_raw(jab_in[2])
  );
  program_memory_bus program_mem_bus();

  // connect rom io to in/out ports
  rom_io_bus rom_io(.data(pmodb), .debug_button(btn[1]));
  assign pmoda = rom_io.addr;
  assign jab_out[0] = rom_io.latcher;

  sys_io system_io(
    .clk_in(clk_in), .rst_in(sys_rst),
    .io_bus(io_bus.SYS_IO)
  );
  program_memory program_mem(
    .display(val_to_display),
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
    .sw,
    .reg_file,
    .pc_in(pc),
    .bus(fb_bus.READ)
  );
  memory_system ms(
    .rst_in(sys_rst), .clk_in(clk_in),
    .debug_display(val_to_display),
    .bus(mem_bus.MEMORY_SYSTEM),
    .debug_led(led[15:2]),
    .fb_bus(fb_bus.WRITE),
    .io_bus(io_bus.CONSUMER),
    .program_mem_bus(program_mem_bus.CONSUMER_B)
  );
  simple_proc m_cpu(
    .rst_in(sys_rst), 
    .clk_in(clk_in),
    .sw,
    .mem_bus(mem_bus.CONSUMER),
    .program_mem_bus(program_mem_bus.CONSUMER_A),
    .reg_file,
    .pc_out(pc)
  );

endmodule // top_level


`default_nettype wire

