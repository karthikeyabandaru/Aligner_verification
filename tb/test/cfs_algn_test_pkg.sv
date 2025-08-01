///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_pkg.sv
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Test package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_TEST_PKG_SV
`define CFS_ALGN_TEST_PKG_SV 

`include "uvm_macros.svh"
`include "../env/cfs_algn_pkg.sv"

package cfs_algn_test_pkg;
  import uvm_pkg::*;
  import cfs_algn_pkg::*;
  import cfs_apb_pkg::*;
  import cfs_md_pkg::*;

  `include "cfs_algn_test_defines.sv"
  `include "cfs_algn_test_base.sv"
  `include "cfs_algn_test_reg_access.sv"
  `include "cfs_algn_test_random.sv"
  `include "cfs_algn_test_random_rx_err.sv"
  `include "cfs_algn_test_illegal_config.sv"
  `include "cfs_algn_test_check_access_type.sv"
  `include "cfs_algn_irq_check_test.sv"
  `include "cfs_algn_irq_check_test_2.sv"
  `include "cfs_algn_alignment_check_test.sv"
  `include "cfs_algn_test_clr_check.sv"
  `include "cfs_algn_reset_test.sv"
  `include "cfs_algn_status_block_test.sv"
  `include "cfs_algn_test_reserved_bits.sv"
  `include "cfs_algn_test_slow_pace.sv"
  `include "cfs_algn_clock_stability_test.sv"
  `include "cfs_algn_test_split_legal_combinations.sv"
  `include "cfs_algn_test_md_length_directed.sv"
  `include "cfs_algn_test_ctrlsize_directed.sv"
  `include "cfs_algn_test_apb_reset_cover.sv"
  `include "cfs_algn_test_num_bytes_directed.sv"
  `include "cfs_algn_test_split_cover_directed.sv"
  `include "cfs_algn_test_split_cross_cover_directed.sv"
  `include "cfs_algn_test_ctrl4_off0_two_pkts.sv"
  `include "cfs_algn_test_valid_force_0.sv"
  `include "cfs_algn_md_test_rx_size0.sv"
endpackage

`endif
