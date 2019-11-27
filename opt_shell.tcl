set verilog [lindex $argv 0]
set top [lindex $argv 1]

read_verilog $verilog
synth_design -part xcvu9p-flgb2104-2-i -top $top -mode out_of_context
opt_design

write_edif -force shell_opt.edf
write_checkpoint -force shell_opt.dcp
