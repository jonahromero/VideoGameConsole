// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Thu Dec  5 18:50:38 2024
// Host        : eecs-digital-10 running 64-bit Ubuntu 24.04.1 LTS
// Command     : write_verilog -force -mode synth_stub /home/kengcol/VideoGameConsole/console_hw/ip/rf24/rf24_stub.v
// Design      : rf24
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2024.1" *)
module rf24(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9, probe10, probe11, probe12, probe13, probe14, probe15, probe16, probe17, 
  probe18, probe19, probe20, probe21, probe22, probe23)
/* synthesis syn_black_box black_box_pad_pin="probe0[31:0],probe1[31:0],probe2[31:0],probe3[31:0],probe4[31:0],probe5[31:0],probe6[31:0],probe7[31:0],probe8[31:0],probe9[31:0],probe10[31:0],probe11[31:0],probe12[31:0],probe13[31:0],probe14[31:0],probe15[31:0],probe16[31:0],probe17[31:0],probe18[31:0],probe19[31:0],probe20[31:0],probe21[31:0],probe22[31:0],probe23[31:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input clk /* synthesis syn_isclock = 1 */;
  input [31:0]probe0;
  input [31:0]probe1;
  input [31:0]probe2;
  input [31:0]probe3;
  input [31:0]probe4;
  input [31:0]probe5;
  input [31:0]probe6;
  input [31:0]probe7;
  input [31:0]probe8;
  input [31:0]probe9;
  input [31:0]probe10;
  input [31:0]probe11;
  input [31:0]probe12;
  input [31:0]probe13;
  input [31:0]probe14;
  input [31:0]probe15;
  input [31:0]probe16;
  input [31:0]probe17;
  input [31:0]probe18;
  input [31:0]probe19;
  input [31:0]probe20;
  input [31:0]probe21;
  input [31:0]probe22;
  input [31:0]probe23;
endmodule
