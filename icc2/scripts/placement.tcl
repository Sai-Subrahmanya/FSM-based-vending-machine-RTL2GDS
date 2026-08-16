###############################################################################
# placement.tcl
###############################################################################

source ../scripts/common_setup.tcl

ac_require_file $TLUPLUS_MAX
ac_require_file $TLUPLUS_MIN
ac_require_file $TLUPLUS_MAP

read_parasitic_tech \
    -tlup $TLUPLUS_MAX \
    -layermap $TLUPLUS_MAP \
    -name tlu_max

read_parasitic_tech \
    -tlup $TLUPLUS_MIN \
    -layermap $TLUPLUS_MAP \
    -name tlu_min

set_parasitic_parameters \
    -corner nom \
    -early_spec tlu_min \
    -late_spec tlu_max

set_ignored_layers \
    -min_routing_layer M2 \
    -max_routing_layer M8

place_opt

ac_connect_pg

save_block -as vending_machine_placement

puts "INFO: placement.tcl completed"
