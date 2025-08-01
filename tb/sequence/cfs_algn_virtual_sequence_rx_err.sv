///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_virtual_sequence_rx_err.sv
// Author:      Cristian Florin Slav
// Date:        2025-02-12
// Description: Virtual sequence which sends only one MD RX transaction and 
//              constraints the MD transaction to always be illegal.
///////////////////////////////////////////////////////////////////////////////

`ifndef CFS_ALGN_VIRTUAL_SEQUENCE_RX_ERR_SV
`define CFS_ALGN_VIRTUAL_SEQUENCE_RX_ERR_SV 

class cfs_algn_virtual_sequence_rx_err extends cfs_algn_virtual_sequence_rx;

  //Aligner data width
  local int unsigned algn_data_width;

  constraint illegal_rx_hard {
    (((algn_data_width / 8) + seq.item.offset) % seq.item.data.size() != 0) ||
      ((seq.item.data.size() + seq.item.offset)                         > (algn_data_width / 8));
  }

  `uvm_object_utils(cfs_algn_virtual_sequence_rx_err)

  function new(string name = "");
    super.new(name);
  endfunction

  function void pre_randomize();
    super.pre_randomize();
    if (p_sequencer == null) begin
      `uvm_error("PRE_RANDOMIZE",
                 "p_sequencer is null. Cannot proceed with algn_data_width access.")
      return;
    end
    algn_data_width = p_sequencer.model.env_config.get_algn_data_width();
  endfunction

endclass

`endif

