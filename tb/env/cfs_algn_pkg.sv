///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_pkg.sv
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Environment package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_PKG_SV
`define CFS_ALGN_PKG_SV 

`include "uvm_macros.svh"

`include "../agent_uvm_ext/uvm_ext_pkg.sv"
`include "../agent_apb/cfs_apb_pkg.sv"
`include "../agent_md/cfs_md_pkg.sv"
`include "../model/cfs_algn_reg_pkg.sv"

`include "../model/cfs_algn_if.sv"

package cfs_algn_pkg;
  import uvm_pkg::*;
  import uvm_ext_pkg::*;
  import cfs_apb_pkg::*;
  import cfs_md_pkg::*;
  import cfs_algn_reg_pkg::*;

  `include "../model/cfs_algn_types.sv"
  `include "cfs_algn_env_config.sv"
  `include "../model/cfs_algn_clr_cnt_drop.sv"
  `include "../coverage/cfs_algn_split_info.sv"
  `include "../model/cfs_algn_model.sv"
  `include "../coverage/cfs_algn_coverage.sv"
  `include "../model/cfs_algn_reg_access_status_info.sv"
  `include "../model/cfs_algn_reg_predictor.sv"
  `include "../scoreboard/cfs_algn_scoreboard.sv"
  `include "../virtual_sequencer/cfs_algn_virtual_sequencer.sv"
  `include "cfs_algn_env.sv"

  `include "../sequence/cfs_algn_seq_reg_config.sv"

  `include "../sequence/cfs_algn_virtual_sequence_base.sv"
  `include "../sequence/cfs_algn_virtual_sequence_slow_pace.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reg_access_random.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reg_access_unmapped.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reg_config.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reg_status.sv"
  `include "../sequence/cfs_algn_virtual_sequence_rx.sv"
  `include "../sequence/cfs_algn_virtual_sequence_rx_err.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reg_illegal_config.sv"
  `include "../sequence/cfs_algn_virtual_sequence_check_access_type.sv"
  `include "../sequence/cfs_algn_virtual_sequence_clr_check.sv"
  `include "../sequence/cfs_algn_virtual_sequence_irq_check.sv"
  `include "../sequence/cfs_algn_virtual_sequence_alignment_check.sv"
  `include "../sequence/cfs_algn_virtual_sequence_irq_rw.sv"
  `include "../sequence/cfs_algn_virtual_sequence_reserved_bits_check.sv"
  `include "../sequence/cfs_algn_virtual_sequence_status_block_check.sv"
  `include "../sequence/cfs_algn_virtual_sequence_split_legal_combinations.sv"
  `include "../sequence/cfs_algn_virtual_sequence_ctrlsize_directed.sv"
  `include "../sequence/cfs_algn_virtual_sequence_num_bytes_directed.sv"
  `include "../sequence/cfs_algn_virtual_sequence_split_cover_directed.sv"
  `include "../sequence/cfs_algn_virtual_sequence_split_cross_cover_directed.sv"
  `include "../sequence/cfs_algn_virtual_sequence_ctrl4_off0_two_pkts.sv"
  `include "../sequence/cfs_algn_virtual_sequence_rx_size0.sv"
  `include "../sequence/cfs_algn_virtual_sequence_irq_check_2.sv"

endpackage

`endif

