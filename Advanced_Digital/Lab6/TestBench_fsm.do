if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/TestBench_fsm.sv
vlog -sv -work work [pwd]/memStateMachine.sv
vlog -sv -work work [pwd]/dualPortMemory.sv
vsim TestBench_fsm

add wave *


view structure
view signals

run 8000