###############################################################################
# reports.tcl
###############################################################################

source ../scripts/common_setup.tcl

file mkdir $REPORT_DIR

ac_redirect $REPORT_DIR/area.rpt {
    report_utilization
}

ac_redirect $REPORT_DIR/power.rpt {
    report_power
}

ac_redirect $REPORT_DIR/qor.rpt {
    report_qor
}

ac_redirect $REPORT_DIR/timing.rpt {
    report_timing -delay_type max -max_paths 10 -significant_digits 4
    report_timing -delay_type min -max_paths 10 -significant_digits 4
}

ac_redirect $REPORT_DIR/constraint.rpt {
    report_constraint -all_violators -verbose
}

ac_redirect $REPORT_DIR/physical.rpt {
    report_congestion
    report_clock_qor
}

set pg_nets [get_nets {VDD VSS}]

redirect -tee $REPORT_DIR/signoff.rpt "
    check_routes

    check_pg_connectivity

    check_pg_missing_vias \
        -nets \$pg_nets \
        -shape_use {lib_cell_pin_connect follow_pin} \
        -ignore_small_intersections \
        -filter_by_drc

    check_pg_drc
"

set summary_file $REPORT_DIR/summary.txt
set fp [open $summary_file w]

puts $fp "Vending Machine ICC2 final compact summary"
puts $fp "Generated at: [clock format [clock seconds]]"
puts $fp ""
puts $fp "Generated reports:"
puts $fp "  area.rpt"
puts $fp "  power.rpt"
puts $fp "  qor.rpt"
puts $fp "  timing.rpt"
puts $fp "  constraint.rpt"
puts $fp "  physical.rpt"
puts $fp "  signoff.rpt"
puts $fp ""

close $fp

catch {
    exec sh -c "echo '--- Area/utilization key lines ---' >> $summary_file; grep -Ei 'Utilization|Total Area|Total Capacity|Total Area of cells|Ratio' $REPORT_DIR/area.rpt >> $summary_file || true"
}

catch {
    exec sh -c "echo '\n--- Power key lines ---' >> $summary_file; grep -Ei 'Total Dynamic Power|Cell Leakage Power|Total ' $REPORT_DIR/power.rpt >> $summary_file || true"
}

catch {
    exec sh -c "echo '\n--- QoR key lines ---' >> $summary_file; grep -Ei 'WNS|TNS|violat|slack|Critical Path|Max Trans|Max Cap|Nets with Violations' $REPORT_DIR/qor.rpt >> $summary_file || true"
}

catch {
    exec sh -c "echo '\n--- Constraint key lines ---' >> $summary_file; grep -Ei 'VIOLATED|max_cap|max_transition|Total number of violation' $REPORT_DIR/constraint.rpt >> $summary_file || true"
}

catch {
    exec sh -c "echo '\n--- Signoff key lines ---' >> $summary_file; grep -Ei 'short violations|open nets|floating|missing vias|Total number of errors|Total number of DRCs|No errors found|TOTAL VIOLATIONS' $REPORT_DIR/signoff.rpt >> $summary_file || true"
}

puts "INFO: reports.tcl completed"
