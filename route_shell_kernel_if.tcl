set idx [lindex $argv 0]
open_checkpoint shell_kernel_if${idx}.dcp
source lock_if_pins.tcl

create_pblock pblock_top
set range_file [open "shell_kernel_if${idx}.pblock" r]
set range [read -nonewline $range_file]
close $range_file
resize_pblock pblock_top -add "$range"
add_cells_to_pblock pblock_top -top
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_top]

route_design
write_checkpoint -force shell_kernel_if_routed${idx}.dcp
write_edif -force shell_kernel_if_routed${idx}.edf
