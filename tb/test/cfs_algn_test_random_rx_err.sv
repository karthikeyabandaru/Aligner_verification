///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_random_rx_err.sv
// Author:      Cristian Florin Slav
// Date:        2025-02-12
// Description: Random test which sends only illegal MD RX transactions
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_TEST_RANDOM_RX_ERR_SV
`define CFS_ALGN_TEST_RANDOM_RX_ERR_SV 

class cfs_algn_test_random_rx_err extends cfs_algn_test_random;

  // UVM registration
  `uvm_component_utils(cfs_algn_test_random_rx_err)

  // Variables
  //protected int unsigned num_md_rx_transactions;
  //cfs_algn_virtual_sequence_rx_err rx_err_seq;
 // cfs_algn_virtual_sequence_clr_check clr_seq;

  // Constructor
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
  //  num_md_rx_transactions = 260;

    // Override RX with RX_ERR sequence
    cfs_algn_virtual_sequence_rx::type_id::set_type_override(
      cfs_algn_virtual_sequence_rx_err::get_type()
    );
  endfunction

endclass

`endif

