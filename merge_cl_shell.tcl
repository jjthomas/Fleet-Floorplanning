open_checkpoint /home/jamestho/2_hole_shell_old.dcp
read_checkpoint -cell WRAPPER_INST/CL /home/jamestho/merged_shell_kernel.dcp
# set_property INIT "2'h2" [get_cells -hierarchical -filter NAME=~*if/klut*]
# set_property INIT "2'h2" [get_cells -hierarchical -filter NAME=~*if/slut*]
# set_property INIT "2'h2" [get_cells -hierarchical -filter NAME=~*reset_buf*]
# llength [get_cells -hierarchical -filter {STATUS!~"FIXED" && STATUS!~"PLACED" && NAME=~"streaming_wrapper/*" && NAME!~"*VCC*" && NAME!~"*GND*"}] 
# source /home/jamestho/place_unplaced_if_luts.tcl
# route_design -physical_nets
# update_clock_routing
# route_design -nets [get_nets WRAPPER_INST/SH/kernel_clks_i/clkwiz_sys_clk/inst/CLK_CORE_DRP_I/clk_inst/clk_out1]
