
�
Command: %s
1870*	planAhead2~
|read_checkpoint -auto_incremental -incremental C:/Users/Kenne/project_1/project_1.srcs/utils_1/imports/synth_1/top_level.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2O
MC:/Users/Kenne/project_1/project_1.srcs/utils_1/imports/synth_1/top_level.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
d
Command: %s
53*	vivadotcl23
1synth_design -top top_level -part xc7s50csga324-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
y
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2
xc7s50Z17-347h px� 
i
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2
xc7s50Z17-349h px� 
D
Loading part %s157*device2
xc7s50csga324-1Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
M
#Helper process launched with PID %s4824*oasys2
9756Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:06 ; elapsed = 00:00:08 . Memory (MB): peak = 1017.504 ; gain = 465.336
h px� 
�
.identifier '%s' is used before its declaration4750*oasys2
	clk_pixel2Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
278@Z8-6901h px� 
�
.identifier '%s' is used before its declaration4750*oasys2
ram_data_out2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
1628@Z8-6901h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2	
TIMEOUT2	
spi_con2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/spi_con.sv2
278@Z8-11065h px� 
�
.identifier '%s' is used before its declaration4750*oasys2
TOTAL_WIDTH2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
168@Z8-6901h px� 
�
.identifier '%s' is used before its declaration4750*oasys2
TOTAL_LINES2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
178@Z8-6901h px� 
�
synthesizing module '%s'%s4497*oasys2
	top_level2
 2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
48@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

memory_bus2
 2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
148@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

memory_bus2
 2
