set idx [lindex $argv 0]
open_checkpoint if_kernel${idx}.dcp
lock_design -level routing
source lock_if_pins.tcl

create_pblock pblock_kernel
set range_file [open "if_kernel${idx}.pblock" r]
set range [read -nonewline $range_file]
close $range_file
resize_pblock pblock_kernel -add "$range"
add_cells_to_pblock pblock_kernel -top
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_kernel]

disconnect_net -net [get_nets clock0_pn] -objects [get_ports clock]
create_cell -reference BUFGCE clk_buf
place_cell clk_buf BUFGCE_X1Y181
connect_net -net [get_nets clock0_pn] -objects [get_pins clk_buf/O]
create_clock -period 8.000 -name clk [get_nets clock0_pn]
set_clock_uncertainty -hold 0.100 [get_clocks clk]

place_design
route_design

set pips_file [open "kernel_clock_pips_unfiltered${idx}.txt" w]
foreach pip [get_pips -of_objects [get_nets clock0_pn]] {
  puts $pips_file $pip
}
close $pips_file

route_design -unroute -nets [get_nets clock0_pn]
disconnect_net -net [get_nets clock0_pn] -objects [get_pins clk_buf/O]
remove_cell clk_buf
connect_net -net [get_nets clock0_pn] -objects [get_ports clock]
reset_timing

write_checkpoint -force if_kernel_routed${idx}.dcp
write_edif -force if_kernel_routed${idx}.edf
