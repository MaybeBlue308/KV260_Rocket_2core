set proj_dir "D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260"
open_project "$proj_dir/rocket_kv260.xpr"

puts "=== Launching Implementation for rocket_kv260 ==="
reset_run impl_1
launch_runs impl_1 -jobs 10
wait_on_run impl_1

set impl_status [get_property STATUS [get_runs impl_1]]
puts "=== Implementation finished with status: $impl_status ==="

if {[string match "*Complete*" $impl_status]} {
    open_run impl_1
    report_utilization -file "$proj_dir/impl_utilization.rpt"
    report_timing_summary -file "$proj_dir/impl_timing_summary.rpt"
    puts "=== Implementation reports saved to $proj_dir ==="
} else {
    puts "=== Implementation failed or stopped with status: $impl_status ==="
}

close_project
puts "=== FINISHED ==="