02
12[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
148@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
frame_buffer_bus2
 2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/frame_buffer.sv2
58@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
frame_buffer_bus2
 2
02
12Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/frame_buffer.sv2
58@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

sys_io_bus2
 2T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/sys_io.sv2
78@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

sys_io_bus2
 2
02
12T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/sys_io.sv2
78@Z8-6155h px� 
�
&Input port '%s' has an internal driver4442*oasys2
jab_in2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
768@Z8-6104h px� 
�
&Input port '%s' has an internal driver4442*oasys2
jab_in2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
778@Z8-6104h px� 
�
synthesizing module '%s'%s4497*oasys2
program_memory_bus2
 2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
28@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
program_memory_bus2
 2
02
12Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
28@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

rom_io_bus2
 2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
58@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

rom_io_bus2
 2
02
12U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
58@Z8-6155h px� 
�
&Input port '%s' has an internal driver4442*oasys2
pmodb2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
828@Z8-6104h px� 
�
&Input port '%s' has an internal driver4442*oasys2
btn2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
828@Z8-6104h px� 
�
synthesizing module '%s'%s4497*oasys2
seven_segment_controller2
 2d
`C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/seven_segment_controller.sv2
38@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
bto7s2
 2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/lab05_ssc.sv2
958@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bto7s2
 2
02
12U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/lab05_ssc.sv2
958@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
seven_segment_controller2
 2
02
12d
`C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/seven_segment_controller.sv2
38@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
sys_io2
 2T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/sys_io.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2	
spi_con2
 2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/spi_con.sv2
58@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

pipeline2
 2T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/pipeline.sv2
48@Z8-6157h px� 
I
%s
*synth21
/	Parameter STAGES bound to: 3 - type: integer 
h p
x
� 
H
%s
*synth20
.	Parameter WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

pipeline2
 2
02
12T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/pipeline.sv2
48@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
spi_con2
 2
02
12U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/spi_con.sv2
58@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/sys_io.sv2
528@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
sys_io2
 2
02
12T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/sys_io/sys_io.sv2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
program_memory2
 2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
268@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

rom_reader2
 2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
188@Z8-6157h px� 
U
%s
*synth2=
;	Parameter TOTAL_ADDRESSES bound to: 8192 - type: integer 
h p
x
� 
�
-case statement is not full and has no default155*oasys2U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
558@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

rom_reader2
 2
02
12U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
188@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
678@Z8-155h px� 
�
synthesizing module '%s'%s4497*oasys2
pipeline__parameterized02
 2T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/pipeline.sv2
48@Z8-6157h px� 
I
%s
*synth21
/	Parameter STAGES bound to: 2 - type: integer 
h p
x
� 
H
%s
*synth20
.	Parameter WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pipeline__parameterized02
 2
02
12T
PC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/util/pipeline.sv2
48@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2.
,xilinx_true_dual_port_read_first_2_clock_ram2
 2y
uC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/xilinx_true_dual_port_read_first_2_clock_ram.v2
108@Z8-6157h px� 
M
%s
*synth25
3	Parameter RAM_WIDTH bound to: 32 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter RAM_DEPTH bound to: 2048 - type: integer 
h p
x
� 
`
%s
*synth2H
F	Parameter RAM_PERFORMANCE bound to: HIGH_PERFORMANCE - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2.
,xilinx_true_dual_port_read_first_2_clock_ram2
 2
02
12y
uC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/xilinx_true_dual_port_read_first_2_clock_ram.v2
108@Z8-6155h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
162
addra2
112.
,xilinx_true_dual_port_read_first_2_clock_ram2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
1138@Z8-689h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
322
addrb2
112.
,xilinx_true_dual_port_read_first_2_clock_ram2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
1258@Z8-689h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
program_memory2
 2
02
12Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
268@Z8-6155h px� 
�
&Input port '%s' has an internal driver4442*oasys2
btn2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
938@Z8-6104h px� 
�
synthesizing module '%s'%s4497*oasys2
frame_buffer2
 2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/frame_buffer.sv2
478@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
blk_mem_gen_02
 2s
oC:/Users/Kenne/project_1/project_1.runs/synth_1/.Xil/Vivado-23976-DESKTOP-E1HIIUJ/realtime/blk_mem_gen_0_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
blk_mem_gen_02
 2
02
12s
oC:/Users/Kenne/project_1/project_1.runs/synth_1/.Xil/Vivado-23976-DESKTOP-E1HIIUJ/realtime/blk_mem_gen_0_stub.v2
68@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
frame_buffer2
 2
02
12Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/frame_buffer.sv2
478@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
hdmi2
 2Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
58@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
cw_hdmi_clk_wiz2
 2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/cw_hdmi_clk_wiz.v2
698@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
IBUF2
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
758258@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IBUF2
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
758258@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

MMCME2_ADV2
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
845888@Z8-6157h px� 
S
%s
*synth2;
9	Parameter BANDWIDTH bound to: OPTIMIZED - type: string 
h p
x
� 
Y
%s
*synth2A
?	Parameter CLKFBOUT_MULT_F bound to: 37.125000 - type: double 
h p
x
� 
W
%s
*synth2?
=	Parameter CLKFBOUT_PHASE bound to: 0.000000 - type: double 
h p
x
� 
Z
%s
*synth2B
@	Parameter CLKFBOUT_USE_FINE_PS bound to: FALSE - type: string 
h p
x
� 
W
%s
*synth2?
=	Parameter CLKIN1_PERIOD bound to: 10.000000 - type: double 
h p
x
� 
Z
%s
*synth2B
@	Parameter CLKOUT0_DIVIDE_F bound to: 10.000000 - type: double 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT0_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
V
%s
*synth2>
<	Parameter CLKOUT0_PHASE bound to: 0.000000 - type: double 
h p
x
� 
Y
%s
*synth2A
?	Parameter CLKOUT0_USE_FINE_PS bound to: FALSE - type: string 
h p
x
� 
Q
%s
*synth29
7	Parameter CLKOUT1_DIVIDE bound to: 2 - type: integer 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT1_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
V
%s
*synth2>
<	Parameter CLKOUT1_PHASE bound to: 0.000000 - type: double 
h p
x
� 
Y
%s
*synth2A
?	Parameter CLKOUT1_USE_FINE_PS bound to: FALSE - type: string 
h p
x
� 
U
%s
*synth2=
;	Parameter CLKOUT4_CASCADE bound to: FALSE - type: string 
h p
x
� 
R
%s
*synth2:
8	Parameter COMPENSATION bound to: ZHOLD - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DIVCLK_DIVIDE bound to: 5 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter STARTUP_WAIT bound to: FALSE - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

MMCME2_ADV2
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
845888@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
BUFG2
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2
26768@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
BUFG2
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2
26768@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
cw_hdmi_clk_wiz2
 2
02
12[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/cw_hdmi_clk_wiz.v2
698@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
locked2
cw_hdmi_clk_wiz2
wizard_hdmi2Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
328@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
wizard_hdmi2
cw_hdmi_clk_wiz2
52
42Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
328@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
video_sig_gen2
 2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
18@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
618@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
468@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
video_sig_gen2
 2
02
12Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/video_sig_gen.sv2
18@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
rst_in2

pipeline2
ps3_32Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
898@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
ps3_32

pipeline2
42
32Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
898@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
rst_in2

pipeline2
ps3_42Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
908@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
ps3_42

pipeline2
42
32Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
908@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
rst_in2

pipeline2
ps3_52Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
918@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
ps3_52

pipeline2
42
32Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
918@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
rst_in2

pipeline2
ps3_62Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
928@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
ps3_62

pipeline2
42
32Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
928@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
tmds_encoder2
 2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
498@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
bit_counter2
 2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
68@Z8-6157h px� 
G
%s
*synth2/
-	Parameter SIZE bound to: 8 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bit_counter2
 2
02
12Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	tm_choice2
 2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
228@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	tm_choice2
 2
02
12Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
228@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tmds_encoder2
 2
02
12Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_encoder.sv2
498@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
tmds_serializer2
 2\
XC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_serializer.sv2
48@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	OSERDESE22
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1036798@Z8-6157h px� 
P
%s
*synth28
6	Parameter DATA_RATE_OQ bound to: DDR - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DATA_RATE_TQ bound to: SDR - type: string 
h p
x
� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 10 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter SERDES_MODE bound to: MASTER - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_CTL bound to: FALSE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_SRC bound to: FALSE - type: string 
h p
x
� 
Q
%s
*synth29
7	Parameter TRISTATE_WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	OSERDESE22
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1036798@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OSERDESE2__parameterized02
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1036798@Z8-6157h px� 
P
%s
*synth28
6	Parameter DATA_RATE_OQ bound to: DDR - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DATA_RATE_TQ bound to: SDR - type: string 
h p
x
� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 10 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter SERDES_MODE bound to: SLAVE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_CTL bound to: FALSE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_SRC bound to: FALSE - type: string 
h p
x
� 
Q
%s
*synth29
7	Parameter TRISTATE_WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OSERDESE2__parameterized02
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1036798@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tmds_serializer2
 2
02
12\
XC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/tmds_serializer.sv2
48@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OBUFDS2
 29
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
994428@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OBUFDS2
 2
02
129
5D:/Xilinx/Vivado/2024.2/scripts/rt/data/unisim_comp.v2	
994428@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
hdmi2
 2
02
12Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
58@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
memory_system2
 2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
mmio_mappings2
 2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
348@Z8-6157h px� 
�
default block is never used226*oasys2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
438@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mmio_mappings2
 2
02
12[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
348@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
1198@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
1248@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
2008@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
1138@Z8-155h px� 
�
synthesizing module '%s'%s4497*oasys2#
!xilinx_single_port_ram_read_first2
 2o
kC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/xilinx_single_port_ram_read_first.sv2
108@Z8-6157h px� 
L
%s
*synth24
2	Parameter RAM_WIDTH bound to: 8 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter RAM_DEPTH bound to: 65536 - type: integer 
h p
x
� 
`
%s
*synth2H
F	Parameter RAM_PERFORMANCE bound to: HIGH_PERFORMANCE - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!xilinx_single_port_ram_read_first2
 2
02
12o
kC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/xilinx_single_port_ram_read_first.sv2
108@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
memory_system2
 2
02
12[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
538@Z8-6155h px� 
�
Pwidth (%s) of port connection '%s' does not match port width (%s) of module '%s'689*oasys2
142
	debug_led2
132
memory_system2P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
1158@Z8-689h px� 
�
synthesizing module '%s'%s4497*oasys2
cpu2
 2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1108@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
fetch2
 2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
488@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fetch2
 2
02
12a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
488@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2^
ZC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/decode.sv2
538@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
cpu2
 2
02
12a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1108@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	top_level2
 2
02
12P
LC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/top_level.sv2
48@Z8-6155h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2	
display2
program_memory2Y
UC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/program_memory.sv2
318@Z8-3848h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
buffer_flag_reg2Z
VC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/frame_buffer.sv2
688@Z8-6014h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

signal_clk2
hdmi2Q
MC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/video/hdmi.sv2
148@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2!
program_mem_bus\.read_request_b2
memory_system2[
WC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/memory/memory_system.sv2
628@Z8-3848h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
fetch_pc_p1_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
638@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
	cycle_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
3538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2

instrs_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
3548@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
e2w_reg[pc]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
3558@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
d2e_reg[dInst][src1]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
3568@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
d2e_reg[dInst][src2]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
3568@Z8-6014h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
mem_bus\.dispatch_read_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1988@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
mem_bus\.dispatch_write_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1998@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
e2w_tp_reg[iType]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
e2w_tp_reg[dst]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
e2w_tp_reg[memFunc]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
e2w_tp_reg[data]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
e2w_tp_reg[isValid]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
mem_bus\.addr_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2658@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
mem_bus\.mem_width_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2668@Z8-87h px� 
�
9always_comb on '%s' did not result in combinational logic87*oasys2
mem_bus\.write_data_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2738@Z8-87h px� 
i
+design %s has port %s driven by constant %s3447*oasys2
	top_level2
led[0]2
1Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[2]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[1]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[0]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[2]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[1]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[0]2
0Z8-3917h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[31]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[30]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[29]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[28]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[27]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[26]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[25]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[24]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[23]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[22]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[21]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[20]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[19]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[18]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[17]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[16]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[15]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[14]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[13]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[12]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[11]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[10]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[9]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[8]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[7]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[6]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[5]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[4]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[3]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[2]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[1]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.addr_b[0]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[31]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[30]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[29]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[28]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[27]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[26]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[25]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[24]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[23]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[22]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[21]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[20]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[19]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[18]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[17]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[16]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[15]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[14]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[13]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[12]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[11]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[10]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[9]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[8]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[7]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[6]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[5]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[4]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[3]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[2]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[1]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.instr_b[0]2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
program_mem_bus\.read_request_b2
fetchZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
program_mem_bus\.data_valid_b2
fetchZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[31]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[30]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[29]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[28]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[27]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[26]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[25]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[24]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[23]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[22]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[21]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[20]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[19]2
mmio_mappingsZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[18]2
mmio_mappingsZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2!
program_mem_bus\.read_request_b2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
io_bus\.chip_data_raw2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
io_bus\.chip_clk_raw2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.read_clk2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[9]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[8]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[7]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[6]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[5]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[4]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[3]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[2]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[1]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.vcount[0]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[10]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[9]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[8]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[7]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[6]2
memory_systemZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
fb_bus\.hcount[5]2
memory_systemZ8-7129h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-71292
100Z17-14h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:13 ; elapsed = 00:00:16 . Memory (MB): peak = 1207.680 ; gain = 655.512
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:13 ; elapsed = 00:00:16 . Memory (MB): peak = 1207.680 ; gain = 655.512
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:13 ; elapsed = 00:00:16 . Memory (MB): peak = 1207.680 ; gain = 655.512
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0982

1207.6802
0.000Z17-268h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
5Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2w
sc:/Users/Kenne/Documents/GitHub/project_1.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0/blk_mem_gen_0_in_context.xdc2*
&m_frame_buffer/genblk1[0].frame_buffer	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2w
sc:/Users/Kenne/Documents/GitHub/project_1.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0/blk_mem_gen_0_in_context.xdc2*
&m_frame_buffer/genblk1[0].frame_buffer	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2C
?C:/Users/Kenne/project_1/project_1.srcs/constrs_1/new/dummy.xdc8Z20-179h px� 
�
No nets matched '%s'.
507*	planAhead2

m_cpu/E[0]2C
?C:/Users/Kenne/project_1/project_1.srcs/constrs_1/new/dummy.xdc2
18@Z12-507h px�
�
Finished Parsing XDC File [%s]
178*designutils2C
?C:/Users/Kenne/project_1/project_1.srcs/constrs_1/new/dummy.xdc8Z20-178h px� 
�
�One or more constraints failed evaluation while reading constraint file [%s] and the design contains unresolved black boxes. These constraints will be read post-synthesis (as long as their source constraint file is marked as used_in_implementation) and should be applied correctly then. You should review the constraints listed in the file [%s] and check the run log file to verify that these constraints were correctly applied.301*project2A
?C:/Users/Kenne/project_1/project_1.srcs/constrs_1/new/dummy.xdc2
.Xil/top_level_propImpl.xdcZ1-498h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1289.7112
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2h
f  A total of 4 instances were transformed.
  OBUFDS => OBUFDS_DUAL_BUF (INV, OBUFDS(x2)): 4 instances
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.1252

1289.7112
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:24 ; elapsed = 00:00:35 . Memory (MB): peak = 1289.711 ; gain = 737.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7s50csga324-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:24 ; elapsed = 00:00:35 . Memory (MB): peak = 1289.711 ; gain = 737.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:24 ; elapsed = 00:00:35 . Memory (MB): peak = 1289.711 ; gain = 737.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
j
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
sys_ioZ8-802h px� 
n
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2

rom_readerZ8-802h px� 
q
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
memory_systemZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                 WAITING |                              001 | 00000000000000000000000000000000
h p
x
� 
y
%s
*synth2a
_       RECEIVING_BUTTONS |                              010 | 00000000000000000000000000000001
h p
x
� 
y
%s
*synth2a
_      RECEIVING_JOYSTICK |                              100 | 00000000000000000000000000000010
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2
sys_ioZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_              LATCH_HIGH |                              000 | 00000000000000000000000000000000
h p
x
� 
y
%s
*synth2a
_             SETUP_LATCH |                              001 | 00000000000000000000000000000001
h p
x
� 
y
%s
*synth2a
_              HOLD_LATCH |                              010 | 00000000000000000000000000000010
h p
x
� 
y
%s
*synth2a
_               LATCH_LOW |                              011 | 00000000000000000000000000000011
h p
x
� 
y
%s
*synth2a
_           WAIT_FOR_DATA |                              100 | 00000000000000000000000000000100
h p
x
� 
y
%s
*synth2a
_               NEXT_ADDR |                              101 | 00000000000000000000000000000101
h p
x
� 
y
%s
*synth2a
_                FINISHED |                              110 | 00000000000000000000000000000110
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2

rom_readerZ8-3354h px� 
�
?The signal %s was recognized as a true dual port RAM template.
3473*oasys2:
8"xilinx_true_dual_port_read_first_2_clock_ram:/BRAM_reg"Z8-3971h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 

%s
*synth2
*
h p
x
� 
y
%s
*synth2a
_                 WAITING | 00000000000000000000000000000001 | 00000000000000000000000000000001
h p
x
� 
y
%s
*synth2a
_                READ_MEM | 00000000000000000000000000000010 | 00000000000000000000000000000010
h p
x
� 
y
%s
*synth2a
_                 SEND_WE | 00000000000000000000000000001000 | 00000000000000000000000000001000
h p
x
� 
y
%s
*synth2a
_               WRITE_MEM | 00000000000000000000000000000100 | 00000000000000000000000000000100
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
v
6No Re-encoding of one hot register '%s' in module '%s'3445*oasys2
	state_reg2
memory_systemZ8-3898h px� 
�
!inferring latch for variable '%s'327*oasys2
mem_bus\.addr_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2658@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
mem_bus\.write_data_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2738@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
mem_bus\.dispatch_read_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1988@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
mem_bus\.dispatch_write_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
1998@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
mem_bus\.mem_width_reg2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2668@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
e2w_tp_reg[dst]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
e2w_tp_reg[memFunc]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
e2w_tp_reg[iType]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
e2w_tp_reg[isValid]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
e2w_tp_reg[data]2a
]C:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/cpu/BasicVersion/processor.sv2
2578@Z8-327h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:26 ; elapsed = 00:00:38 . Memory (MB): peak = 1289.711 ; gain = 737.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input   17 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   14 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   13 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   5 Input    5 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    5 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 5     
h p
x
� 
F
%s
*synth2.
,	   8 Input    4 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit       Adders := 2     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input     32 Bit         XORs := 1     
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 39    
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 51    
h p
x
� 
H
%s
*synth20
.	               17 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               13 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               11 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                9 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 14    
h p
x
� 
H
%s
*synth20
.	                7 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                6 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 8     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 38    
h p
x
� 
&
%s
*synth2
+---RAMs : 
h p
x
� 
Y
%s
*synth2A
?	             512K Bit	(65536 X 8 bit)          RAMs := 1     
h p
x
� 
Y
%s
*synth2A
?	              64K Bit	(2048 X 32 bit)          RAMs := 1     
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   5 Input   32 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   6 Input   32 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit        Muxes := 40    
h p
x
� 
F
%s
*synth2.
,	   4 Input   32 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input   32 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   17 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   4 Input   17 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input   13 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit        Muxes := 10    
h p
x
� 
F
%s
*synth2.
,	   4 Input   10 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 12    
h p
x
� 
F
%s
*synth2.
,	   6 Input    8 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   5 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    6 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 20    
h p
x
� 
F
%s
*synth2.
,	   3 Input    5 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   9 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   6 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   4 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   7 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   7 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   4 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   5 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 160   
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   7 Input    1 Bit        Muxes := 9     
h p
x
� 
F
%s
*synth2.
,	   5 Input    1 Bit        Muxes := 11    
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 5     
h p
x
� 
F
%s
*synth2.
,	   6 Input    1 Bit        Muxes := 6     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 120 (col length:60)
BRAMs: 150 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2
reader/addr_out_reg2
162
132U
QC:/Users/Kenne/Documents/GitHub/VideoGameConsole/console_hw/hdl/rom/rom_reader.sv2
878@Z8-3936h px� 
i
+design %s has port %s driven by constant %s3447*oasys2
	top_level2
led[0]2
1Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[2]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[1]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb0[0]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[2]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[1]2
0Z8-3917h px� 
j
+design %s has port %s driven by constant %s3447*oasys2
	top_level2	
rgb1[0]2
0Z8-3917h px� 
l
+Unused sequential element %s was removed. 
4326*oasys2
program_mem/icache/BRAM_regZ8-6014h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[31]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[30]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[29]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[28]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[27]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[26]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[25]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[24]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[23]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[22]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[21]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[20]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[19]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.addr_reg[18]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
mem_bus\.mem_width_reg[2]2
cpuZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
e2w_tp_reg[iType][31]2
cpuZ8-3332h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:49 ; elapsed = 00:01:01 . Memory (MB): peak = 1465.355 ; gain = 913.188
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
R
%s*synth2:
8
Block RAM: Preliminary Mapping Report (see note below)
h px� 
�
%s*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h px� 
�
%s*synth2�
�|Module Name | RTL Object                  | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
h px� 
�
%s*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h px� 
�
%s*synth2�
�|top_level   | program_mem/icache/BRAM_reg | 2 K x 32(READ_FIRST)   | W | R | 2 K x 32(WRITE_FIRST)  |   | R | Port A and B     | 0      | 2      | 
h px� 
�
%s*synth2�
�|top_level   | ms/ram/BRAM_reg             | 64 K x 8(READ_FIRST)   | W | R |                        |   |   | Port A           | 0      | 16     | 
h px� 
�
%s*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

h px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the Block RAMs at the current stage of the synthesis flow. Some Block RAMs may be reimplemented as non Block RAM primitives later in the synthesis flow. Multiple instantiated Block RAMs are reported only once. 
h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:56 ; elapsed = 00:01:08 . Memory (MB): peak = 1465.355 ; gain = 913.188
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:56 ; elapsed = 00:01:09 . Memory (MB): peak = 1465.355 ; gain = 913.188
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!
Block RAM: Final Mapping Report
h p
x
� 
�
%s
*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h p
x
� 
�
%s
*synth2�
�|Module Name | RTL Object                  | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
h p
x
� 
�
%s
*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
h p
x
� 
�
%s
*synth2�
�|top_level   | program_mem/icache/BRAM_reg | 2 K x 32(READ_FIRST)   | W | R | 2 K x 32(WRITE_FIRST)  |   | R | Port A and B     | 0      | 2      | 
h p
x
� 
�
%s
*synth2�
�|top_level   | ms/ram/BRAM_reg             | 64 K x 8(READ_FIRST)   | W | R |                        |   |   | Port A           | 0      | 16     | 
h p
x
� 
�
%s
*synth2�
�+------------+-----------------------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:57 ; elapsed = 00:01:10 . Memory (MB): peak = 1465.355 ; gain = 913.188
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2y
wFinished IO Insertion : Time (s): cpu = 00:01:03 ; elapsed = 00:01:15 . Memory (MB): peak = 1587.207 ; gain = 1035.039
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:01:03 ; elapsed = 00:01:15 . Memory (MB): peak = 1587.207 ; gain = 1035.039
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:01:03 ; elapsed = 00:01:15 . Memory (MB): peak = 1587.207 ; gain = 1035.039
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:01:03 ; elapsed = 00:01:15 . Memory (MB): peak = 1587.207 ; gain = 1035.039
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:01:03 ; elapsed = 00:01:16 . Memory (MB): peak = 1589.371 ; gain = 1037.203
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:01:03 ; elapsed = 00:01:16 . Memory (MB): peak = 1589.371 ; gain = 1037.203
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|      |BlackBox name |Instances |
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|1     |blk_mem_gen_0 |         1|
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
7
%s*synth2
+------+------------+------+
h px� 
7
%s*synth2
|      |Cell        |Count |
h px� 
7
%s*synth2
+------+------------+------+
h px� 
7
%s*synth2
|1     |blk_mem_gen |     1|
h px� 
7
%s*synth2
|2     |BUFG        |     6|
h px� 
7
%s*synth2
|3     |CARRY4      |    80|
h px� 
7
%s*synth2
|4     |LUT1        |    89|
h px� 
7
%s*synth2
|5     |LUT2        |   183|
h px� 
7
%s*synth2
|6     |LUT3        |   144|
h px� 
7
%s*synth2
|7     |LUT4        |   248|
h px� 
7
%s*synth2
|8     |LUT5        |   356|
h px� 
7
%s*synth2
|9     |LUT6        |  1277|
h px� 
7
%s*synth2
|10    |MMCME2_ADV  |     1|
h px� 
7
%s*synth2
|11    |MUXF7       |    40|
h px� 
7
%s*synth2
|12    |MUXF8       |     2|
h px� 
7
%s*synth2
|13    |OSERDESE2   |     6|
h px� 
7
%s*synth2
|15    |RAMB36E1    |    18|
h px� 
7
%s*synth2
|18    |FDRE        |  1635|
h px� 
7
%s*synth2
|19    |FDSE        |    44|
h px� 
7
%s*synth2
|20    |LD          |    52|
h px� 
7
%s*synth2
|21    |LDC         |    42|
h px� 
7
%s*synth2
|22    |LDCP        |     3|
h px� 
7
%s*synth2
|23    |LDP         |     3|
h px� 
7
%s*synth2
|24    |IBUF        |    12|
h px� 
7
%s*synth2
|25    |OBUF        |    52|
h px� 
7
%s*synth2
|26    |OBUFDS      |     4|
h px� 
7
%s*synth2
|27    |OBUFT       |     3|
h px� 
7
%s*synth2
+------+------------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:01:03 ; elapsed = 00:01:16 . Memory (MB): peak = 1589.371 ; gain = 1037.203
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
b
%s
*synth2J
HSynthesis finished with 0 errors, 0 critical warnings and 373 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:47 ; elapsed = 00:01:05 . Memory (MB): peak = 1589.371 ; gain = 955.172
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:01:03 ; elapsed = 00:01:16 . Memory (MB): peak = 1589.371 ; gain = 1037.203
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0682

1594.6762
0.000Z17-268h px� 
U
-Analyzing %s Unisim elements for replacement
17*netlist2
245Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1602.9962
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2�
�  A total of 104 instances were transformed.
  LD => LDCE: 52 instances
  LDC => LDCE: 42 instances
  LDCP => LDCP (GND, LDCE, LUT3(x2), VCC): 3 instances
  LDP => LDPE: 3 instances
  OBUFDS => OBUFDS_DUAL_BUF (INV, OBUFDS(x2)): 4 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

c68e3acfZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1112
1882
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:01:082

00:01:272

1602.9962

1226.160Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0142

1602.9962
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2?
=C:/Users/Kenne/project_1/project_1.runs/synth_1/top_level.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2]
[report_utilization -file top_level_utilization_synth.rpt -pb top_level_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Sun Dec  8 07:44:13 2024Z17-206h px� 


End Record