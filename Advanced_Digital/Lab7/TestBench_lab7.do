if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/TestBench_lab7.sv

vlog -sv -work work [pwd]/lab7.sv
vlog -sv -work work [pwd]/sync.sv
vlog -sv -work work [pwd]/dualPortMemory.sv
vlog -sv -work work [pwd]/state.sv
vlog -sv -work work [pwd]/sevenSegment.sv
vlog -sv -work work [pwd]/arith.sv
vlog -sv -work work [pwd]/comp.sv


vsim TestBench_lab7


add wave *
add wave /xtop/xstate/*



view structure
view signals

run 52000