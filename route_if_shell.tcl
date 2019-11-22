open_checkpoint if_shell.dcp
source lock_if.tcl

create_pblock pblock_CL_hole
resize_pblock pblock_CL_hole -add {CLOCKREGION_X0Y10:CLOCKREGION_X5Y14 CLOCKREGION_X0Y0:CLOCKREGION_X2Y9}
set exclude_file [open "if_shell_exclude.pblock" r]
set exclude [read -nonewline $exclude_file]
close $exclude_file
resize_pblock pblock_CL_hole -remove "$exclude"

add_cells_to_pblock pblock_CL_hole [get_cells]
remove_cells_from_pblock pblock_CL_hole [get_cells -hierarchical -filter NAME=~if*/klut*]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_CL_hole]

create_clock -period 8.000 -name clk [get_ports clock]
set_property HD.CLK_SRC BUFGCE_X1Y181 [get_ports clock]

place_design
route_design

reset_property HD.CLK_SRC [get_ports clock]
route_design -unroute -nets [get_nets clock0_pn]
reset_timing

delete_pblock pblock_CL_hole

remove_net [get_nets -of_objects [get_ports -filter NAME=~if*]]
remove_port [get_ports -filter NAME=~if*]
remove_net [get_nets -hierarchical -filter NAME=~*_kif]
set_property INIT "2'h0" [get_cells -hierarchical -filter NAME=~if*/klut*]

write_checkpoint -force if_shell_routed.dcp
write_edif -force if_shell_routed.edf
