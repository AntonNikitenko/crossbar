onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_crossbar/clk
add wave -noupdate /testbench_crossbar/master_0_req
add wave -noupdate /testbench_crossbar/master_0_cmd
add wave -noupdate -radix unsigned /testbench_crossbar/master_0_addr
add wave -noupdate -radix unsigned /testbench_crossbar/master_0_wdata
add wave -noupdate /testbench_crossbar/master_0_ack
add wave -noupdate -radix unsigned /testbench_crossbar/master_0_rdata
add wave -noupdate /testbench_crossbar/master_1_req
add wave -noupdate /testbench_crossbar/master_1_cmd
add wave -noupdate -radix unsigned /testbench_crossbar/master_1_addr
add wave -noupdate -radix unsigned /testbench_crossbar/master_1_wdata
add wave -noupdate /testbench_crossbar/master_1_ack
add wave -noupdate -radix unsigned /testbench_crossbar/master_1_rdata
add wave -noupdate /testbench_crossbar/slave_0_req
add wave -noupdate /testbench_crossbar/slave_0_cmd
add wave -noupdate -radix unsigned /testbench_crossbar/slave_0_addr
add wave -noupdate -radix unsigned /testbench_crossbar/slave_0_wdata
add wave -noupdate /testbench_crossbar/slave_0_ack
add wave -noupdate -radix unsigned /testbench_crossbar/slave_0_rdata
add wave -noupdate /testbench_crossbar/slave_1_req
add wave -noupdate /testbench_crossbar/slave_1_cmd
add wave -noupdate -radix unsigned /testbench_crossbar/slave_1_addr
add wave -noupdate -radix unsigned /testbench_crossbar/slave_1_wdata
add wave -noupdate /testbench_crossbar/slave_1_ack
add wave -noupdate -radix unsigned /testbench_crossbar/slave_1_rdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {408 ns}
