# ==============================================================================
# Constraints for Kria KV260 Dual-Core Rocket Chip
#
# All constraints here are for implementation: set
#   set_property used_in_synthesis false [get_files kv260_timing.xdc]
# (the PS8 pin used for jtag_tck does not exist during top-level synthesis,
#  the block-design IPs are synthesized out of context).
# ==============================================================================

## ====================================================================
## Kria KV260 PMOD (Connector J2) - Bank 45 (VCCO = 3.3V)
## ====================================================================
# Example xdc
## Hàng trên (Top Row - J2 Pins 1, 3, 5, 7 / Digilent Pins 1, 2, 3, 4)
#set_property PACKAGE_PIN H12 [get_ports {pmod_io[0]}] ;# Net: HDA11 (SOM240_1_A17)
#set_property PACKAGE_PIN E10 [get_ports {pmod_io[1]}] ;# Net: HDA12 (SOM240_1_D20)
#set_property PACKAGE_PIN D10 [get_ports {pmod_io[2]}] ;# Net: HDA13 (SOM240_1_D21)
#set_property PACKAGE_PIN C11 [get_ports {pmod_io[3]}] ;# Net: HDA14 (SOM240_1_C22)

## Hàng dưới (Bottom Row - J2 Pins 2, 4, 6, 8 / Digilent Pins 7, 8, 9, 10)
#set_property PACKAGE_PIN B10 [get_ports {pmod_io[4]}] ;# Net: HDA15 (SOM240_1_B20)
#set_property PACKAGE_PIN E12 [get_ports {pmod_io[5]}] ;# Net: HDA16 (SOM240_1_B21)
#set_property PACKAGE_PIN D11 [get_ports {pmod_io[6]}] ;# Net: HDA17 (SOM240_1_B22)
#set_property PACKAGE_PIN B11 [get_ports {pmod_io[7]}] ;# Net: HDA18 (SOM240_1_A22)

## Cấu hình chuẩn điện áp và đặc tính điện học
#set_property IOSTANDARD LVCMOS33 [get_ports {pmod_io[*]}]
#set_property SLEW SLOW           [get_ports {pmod_io[*]}]
#set_property DRIVE 4             [get_ports {pmod_io[*]}]


# ------------------------------------------------------------------------------
# PMOD J2 pins (bank 45, HDIO, 3.3 V) - from the Vivado 2025.2 board files:
#   kv260_som/1.4/part0_pins.xml + kv260_carrier/1.3/board.xml (I2S2 Pmod on J2):
#   J2 pin1 H12 (MCLK_TX)  pin2 E10 (som240_1_d20)  pin3 D10 (d21)  pin4  C11 (d22)
#   J2 pin7 B10 (MCLK_RX)  pin8 E12 (som240_1_b21)  pin9 D11 (b22)  pin10 B11 (c22)
# Digilent SPI Pmod order (Type 2A): pin1 = CS, pin2 = MOSI, pin3 = MISO, pin4 = SCK
# (bottom row 7..10 uses the same order).
# ------------------------------------------------------------------------------
# SPI0: NOR flash (single SPI) - top row
set_property PACKAGE_PIN H12 [get_ports spi0_cs_n]
set_property PACKAGE_PIN E10 [get_ports spi0_mosi]
set_property PACKAGE_PIN D10 [get_ports spi0_miso]
set_property PACKAGE_PIN C11 [get_ports spi0_sck]

# SPI1: SD card (SPI mode) - bottom row
set_property PACKAGE_PIN B10 [get_ports spi1_cs_n]
set_property PACKAGE_PIN E12 [get_ports spi1_mosi]
set_property PACKAGE_PIN D11 [get_ports spi1_miso]
set_property PACKAGE_PIN B11 [get_ports spi1_sck]

set_property IOSTANDARD LVCMOS33 [get_ports {spi0_* spi1_*}]
set_property SLEW SLOW           [get_ports {spi0_sck spi0_cs_n spi0_mosi spi1_sck spi1_cs_n spi1_mosi}]
set_property DRIVE 8             [get_ports {spi0_sck spi0_cs_n spi0_mosi spi1_sck spi1_cs_n spi1_mosi}]
# SD cards need a pull-up on MISO (DAT0) when the card is not driving it
set_property PULLUP true         [get_ports spi1_miso]

# SPI SCK is <= 20 MHz and every SPI pin is driven/sampled by registers in the
# 100 MHz Rocket clock domain: no IO timing to check (clears TIMING-18)
set_false_path -to   [get_ports {spi0_sck spi0_cs_n spi0_mosi spi1_sck spi1_cs_n spi1_mosi}]
set_false_path -from [get_ports {spi0_miso spi1_miso}]

# ------------------------------------------------------------------------------
# JTAG TCK: bit-banged by the PS on EMIO GPIO[2], clocks the Rocket JTAG DTM
# (~300 flops in chiptop/system/dtm, TIMING-17 without this). 1 MHz is far
# above what GPIO bit-banging reaches. Vivado already inserts a BUFG_PS here.
# ------------------------------------------------------------------------------
create_clock -name jtag_tck -period 1000.000 [get_pins {kv260_bd_i/zynq_ultra_ps_e_0/inst/PS8_i/EMIOGPIOO[2]}]
set_clock_groups -asynchronous -group [get_clocks jtag_tck] -group [get_clocks clk_pl_0]
