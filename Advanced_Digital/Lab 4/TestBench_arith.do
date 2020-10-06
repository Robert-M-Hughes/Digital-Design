if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/TestBench_arith.sv
vlog -sv -work work [pwd]/arith.sv
vsim TestBench_arith

add wave *

view structure
view signals

run 1500