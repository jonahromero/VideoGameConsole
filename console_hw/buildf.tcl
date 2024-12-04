
#set limits (don't change unless you're running local):
#if running remote, increasing threads will potentially cause your code to submission to get bounced
#due to a process watchdog.
set_param general.maxThreads 8
#Define target part and create output directory
# The Urbana Spartan 7 uses this chip:
# xc7s50 refers to the fact that it is a Spartan-7-50 FPGA
# csga324 refers to its package it is in
# refers to the "speed grade" of the chip

set partNum xc7s50csga324-1
set outputDir obj
file mkdir $outputDir
set files [glob -nocomplain "$outputDir/*"]
if {[llength $files] != 0} {
    # clear folder contents
    puts "deleting contents of $outputDir"
    file delete -force {*}[glob -directory $outputDir *];
} else {
    puts "$outputDir is empty"
}

proc get_files {dir extension} {
    set files [dict create]  ; # Use a dictionary to prevent duplicates
    puts "Searching in directory: $dir"
    foreach item [glob -nocomplain -directory $dir *] {
        if {[file isdirectory $item]} {
            puts "Found subdirectory: $item"
            set sub_files [get_files $item $extension]
            if {[dict size $sub_files] > 0} {
                set files [dict merge $files $sub_files]
            }
        } elseif {[string match *.$extension [file tail $item]]} {
            puts "Found file: $item"
            dict set files $item 1
        }
    }
    return $files
}

set sources_sv [dict keys [get_files ./hdl sv]]
set sources_v [dict keys [get_files ./hdl v]]

# readsystem verilog files
read_verilog -sv $sources_sv
# read in all (if any) verilog files:
if {[llength $sources_v] > 0 } {
    read_verilog $sources_v
}

# read in constraint files:
read_xdc [ glob ./xdc/*.xdc ]

# read in all (if any) hex memory files:
set sources_mem [ glob -nocomplain ./data/*.mem ]
if {[llength $sources_mem] > 0} {
    read_mem $sources_mem
}

# set the part number so Vivado knows how to build (each FPGA is different)
set_part $partNum

# Read in and synthesize all IP (first used in week 04!)
set sources_ip [ glob -nocomplain -directory ./ip -tails * ]
puts $sources_ip
foreach ip_source $sources_ip {
    if {[file isdirectory ./ip/$ip_source]} {
	read_ip ./ip/$ip_source/$ip_source.xci
    }
}
generate_target all [get_ips]
synth_ip [get_ips]

synth_design -top top_level -part $partNum
place_design -directive Quick
route_design -directive Quick
write_bitstream -force $outputDir/final.bit