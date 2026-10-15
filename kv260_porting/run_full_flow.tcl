set proj_dir "D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260"
open_project "$proj_dir/rocket_kv260.xpr"

puts "=== Resetting runs ==="
reset_run synth_1
reset_run impl_1

puts "=== Launching Synthesis ==="
launch_runs synth_1 -jobs 10
wait_on_run synth_1

set synth_status [get_property STATUS [get_runs synth_1]]
puts "=== Synthesis finished with status: $synth_status ==="

if {![string match "*Complete*" $synth_status]} {
    puts "ERROR: Synthesis failed!"
    close_project
    exit 1
}

# Open synthesized design to export synth report
open_run synth_1
report_utilization -file "$proj_dir/synth_utilization.rpt"
report_utilization -hierarchical -file "$proj_dir/synth_hier.rpt"
close_design

puts "=== Launching Implementation ==="
launch_runs impl_1 -jobs 10
wait_on_run impl_1

set impl_status [get_property STATUS [get_runs impl_1]]
puts "=== Implementation finished with status: $impl_status ==="

if {[string match "*Complete*" $impl_status]} {
    open_run impl_1
    report_utilization -file "$proj_dir/impl_utilization.rpt"
    report_utilization -hierarchical -file "$proj_dir/impl_hier.rpt"
    report_timing_summary -file "$proj_dir/impl_timing_summary.rpt"
    puts "=== Implementation reports saved successfully! ==="
    close_design
} else {
    puts "ERROR: Implementation did not complete successfully!"
}

close_project
puts "=== ALL COMPLETED ==="
