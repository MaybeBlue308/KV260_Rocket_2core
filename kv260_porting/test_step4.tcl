set proj_dir "D:/WORK_FOR_MONEY/kv260_porting/rocket_kv260"
open_project "$proj_dir/rocket_kv260.xpr"
open_bd_design [get_files kv260_bd.bd]

puts "=== Step 3.7: Creating SPI external ports ==="
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

puts "=== Step 4: Configuring Address Space ==="
assign_bd_address
puts "All address segments: [get_bd_addr_segs]"
puts "All address spaces: [get_bd_addr_spaces]"

foreach seg [get_bd_addr_segs] {
    puts "SEG: $seg (Offset: [get_property offset $seg], Range: [get_property range $seg])"
}

close_project
