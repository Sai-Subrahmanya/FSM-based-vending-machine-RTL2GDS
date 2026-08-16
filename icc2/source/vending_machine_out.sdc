###################################################################

# Created by write_sdc

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_load -pin_load 0.02 [get_ports out]
set_load -pin_load 0.02 [get_ports {change[1]}]
set_load -pin_load 0.02 [get_ports {change[0]}]
create_clock [get_ports Clock]  -period 5  -waveform {0 2.5}
set_clock_uncertainty -setup 0.2  [get_clocks Clock]
set_clock_uncertainty -hold 0.02  [get_clocks Clock]
set_input_delay -clock Clock  -max 1  [get_ports {in[1]}]
set_input_delay -clock Clock  -min 0  [get_ports {in[1]}]
set_input_delay -clock Clock  -max 1  [get_ports {in[0]}]
set_input_delay -clock Clock  -min 0  [get_ports {in[0]}]
set_output_delay -clock Clock  -max 1  [get_ports out]
set_output_delay -clock Clock  -min 0  [get_ports out]
set_output_delay -clock Clock  -max 1  [get_ports {change[1]}]
set_output_delay -clock Clock  -min 0  [get_ports {change[1]}]
set_output_delay -clock Clock  -max 1  [get_ports {change[0]}]
set_output_delay -clock Clock  -min 0  [get_ports {change[0]}]
set_input_transition -max 0.1  [get_ports {in[1]}]
set_input_transition -min 0.1  [get_ports {in[1]}]
set_input_transition -max 0.1  [get_ports {in[0]}]
set_input_transition -min 0.1  [get_ports {in[0]}]

