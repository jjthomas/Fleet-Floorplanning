set name [lindex $argv 0]
open_checkpoint $env(AWS_FPGA)/hdk/cl/examples/cl_dram_dma/build/checkpoints/fleet_shell.dcp
read_checkpoint -cell WRAPPER_INST/CL merged_shell_kernel.dcp
report_route_status
report_timing -setup
report_timing -hold
write_checkpoint -force ${name}_combined.dcp

