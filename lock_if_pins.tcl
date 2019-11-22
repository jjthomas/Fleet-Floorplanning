set i 0
while 1 {
  set cells [get_cells -quiet -hierarchical -filter NAME=~*klut$i]
  if { [llength $cells] == 0 } { break }
  set pin [expr { $i % 2 == 0 ? "4" : "5" }]
  set_property LOCK_PINS I0:A$pin $cells
  incr i
}
