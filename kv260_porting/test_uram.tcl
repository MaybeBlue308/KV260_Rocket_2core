create_project -in_memory -part xck26-sfvc784-2LV-c
read_verilog test_uram_sub.v

puts "=== TESTING test_uram_bank ==="
synth_design -top test_uram_bank -part xck26-sfvc784-2LV-c
report_utilization

puts "=== TESTING test_uram_scratch ==="
synth_design -top test_uram_scratch -part xck26-sfvc784-2LV-c
report_utilization
