`ifndef CFS_ALGN_VIRTUAL_SEQUENCE_CLR_CHECK_SV
`define CFS_ALGN_VIRTUAL_SEQUENCE_CLR_CHECK_SV

class cfs_algn_virtual_sequence_clr_check extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_clr_check)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    int cnt_before, cnt_after;

    `uvm_info("CLR_CHECK", "Starting CLR bit functional check sequence", UVM_MEDIUM)

    // Read CNT_DROP before clearing
    `uvm_info("CLR_CHECK", "Reading CNT_DROP before CLR...", UVM_MEDIUM)
    p_sequencer.model.reg_block.STATUS.read(status, cnt_before);

    // Write 1 to CLR bit
    p_sequencer.model.reg_block.CTRL.CLR.set(1);
    p_sequencer.model.reg_block.CTRL.update(status);
    `uvm_info("CLR_CHECK", "Wrote 1 to CLR bit to clear CNT_DROP", UVM_MEDIUM)

    // Read CNT_DROP after CLR
    p_sequencer.model.reg_block.STATUS.read(status, cnt_after);

    if (cnt_after == 0) `uvm_info("CLR_CHECK", "CLR bit cleared CNT_DROP successfully", UVM_LOW)
    else
      `uvm_error("CLR_CHECK", $sformatf("CLR bit failed to clear CNT_DROP, still = %0d", cnt_after))

    // Reset CLR = 0 after operation
    p_sequencer.model.reg_block.CTRL.CLR.set(0);
    p_sequencer.model.reg_block.CTRL.update(status);
    `uvm_info("CLR_CHECK", "Wrote 0 to CLR bit (reset)", UVM_MEDIUM)

    `uvm_info("CLR_CHECK", "Completed CLR bit functional check sequence", UVM_MEDIUM)
  endtask

endclass

`endif

