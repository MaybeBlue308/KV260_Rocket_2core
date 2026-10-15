# ==============================================================================
# Script: build_and_synth.tcl
# Description: Create project rocket_kv260, construct Block Design with PS +
#              Rocket Dual-Core Wrapper, and launch Synthesis.
# ==============================================================================

set proj_dir "D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260"
set proj_name "rocket_kv260"

puts "=== Step 1: Creating Vivado Project '$proj_name' ==="
create_project -force $proj_name $proj_dir -part xck26-sfvc784-2LV-c
set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]

puts "=== Step 2: Adding RTL Sources ==="
set chipyard_dir "D:/WORK_FOR_MONEY/kv260_porting/chipyard.harness.TestHarness.KV260DualRocketConfig"
set f [open "$chipyard_dir/chipyard.harness.TestHarness.KV260DualRocketConfig.top.f" r]
set file_data [read $f]
close $f
set data_lines [split $file_data "\n"]
set flist {}
foreach line $data_lines {
    set line [string trim $line]
    if {$line ne ""} {
        set fname [file tail $line]
        lappend flist "$chipyard_dir/gen-collateral/$fname"
    }
}
lappend flist "$chipyard_dir/gen-collateral/chipyard.harness.TestHarness.KV260DualRocketConfig.top.mems.v"
lappend flist "D:/WORK_FOR_MONEY/kv260_porting/kv260_rocket_wrapper.v"

add_files -norecurse $flist
set_property verilog_define {SYNTHESIS=1} [current_fileset]
set_property file_type SystemVerilog [get_files *.sv]
update_compile_order -fileset sources_1

puts "=== Step 3: Creating Block Design 'kv260_bd' ==="
create_bd_design "kv260_bd"

# 3.1 Zynq UltraScale+ MPSoC
set ps [create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:* zynq_ultra_ps_e_0]
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1"} $ps

set_property -dict [list \
  CONFIG.PSU__USE__S_AXI_GP2 {1} \
  CONFIG.PSU__SAXIGP2__DATA_WIDTH {64} \
  CONFIG.PSU__USE__S_AXI_GP6 {1} \
  CONFIG.PSU__SAXIGP6__DATA_WIDTH {64} \
  CONFIG.PSU__USE__M_AXI_GP0 {0} \
  CONFIG.PSU__USE__M_AXI_GP1 {0} \
  CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
  CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__IO {EMIO} \
  CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO_EMIO_WIDTH {8} \
] $ps

# 3.2 kv260_rocket_wrapper Module Reference
create_bd_cell -type module -reference kv260_rocket_wrapper kv260_rocket_wrapper_0

# 3.3 Reset & Interconnects
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:* proc_sys_reset_0

set smc_mem [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:* smartconnect_0]
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc_mem

set smc_mmio [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:* smartconnect_1]
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc_mmio

# 3.4 Clock & Reset Connections
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] \
  [get_bd_pins proc_sys_reset_0/slowest_sync_clk] \
  [get_bd_pins kv260_rocket_wrapper_0/clk] \
  [get_bd_pins smartconnect_0/aclk] \
  [get_bd_pins smartconnect_1/aclk] \
  [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk] \
  [get_bd_pins zynq_ultra_ps_e_0/saxi_lpd_aclk]

connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins proc_sys_reset_0/ext_reset_in]

connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] \
  [get_bd_pins kv260_rocket_wrapper_0/resetn] \
  [get_bd_pins smartconnect_0/aresetn] \
  [get_bd_pins smartconnect_1/aresetn]

# 3.5 AXI Connections
connect_bd_intf_net [get_bd_intf_pins kv260_rocket_wrapper_0/m_axi_mem] [get_bd_intf_pins smartconnect_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]

connect_bd_intf_net [get_bd_intf_pins kv260_rocket_wrapper_0/m_axi_mmio] [get_bd_intf_pins smartconnect_1/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_1/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_LPD]

