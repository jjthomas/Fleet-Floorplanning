set verilog [lindex $argv 0]
set top [lindex $argv 1]
read_verilog $verilog
synth_design -part xcvu9p-flgb2104-2-i -top $top -mode out_of_context
opt_design

write_edif -force kernel_opt.edf
write_checkpoint -force kernel_opt.dcp

write_edif -force ${top}_opt.edf
write_checkpoint -force ${top}_opt.dcp
