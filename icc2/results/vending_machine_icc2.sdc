################################################################################
#
# Design name:  vending_machine
#
# Created by icc2 write_sdc
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: func
# Corner: nom
# Scenario: func.nom

# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 12
create_clock -name Clock -period 5 -waveform {0 2.5} [get_ports {Clock}]
set_propagated_clock [get_clocks {Clock}]
set_load -pin_load 0.02 [get_ports {out}]
set_load -pin_load 0.02 [get_ports {change[1]}]
set_load -pin_load 0.02 [get_ports {change[0]}]
# Warning: Libcell power domain derates are skipped!

# Set latency for io paths.
# -origin useful_skew
set_clock_latency -min 9.53674e-05 [get_clocks {Clock}]
# -origin useful_skew
set_clock_latency -max 0.000114441 [get_clocks {Clock}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {Clock}]
set_clock_uncertainty -setup 0.2 [get_clocks {Clock}]
set_clock_uncertainty -hold 0.02 [get_clocks {Clock}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 25; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 26
set_input_transition 0.1 [get_ports {in[1]}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 27; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 28
set_input_transition 0.1 [get_ports {in[0]}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 15; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 16
set_input_delay -clock [get_clocks {Clock}] -min 0 [get_ports {in[1]}]
set_input_delay -clock [get_clocks {Clock}] -max 1 [get_ports {in[1]}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 17; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 18
set_input_delay -clock [get_clocks {Clock}] -min 0 [get_ports {in[0]}]
set_input_delay -clock [get_clocks {Clock}] -max 1 [get_ports {in[0]}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 19; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 20
set_output_delay -clock [get_clocks {Clock}] -min 0 [get_ports {out}]
set_output_delay -clock [get_clocks {Clock}] -max 1 [get_ports {out}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 21; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 22
set_output_delay -clock [get_clocks {Clock}] -min 0 [get_ports {change[1]}]
set_output_delay -clock [get_clocks {Clock}] -max 1 [get_ports {change[1]}]
# /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 23; \
#   /vending_machine/icc2/source/vending_machine_out.sdc, \
#   line 24
set_output_delay -clock [get_clocks {Clock}] -min 0 [get_ports {change[0]}]
set_output_delay -clock [get_clocks {Clock}] -max 1 [get_ports {change[0]}]
