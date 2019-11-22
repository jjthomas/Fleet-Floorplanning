source lock_if_pins.tcl
set_property IS_ROUTE_FIXED 1 [get_nets -hierarchical -filter NAME=~*if*/ifn*]
set_property DONT_TOUCH 1 [get_cells -hierarchical -filter NAME=~*if*/klut*]
set_property DONT_TOUCH 1 [get_cells -hierarchical -filter NAME=~*if*/sff*]
