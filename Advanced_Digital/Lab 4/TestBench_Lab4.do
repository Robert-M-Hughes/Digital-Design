if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/Testbench_Lab4.sv
vlog -sv -work work [pwd]/Lab4.sv
vlog -sv -work work [pwd]/sync.sv
vlog -sv -work work [pwd]/arith.sv
vlog -sv -work work [pwd]/sevenSeg_Disp.sv
vlog -sv -work work [pwd]/sevSeg.sv
vsim Testbench_Lab4

add wave -radix unsigned sim:/Testbench_Lab4/*

view structure
view signals

run 6000