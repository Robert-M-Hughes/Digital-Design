if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/TestBench_sevSeg_Disp.sv
vlog -sv -work work [pwd]/sevenSeg_Disp.sv
vlog -sv -work work [pwd]/sevSeg.sv
vsim TestBench_sevSeg_Disp

add wave *

view structure
view signals

run 2000