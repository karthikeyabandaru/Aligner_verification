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
  `include "cfs_algn_alignment_check_test.sv"
  `include "cfs_algn_test_clr_check.sv"
  `include "cfs_algn_reset_test.sv"
  `include "cfs_algn_test_clock.sv"
  `include "cfs_algn_status_block_test.sv"
  `include "cfs_algn_test_reserved_bits.sv"
  `include "cfs_algn_test_slow_pace.sv"
endpackage

`endif
