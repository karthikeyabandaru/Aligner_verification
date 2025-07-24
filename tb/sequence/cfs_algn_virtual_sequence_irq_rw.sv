class cfs_algn_virtual_sequence_irq_rw extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_irq_rw)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e   status;
    uvm_reg_data_t read_val;

    p_sequencer.model.reg_block.IRQ.read(status, read_val, UVM_FRONTDOOR);

    p_sequencer.model.reg_block.IRQ.write(status, 32'h0, UVM_FRONTDOOR);
    p_sequencer.model.reg_block.IRQ.read(status, read_val, UVM_FRONTDOOR);
    p_sequencer.model.reg_block.IRQ.write(status, 32'hFFFF_FF1F, UVM_FRONTDOOR);

    `uvm_info(get_type_name(), "Reading IRQ register", UVM_MEDIUM)
    p_sequencer.model.reg_block.IRQ.read(status, read_val, UVM_FRONTDOOR);

  endtask

endclass
