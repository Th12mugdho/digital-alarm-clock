# 1. Setup paths
set_db lib_search_path ../lib/
set_db hdl_search_path ../rtl/
set_db library slow_vdd1v0_basicCells.lib

# 2. Read Multiple HDL Files
read_hdl -sv {counters.sv alarm_mod.sv digital_alarm_clock.sv}

# 3. Elaborate Top-Level Module
elaborate digital_alarm_clock

# 4. Apply Constraints
read_sdc ../constraint/constraints_top.sdc

# 5. Synthesize
syn_generic
syn_map
syn_opt

# 6. Export Results
write_hdl > digital_alarm_clock_netlist.v
write_sdc > digital_alarm_clock_mapped.sdc
report_area > area_report.txt
report_timing > timing_report.txt

puts "Synthesis Finished! Check digital_alarm_clock.txt for gate count."
