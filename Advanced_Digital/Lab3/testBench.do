if {[file exists rtl_work]} {
    vdel -lib rtl_work -all

}
vlib rtl_work
vmap work rtl_work

 ### Compile code ###
 ### Enter files here; copy line for multiple files ###
 vlog -sv -work work [pwd]/state.sv
 vlog -sv -work work [pwd]/Lab3.sv
 vlog -sv -work work [pwd]/sync.sv
 vlog -sv -work work [pwd]/Testbench_lab3.sv

### Load design for simulation ###
### Replace topLevelModule with the name of your top level module ###
### Do not duplicate! ###
vsim Lab3

### Add waves here ###
add wave *

### Run simulation ###
# to see your design hierarchy and signals
view structure

# to see all signal names and current values
 view signals

# Edit run time
run 10000