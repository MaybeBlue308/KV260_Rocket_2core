create_project -in_memory -part xck26-sfvc784-2LV-c
read_verilog test_uram_mem_ext.v
synth_design -top test_uram_mem_ext -part xck26-sfvc784-2LV-c
report_utilization
