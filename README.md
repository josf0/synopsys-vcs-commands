
# Synopsys VCS Commands
As the description suggests. Here are the commands that I've used feel free to add your suggestions.

It's recommended to use a Makefile as it'll help keep the commands organized and helps in automation. Note that all the commands are not mandatory in every compilation, only the ones applicable for your test may be used. Eg; For a SV testbench, the UVM commands can be omitted as they are not needed. An example Makefile has been added to the repo for reference.

## Compilation Commands
* `-l vcs.log` : Logs all compilation messages to vcs.log file.
* `-timescale=1ns/1ps` : Sets the default timescale for the simulation to 1ns time units and 1ps precision.
* `-assert svaext`	: Enables SystemVerilog Assertions (SVA).
* `-lca` : Enables advanced analysis features Synopsys hasn't officialy validated. Kind of like enabling beta testing features (Correct me if I'm wrong).
* `-cm line+tgl+fsm+branch+cond+assert` : Enables specified coverage types: line, toggle, FSM, branch, condition, and assertion.
* `-cm_dir ./cmp_cov.vdb` : Specify the compilation coverage report directory.
* `-sverilog` : Enables SystemVerilog language support.
* `+v2k` : Enables support for Verilog-2001 features.
* `-ntb_opts uvm` : Enables UVM (Universal Verification Methodology) support for testbenches.
* `-debug_all` : Enables comprehensive debugging features, allowing for interactive debugging in DVE.
* `-full64` : Compiles and simulates in 64-bit mode.
* `-kdb` : Enables the Kernel Debugger for advanced debugging capabilities.
* `-P path_to_novas.tab path_to_pli.a` : Loads PLI (Programming Language Interface) libraries, typically for waveform dumping.
* `rtl/ inc_dir pkg.sv assertions.sv tb_top.sv` : Include the rest of the files in the order RTL files, include directories, SystemVerilog testbench packages, assertion files, and the top-level testbench module, respectively.

## Simulation Commands
* `./simv` : Runs the simulation executable generated by VCS during compilation.
* `-a vcs.log` : Appends simulation output to vcs.log generated during compilation.
* `+fsdbfile+top_wave.fsdb` : Tells the simulator to dump waveforms into the `top_wave.fsdb` file for later viewing in tools like Verdi.
* `-cm line+tgl+fsm+branch+cond+assert` : Enables coverage collection for line, toggle, FSM, branch, condition, and assertion coverage.
* `-cm_dir ./top_cov.vdb` : Specifies the directory `./top_cov.vdb` to store coverage data generated during simulation.
* `+ntb_random_seed_automatic` : Uses an automatically chosen random seed for the testbench.
* `+ntb_random_seed=12345` : Uses the user defined seed for randomization in the testbench.
* `+UVM_TESTNAME=test_name` : Sets the UVM test to run.
* `+UVM_VERBOSITY=UVM_HIGH` : Sets the UVM verbosity level to high, resulting in more detailed log output during simulation.

## Coverage Commands
* `urg` : Invokes the Universal Report Generator, a Synopsys tool for coverage analysis and reporting.
* `-dir ./cmp_cov.vdb -dir ./top_cov.vdb` : Specifies the coverage database directory generated during compilation and simulation.
* `-format both` : The coverage report can be generated in both HTML and text formats. Here both generates them both.
* `-report urgReport_top` : Specifies the directory name for the generated coverage report files.

## Other Useful Commands
* `verdi -cov -covdir simv.vdb -covdir top_cov.vdb` : Command used to open up the coverage report in Verdi.
* `verdi -ssf top_wave.fsdb` : Opens the `.fsdb` file generated during simulation, in Verdi for viewing the waveform.
