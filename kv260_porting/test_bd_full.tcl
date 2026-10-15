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

# 3.7 SPI external ports
create_bd_port -dir O spi0_sck
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi0_sck] [get_bd_ports spi0_sck]
create_bd_port -dir O spi0_cs_n
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi0_cs_n] [get_bd_ports spi0_cs_n]
create_bd_port -dir O spi0_mosi
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi0_mosi] [get_bd_ports spi0_mosi]
create_bd_port -dir I spi0_miso
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi0_miso] [get_bd_ports spi0_miso]

create_bd_port -dir O spi1_sck
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi1_sck] [get_bd_ports spi1_sck]
create_bd_port -dir O spi1_cs_n
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi1_cs_n] [get_bd_ports spi1_cs_n]
create_bd_port -dir O spi1_mosi
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi1_mosi] [get_bd_ports spi1_mosi]
create_bd_port -dir I spi1_miso
connect_bd_net [get_bd_pins kv260_rocket_wrapper_0/spi1_miso] [get_bd_ports spi1_miso]

# 3.8 Address Mapping
puts "=== Step 4: Configuring Address Space ==="
assign_bd_address

catch {
  set_property range 1G [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mem/SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH]
  set_property offset 0x800000000 [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mem/SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH]
}
catch {
  exclude_bd_addr_seg [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mem/SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW]
}
catch {
  exclude_bd_addr_seg [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mem/SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM]
}
catch {
  exclude_bd_addr_seg [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mem/SEG_zynq_ultra_ps_e_0_HP0_QSPI]
}
catch {
  exclude_bd_addr_seg [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mmio/SEG_zynq_ultra_ps_e_0_LPD_DDR_LOW]
}
catch {
  exclude_bd_addr_seg [get_bd_addr_segs /kv260_rocket_wrapper_0/m_axi_mmio/SEG_zynq_ultra_ps_e_0_LPD_LPS_OCM]
}

puts "=== Step 5: Validating and Saving Block Design ==="
validate_bd_design
save_bd_design
puts "=== BD CREATED AND SAVED SUCCESSFULLY ==="

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

close_project
puts "=== PROJECT SETUP READY FOR SYNTHESIS ==="
