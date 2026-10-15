# ==============================================================================
# build_bitstream_linux.tcl - KV260 Dual Rocket: project -> BD -> synth -> impl -> bitstream
#
#   vivado -mode batch -source build_bitstream_linux.tcl -log build.log -journal build.jou
#   (normally started through run_build_watchdog.sh)
#
# Resource limits: VIVADO_THREADS (default 2) threads per process, one run at a time.
# ==============================================================================

set root      [file normalize [file dirname [info script]]]
set proj_name rocket_kv260
set proj_dir  [file join $root rocket_kv260_lnx]
set cy_dir    [file join $root chipyard.harness.TestHarness.KV260DualRocketConfig]
set threads   [expr {[info exists ::env(VIVADO_THREADS)] ? $::env(VIVADO_THREADS) : 2}]

set_param general.maxThreads $threads
puts "=== maxThreads = $threads, project = $proj_dir"

# ---------------- Step 1: project ----------------
create_project -force $proj_name $proj_dir -part xck26-sfvc784-2LV-c
set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]
# carrier connection: without it the preset leaves UART1/ETH/USB/SD of the carrier disabled
set_property board_connections {som240_1_connector xilinx.com:kv260_carrier:som240_1_connector:1.3} [current_project]

# ---------------- Step 2: RTL ----------------
set fh [open [file join $cy_dir chipyard.harness.TestHarness.KV260DualRocketConfig.top.f] r]
set flist {}
foreach line [split [read $fh] "\n"] {
  set line [string trim $line]
  if {$line ne ""} { lappend flist [file join $cy_dir gen-collateral [file tail $line]] }
}
close $fh
set mems_v [file join $cy_dir gen-collateral chipyard.harness.TestHarness.KV260DualRocketConfig.top.mems.v]
set fh [open $mems_v r]; set mems_txt [read $fh]; close $fh
if {[regexp -all {ram_style = "ultra"} $mems_txt] < 2} { error "$mems_v is not patched for UltraRAM" }
lappend flist $mems_v [file join $root kv260_rocket_wrapper.v]

add_files -norecurse $flist
set_property verilog_define {SYNTHESIS=1} [current_fileset]
set_property file_type SystemVerilog [get_files *.sv]
update_compile_order -fileset sources_1

# ---------------- Step 3: block design ----------------
create_bd_design kv260_bd

set ps [create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:* zynq_ultra_ps_e_0]
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1"} $ps
set_property -dict [list \
  CONFIG.PSU__USE__S_AXI_GP2 {1} \
  CONFIG.PSU__SAXIGP2__DATA_WIDTH {64} \
  CONFIG.PSU__USE__S_AXI_GP6 {1} \
  CONFIG.PSU__SAXIGP6__DATA_WIDTH {64} \
  CONFIG.PSU__USE__M_AXI_GP0 {0} \
  CONFIG.PSU__USE__M_AXI_GP1 {0} \
  CONFIG.PSU__USE__M_AXI_GP2 {0} \
  CONFIG.PSU__FPGA_PL0_ENABLE {1} \
  CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
  CONFIG.PSU__FPGA_PL1_ENABLE {0} \
  CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__IO {EMIO} \
  CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {8} \
] $ps

create_bd_cell -type module -reference kv260_rocket_wrapper kv260_rocket_wrapper_0
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:* proc_sys_reset_0
foreach n {0 1} {
  set smc [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:* smartconnect_$n]
  set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc
}

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

connect_bd_intf_net [get_bd_intf_pins kv260_rocket_wrapper_0/m_axi_mem]  [get_bd_intf_pins smartconnect_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_0/M00_AXI]            [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]
connect_bd_intf_net [get_bd_intf_pins kv260_rocket_wrapper_0/m_axi_mmio] [get_bd_intf_pins smartconnect_1/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_1/M00_AXI]            [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_LPD]

connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o]     [get_bd_pins kv260_rocket_wrapper_0/ps_gpio_o]
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/ps_gpio_i]  [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_i]
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/uart_txd]   [get_bd_pins zynq_ultra_ps_e_0/emio_uart0_rxd]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/emio_uart0_txd]  [get_bd_pins kv260_rocket_wrapper_0/uart_rxd]

foreach {p dir} {spi0_sck O spi0_cs_n O spi0_mosi O spi0_miso I spi1_sck O spi1_cs_n O spi1_mosi O spi1_miso I} {
  create_bd_port -dir $dir $p
  connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/$p] [get_bd_ports $p]
}

# ---------------- Step 4: address map ----------------
assign_bd_address
foreach {space keep offset range} {
  m_axi_mem  HP0_DDR_HIGH 0x800000000 1G
  m_axi_mmio LPD_QSPI     0xC0000000  512M
} {
  foreach seg [get_bd_addr_segs -of_objects [get_bd_addr_spaces kv260_rocket_wrapper_0/$space]] {
    if {[string match "*$keep" $seg]} {
      set_property range  $range  $seg
      set_property offset $offset $seg
      puts "MAP  $space -> $seg @ $offset ($range)"
    } else {
      exclude_bd_addr_seg $seg
      puts "EXCL $space -> $seg"
    }
  }
}

validate_bd_design
save_bd_design
puts "PS EMIO GPIO width: [get_property CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO $ps]"
puts "PS UART1 enable   : [get_property CONFIG.PSU__UART1__PERIPHERAL__ENABLE $ps]"

# ---------------- Step 5: top wrapper + constraints ----------------
set bd_file [get_files kv260_bd.bd]
generate_target all $bd_file
add_files -norecurse [make_wrapper -files $bd_file -top]
set_property top kv260_bd_wrapper [current_fileset]
update_compile_order -fileset sources_1

add_files -fileset constrs_1 -norecurse [file join $root kv260_timing.xdc]
set_property used_in_synthesis false [get_files kv260_timing.xdc]

# ---------------- thread limit inside every run (runs are separate processes) ----------------
set hook [file join $proj_dir limit_threads.tcl]
set fh [open $hook w]; puts $fh "set_param general.maxThreads $threads"; close $fh
foreach r [get_runs -filter {IS_SYNTHESIS}] { set_property STEPS.SYNTH_DESIGN.TCL.PRE $hook $r }
set_property STEPS.INIT_DESIGN.TCL.PRE $hook [get_runs impl_1]

# ---------------- Step 6: synthesis (one run at a time) ----------------
puts "=== STAGE synth start [clock format [clock seconds]]"
launch_runs synth_1 -jobs 1
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} { error "synth_1 failed: [get_property STATUS [get_runs synth_1]]" }
open_run synth_1
report_utilization -file [file join $proj_dir synth_utilization.rpt]
close_design

# ---------------- Step 7: implementation + bitstream ----------------
puts "=== STAGE impl start [clock format [clock seconds]]"
launch_runs impl_1 -to_step write_bitstream -jobs 1
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} { error "impl_1 failed: [get_property STATUS [get_runs impl_1]]" }

open_run impl_1
report_utilization         -file [file join $proj_dir impl_utilization.rpt]
report_timing_summary      -file [file join $proj_dir impl_timing_summary.rpt]
report_methodology         -file [file join $proj_dir impl_methodology.rpt]
report_io                  -file [file join $proj_dir impl_io.rpt]
write_hw_platform -fixed -include_bit -force [file join $root rocket_kv260.xsa]
file copy -force [file join $proj_dir $proj_name.runs impl_1 kv260_bd_wrapper.bit] [file join $root kv260_bd_wrapper.bit]
close_design

puts "=== BUILD DONE [clock format [clock seconds]]"
