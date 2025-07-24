
# === File: Makefile ===
# QuestaSim + UVM + DPI (uvm_hdl_force/release) support
#
# Reserved‑bit toggle coverage is excluded automatically
# by executing cov_exclude.do before every run.
# Put cov_exclude.do in $(TB_TOP_DIR) (../../tb/top) or adjust COV_EXCL_DO.

# -------------------------------------------------------
# Directories
RTL_DIR        = ../../rtl
TB_TOP_DIR     = ../../tb/top
QUESTA_INCLUDE = /home/user/Downloads/questasim/include
# -------------------------------------------------------
# UVM DPI sources
UVM_DPI_SRC = /home/user/Downloads/questasim/verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc \
              /home/user/Downloads/questasim/verilog_src/uvm-1.2/src/dpi/uvm_hdl_questa.c
DPI_SRC = ../../dpi/clk_control.c
TOGGLE_DO=../../tb/sim/toggle_exclude.do
# -------------------------------------------------------
# Source files
TOP_SRCS = $(RTL_DIR)/design.sv $(TB_TOP_DIR)/testbench.sv

# -------------------------------------------------------
# Test configuration
TESTNAME  =cfs_algn_irq_check_test_2
UVM_ARGS  = +UVM_TESTNAME=$(TESTNAME) +UVM_MAX_QUIT_COUNT=1 \
            +uvm_set_verbosity=*,REG_PREDICT,UVM_HIGH,run +access +rw

# -------------------------------------------------------
# Output artifacts
WORKLIB    = work
COMP_LOG   = compile.log
SIM_LOG    = sim.log
TRANSCRIPT = transcript
DPI_SO     = uvm_dpi.so

# -------------------------------------------------------
# Default target
all: comp run gui

# -------------------------------------------------------
# === Compile ===
comp:
	@echo "[Compiling design and testbench...]" | tee $(COMP_LOG)
	@rm -rf $(WORKLIB)
	@vlib $(WORKLIB)                               | tee -a $(COMP_LOG)
	@vmap $(WORKLIB) $(WORKLIB)                    | tee -a $(COMP_LOG)
	@vlog -sv -cover bcest -work $(WORKLIB) $(TOP_SRCS) \
	    +acc=rn+* +define+QUESTA \
	    +incdir+$(RTL_DIR) +incdir+$(TB_TOP_DIR) \
	    +incdir+/home/user/Downloads/questasim/verilog_src/uvm-1.2/src/dpi \
	    | tee -a $(COMP_LOG) | tee -a $(TRANSCRIPT)

# -------------------------------------------------------
# === Run simulation (command‑line) ===
run:
	@echo "[Running simulation...]" | tee $(SIM_LOG)
	@vsim -coverage -voptargs=+acc +access +rw -sv_lib $(DPI_SO:.so=) -c work.testbench \
	    $(UVM_ARGS) \
	    -do "do $(TOGGLE_DO); coverage save -onexit vsim.ucdb; run -all; quit;" \
	    | tee -a $(SIM_LOG) | tee -a $(TRANSCRIPT)

# -------------------------------------------------------
# === GUI with waveform ===
gui:
	@echo "[Launching QuestaSim GUI with waveforms...]" | tee -a $(TRANSCRIPT)
	@vsim -coverage -sv_lib $(DPI_SO:.so=) work.testbench \
	    $(UVM_ARGS) -do "do $(TOGGLE_DO); do wave.do;"

# -------------------------------------------------------
# === Clean ===
clean:
	rm -rf $(WORKLIB) $(COMP_LOG) $(SIM_LOG) $(TRANSCRIPT) \
	       vsim.wlf logs *.ucdb coverage_report ucdb merged.ucdb regression.log

# -------------------------------------------------------
# === Regression ===
NUM_RUNS ?= 1
regress:
	@echo "[Starting Full Regression: $(NUM_RUNS) runs per test]" > regression.log
	@rm -rf logs
	@mkdir -p logs
	@mkdir -p ucdb
	@tests="cfs_algn_alignment_check_test \
cfs_algn_irq_check_test \
cfs_algn_irq_check_test_2 \
cfs_algn_test_check_access_type \
cfs_algn_test_clr_check \
cfs_algn_test_illegal_config \
cfs_algn_test_random \
cfs_algn_test_random_rx_err \
cfs_algn_reset_test \
cfs_algn_status_block_test \
cfs_algn_clock_stability_test \
cfs_algn_test_reserved_bits \
cfs_algn_test_md_length_directed \
cfs_algn_test_ctrlsize_directed \
cfs_algn_test_apb_reset_cover \
cfs_algn_test_split_legal_combinations \
cfs_algn_test_num_bytes_directed \
cfs_algn_test_split_cover_directed \
cfs_algn_test_split_cross_cover_directed \
cfs_algn_test_ctrl4_off0_two_pkts \
cfs_algn_md_test_rx_size0 \
cfs_algn_test_valid_force_0 \
cfs_algn_test_reg_access"; \
	seq 1 $(NUM_RUNS) | while read i; do \
		for t in $$tests; do echo $$t; done; \
	done | shuf | while read test; do \
		seed=$$(od -An -N2 -tu4 < /dev/urandom | tr -d ' '); \
		runid=$$(date +%s%N | cut -b1-13); \
		echo "[==============================]" | tee -a regression.log ; \
		echo "[Running $$test with SEED=$$seed]" | tee -a regression.log ; \
		vsim -voptargs=+acc -coverage -sv_lib $(DPI_SO:.so=) -c work.testbench \
		     +UVM_TESTNAME=$$test +UVM_MAX_QUIT_COUNT=1 +access +rw \
		     +ntb_random_seed=$$seed \
		     -do "do $(TOGGLE_DO); coverage save -onexit ucdb/$$test\_$$runid.ucdb; run -all; quit;" \
		     > logs/$$test\_$$runid.log 2>&1 ; \
		grep -i -P 'UVM_FATAL(?! *: *0)|UVM_ERROR(?! *: *0)|(\*Error[^s:])|(\*UVM_FATAL)|^#\s+Fatal' \
		    logs/$$test\_$$runid.log && \
		    echo "[❌ FAIL] $$test (SEED=$$seed)" | tee -a regression.log || \
		    echo "[✅ PASS] $$test (SEED=$$seed)" | tee -a regression.log ; \
	done
	@echo "[Merging coverage files...]" | tee -a regression.log
	@vcover merge merged.ucdb ucdb/*.ucdb
	@echo "[Regression Completed. Coverage saved to merged.ucdb]" | tee -a regression.log
 
# -------------------------------------------------------
# === Coverage viewing / reports ===
coview:
	@echo "[Opening Coverage GUI with UCDB...]"
	@vsim -viewcov merged.ucdb
 
covsum:
	@echo "[Generating Terminal Summary Report...]"
	@vcover report -details merged.ucdb
 
report:
	@echo "[Generating Coverage Report...]"
	@vcover report -html -details -verbose merged.ucdb -output coverage_report
	@echo "[HTML coverage report saved to ./coverage_report/index.html]"
 
.PHONY: all comp run gui clean regress coview covsum report
