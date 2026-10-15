set here [file normalize [file dirname [info script]]]
set xsa  [file normalize [file join $here .. rocket_kv260.xsa]]
hsi::open_hw_design $xsa
hsi::generate_app -hw [hsi::current_hw_design] -os standalone -proc psu_cortexa53_0 \
    -app zynqmp_fsbl -compile -sw fsbl -dir [file join $here zynqmp_fsbl]
hsi::close_hw_design [hsi::current_hw_design]
puts "FSBL_DONE"
