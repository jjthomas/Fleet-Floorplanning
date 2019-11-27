open_checkpoint $env(AWS_FPGA)/hdk/common/shell_stable/build/checkpoints/from_aws/SH_CL_BB_routed.dcp
read_checkpoint -cell WRAPPER_INST/CL merged_shell_kernel.dcp
write_checkpoint -force combined.dcp