# 3.6 GPIO & UART EMIO Connections
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o] [get_bd_pins kv260_rocket_wrapper_0/ps_gpio_o]
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/ps_gpio_i] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_i]

connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/uart_txd] [get_bd_pins zynq_ultra_ps_e_0/emio_uart0_rxd]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/emio_uart0_txd] [get_bd_pins kv260_rocket_wrapper_0/uart_rxd]

# 3.7 SPI external pins
foreach p {spi0_sck spi0_cs_n spi0_mosi spi0_miso spi1_sck spi1_cs_n spi1_mosi spi1_miso} {
  set ext_port [make_bd_pins_external [get_bd_pins kv260_rocket_wrapper_0/$p]]
  set_property name $p $ext_port
}

# 3.8 Address Mapping
puts "=== Step 4: Configuring Address Space ==="
assign_bd_address

catch {
  set seg_ddr [get_bd_addr_segs -of_objects [get_bd_addr_spaces kv260_rocket_wrapper_0/m_axi_mem] -filter {NAME =~ *HP0_DDR_HIGH*}]
  if {$seg_ddr ne ""} {
    set_property offset 0x800000000 $seg_ddr
    set_property range 1G $seg_ddr
    puts "Configured m_axi_mem -> HP0_DDR_HIGH at 0x8_0000_0000 (1G)"
  }
}

catch {
  set seg_qspi [get_bd_addr_segs -of_objects [get_bd_addr_spaces kv260_rocket_wrapper_0/m_axi_mmio] -filter {NAME =~ *QSPI*}]
  if {$seg_qspi ne ""} {
    set_property offset 0xC0000000 $seg_qspi
    set_property range 512M $seg_qspi
    puts "Configured m_axi_mmio -> LPD_QSPI at 0xC000_0000 (512M)"
  }
}

catch {
  set other_segs [get_bd_addr_segs -of_objects [get_bd_addr_spaces kv260_rocket_wrapper_0/m_axi_mem] -filter {NAME !~ *HP0_DDR_HIGH*}]
  foreach s $other_segs {
    exclude_bd_addr_seg $s
    puts "Excluded segment: $s"
  }
}

catch {
  set other_mmio [get_bd_addr_segs -of_objects [get_bd_addr_spaces kv260_rocket_wrapper_0/m_axi_mmio] -filter {NAME !~ *QSPI*}]
  foreach s $other_mmio {
    exclude_bd_addr_seg $s
    puts "Excluded segment: $s"
  }
}

puts "=== Step 5: Validating and Saving Block Design ==="
validate_bd_design
save_bd_design

puts "=== Step 6: Generating Top HDL Wrapper ==="
set bd_file [get_files kv260_bd.bd]
generate_target all $bd_file
set wrapper_file [make_wrapper -files $bd_file -top]
add_files -norecurse $wrapper_file
update_compile_order -fileset sources_1
set_property top kv260_bd_wrapper [current_fileset]
update_compile_order -fileset sources_1

puts "=== Step 7: Adding Timing Constraints ==="
add_files -fileset constrs_1 -norecurse "D:/WORK_FOR_MONEY/kv260_porting/kv260_timing.xdc"

puts "=== Step 8: Launching Synthesis ==="
launch_runs synth_1 -jobs 8
wait_on_run synth_1

set synth_status [get_property STATUS [get_runs synth_1]]
puts "=== Synthesis Finished with status: $synth_status ==="

if {[string match "*Complete*" $synth_status]} {
    open_run synth_1
    puts "=== Utilization Report Summary ==="
    report_utilization -file "$proj_dir/synth_utilization.rpt"
    puts "Saved utilization report to $proj_dir/synth_utilization.rpt"
} else {
    puts "Synthesis did not complete successfully. Check logs in $proj_dir/rocket_kv260.runs/synth_1"
}

puts "=== PROJECT IS READY FOR GUI INSPECTION ==="
