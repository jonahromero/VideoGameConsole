vivado -mode batch -source build.tcl
#openFPGALoader -b arty_s7_50 final.bit

echo msgbox "Compilation Done" > %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
del %tmp%\tmp.vbs