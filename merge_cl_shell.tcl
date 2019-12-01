set name [lindex $argv 0]
open_checkpoint $env(AWS_FPGA)/hdk/common/shell_stable/build/checkpoints/from_aws/SH_CL_BB_routed.dcp
read_checkpoint -cell WRAPPER_INST/CL merged_shell_kernel.dcp
report_timing_summary
write_checkpoint -force ${name}_combined.dcp

