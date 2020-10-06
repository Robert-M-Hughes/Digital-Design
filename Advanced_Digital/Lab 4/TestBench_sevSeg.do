if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work [pwd]/TestBench_sevSeg.sv
vlog -sv -work work [pwd]/sevSeg.sv
vsim TestBench_sevSeg

add wave *

view structure
view signals

run 2000