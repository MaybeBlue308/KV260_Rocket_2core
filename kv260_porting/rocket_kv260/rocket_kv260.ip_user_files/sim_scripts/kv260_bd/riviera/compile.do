transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_19
vlib riviera/zynq_ultra_ps_e_vip_v1_0_19
vlib riviera/xil_defaultlib
vlib riviera/lib_cdc_v1_0_3
vlib riviera/proc_sys_reset_v5_0_16
vlib riviera/xlconstant_v1_1_9
vlib riviera/smartconnect_v1_0
vlib riviera/axi_register_slice_v2_1_33

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_19 riviera/axi_vip_v1_1_19
vmap zynq_ultra_ps_e_vip_v1_0_19 riviera/zynq_ultra_ps_e_vip_v1_0_19
vmap xil_defaultlib riviera/xil_defaultlib
vmap lib_cdc_v1_0_3 riviera/lib_cdc_v1_0_3
vmap proc_sys_reset_v5_0_16 riviera/proc_sys_reset_v5_0_16
vmap xlconstant_v1_1_9 riviera/xlconstant_v1_1_9
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_register_slice_v2_1_33 riviera/axi_register_slice_v2_1_33

vlog -work xilinx_vip  -incr "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/ssd3/tools/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"/ssd3/tools/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/ssd3/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
"/ssd3/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"/ssd3/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_19  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_zynq_ultra_ps_e_0_0/sim/kv260_bd_zynq_ultra_ps_e_0_0_vip_wrapper.v" \
"../../../bd/kv260_bd/ip/kv260_bd_kv260_rocket_wrapper_0_0/sim/kv260_bd_kv260_rocket_wrapper_0_0.v" \

vcom -work lib_cdc_v1_0_3 -93  -incr \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_16 -93  -incr \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/kv260_bd/ip/kv260_bd_proc_sys_reset_0_0/sim/kv260_bd_proc_sys_reset_0_0.vhd" \

vlog -work xlconstant_v1_1_9  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_0/sim/bd_62a4_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_1/sim/bd_62a4_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_2/sim/bd_62a4_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_3/sim/bd_62a4_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_4/sim/bd_62a4_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_5/sim/bd_62a4_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_6/sim/bd_62a4_sarn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_7/sim/bd_62a4_srn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_8/sim/bd_62a4_sawn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_9/sim/bd_62a4_swn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_10/sim/bd_62a4_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_11/sim/bd_62a4_m00s2a_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/ip/ip_12/sim/bd_62a4_m00e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/bd_0/sim/bd_62a4.v" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work axi_register_slice_v2_1_33  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_0_0/sim/kv260_bd_smartconnect_0_0.v" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_0/sim/bd_a2f5_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_1/sim/bd_a2f5_psr_aclk_0.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_2/sim/bd_a2f5_s00mmu_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_3/sim/bd_a2f5_s00tr_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_4/sim/bd_a2f5_s00sic_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_5/sim/bd_a2f5_s00a2s_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_6/sim/bd_a2f5_sarn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_7/sim/bd_a2f5_srn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_8/sim/bd_a2f5_sawn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_9/sim/bd_a2f5_swn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_10/sim/bd_a2f5_sbn_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_11/sim/bd_a2f5_m00s2a_0.sv" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/ip/ip_12/sim/bd_a2f5_m00e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/ec67/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/6f8f/hdl" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../rocket_kv260.gen/sources_1/bd/kv260_bd/ipshared/0127/hdl/verilog" "+incdir+/ssd3/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_19 -l zynq_ultra_ps_e_vip_v1_0_19 -l xil_defaultlib -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_register_slice_v2_1_33 \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/bd_0/sim/bd_a2f5.v" \
"../../../bd/kv260_bd/ip/kv260_bd_smartconnect_1_0/sim/kv260_bd_smartconnect_1_0.v" \
"../../../bd/kv260_bd/sim/kv260_bd.v" \

vlog -work xil_defaultlib \
"glbl.v"

