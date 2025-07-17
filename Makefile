#
# Makefile template for VCS
#
RTL 		= ../rtl/* 							# Include the RTL files here
INC 		= +incdir+../rtl +incdir+../tb		# Include all the directories here
SVTB_TOP 	= ../test/tb_top.sv					# Include the testbench top file
SVTB_PKG 	= ../test/tb_pkg.sv					# Include the package file
SVTB_ASSERT = ../test/tb_assertions.sv			# Include the assertions file

work 		= work #library name

FSDB_PATH 	= /home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

# Make target to compile the top
sv_cmp:
	vcs -l vcs.log -timescale=1ns/1ps -assert svaext -lca -cm line+tgl+fsm+branch+cond+assert -cm_dir ./cmp_cov.vdb -sverilog +v2k -ntb_opts uvm -debug_all -full64 -kdb -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB_PKG) $(SVTB_ASSERT) $(SVTB_TOP) 

# Make targets for simulating individual tests
run_test_top: clean sv_cmp test_top

# Make targets for regression testing
test_top: 
	./simv -a vcs.log +fsdbfile+top_wave.fsdb -cm line+tgl+fsm+branch+cond+assert -cm_dir ./top_cov.vdb +ntb_random_seed_automatic +UVM_TESTNAME=test_top +UVM_VERBOSITY=UVM_MEDIUM
	urg -dir ./cmp_cov.vdb -dir ./top_cov.vdb -format both -report urgReport_top

test_test1: 
	./simv -a vcs.log +fsdbfile+test1_wave.fsdb -cm line+tgl+fsm+branch+cond+assert -cm_dir ./test1_cov.vdb +ntb_random_seed_automatic +UVM_TESTNAME=test_test1 +UVM_VERBOSITY=UVM_MEDIUM
	urg -dir ./cmp_cov.vdb -dir ./test1_cov.vdb -format both -report urgReport_test1

# Make targets to view the waveforms
view_wave_top:
	verdi -ssf top_wave.fsdb

view_wave_test1:
	verdi -ssf test1_wave.fsdb

# Make targets to view the coverage reports
cov_report_top:
	verdi -cov -covdir cmp_cov.vdb -covdir top_cov.vdb

cov_report_test1:
	verdi -cov -covdir cmp_cov.vdb -covdir test1_cov.vdb

#### REGRESSION TESTING TARGETS ####

# Make targets for regression test
regress: clean test_top test_test1 report

# Make target to merge the coverage reports
report:
	urg -dir top_cov.vdb test1_cov.vdb -dbname merged_dir/merged_test -format both -report urgReport

# Make target to open the coverage report inside VCS GUI
cov_regress:
	verdi -cov -covdir merged_dir.vdb

# Make target to clean the previous simulation files
clean:
	rm -fr alib-52/ .fsm* default.svf filenames* command.log  io_if_synth.log timing_report.txt *.vdb *.fsdb* *.log *.txt csrc/ *.conf *.rc simv* Synopsys* *.key urgReport* *.h verdi* vdCovLog
