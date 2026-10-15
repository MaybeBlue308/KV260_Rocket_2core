set proj_dir "D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260"
open_project "$proj_dir/rocket_kv260.xpr"

puts "=== Launching Synthesis for rocket_kv260 ==="
reset_run synth_1
launch_runs synth_1 -jobs 10
wait_on_run synth_1

set synth_status [get_property STATUS [get_runs synth_1]]
puts "=== Synthesis finished with status: $synth_status ==="

if {[string match "*Complete*" $synth_status]} {
    open_run synth_1
    report_utilization -file "$proj_dir/synth_utilization.rpt"
    report_timing_summary -file "$proj_dir/synth_timing_summary.rpt"
    puts "=== Synthesis reports saved to $proj_dir ==="
} else {
    puts "=== Synthesis did not complete normally ==="
}

close_project
puts "=== FINISHED ==="
