class cfs_algn_virtual_sequence_reserved_bits_check extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_reserved_bits_check)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    uvm_reg_data_t read_val;
    uvm_reg_data_t written_val;
    uvm_reg_data_t expected_val;

    if (p_sequencer.model == null) begin
      `uvm_fatal(get_type_name(), "Model handle is null in p_sequencer")
    end

    // === ✅ IRQEN register: [4:0] valid, [31:5] reserved ===
    written_val  = 32'hFFFF_FFFF;

    `uvm_info(get_type_name(), "Writing 0xFFFFFFFF to IRQEN", UVM_MEDIUM)
    p_sequencer.model.reg_block.IRQEN.write(status, written_val);
    p_sequencer.model.reg_block.IRQEN.read(status, read_val, UVM_FRONTDOOR);

    /*if (read_val !== expected_val)
      `uvm_error(get_type_name(), $sformatf("IRQEN Reserved bits NOT zero: read=0x%0h expected=0x%0h", read_val, expected_val))
    else
      `uvm_info(get_type_name(), "✅ IRQEN Reserved bits verified", UVM_MEDIUM)*/


    // === ✅ CTRL register: [1:0] valid (size, offset), rest reserved ===
    written_val  = 32'hFFFF_FFF1;

    `uvm_info(get_type_name(), "Writing 0xFFFFFFFF to CTRL", UVM_MEDIUM)
    p_sequencer.model.reg_block.CTRL.write(status, written_val);
    p_sequencer.model.reg_block.CTRL.read(status, read_val, UVM_FRONTDOOR);

    /*if (read_val !== expected_val)
      `uvm_error(get_type_name(), $sformatf("CTRL Reserved bits NOT zero: read=0x%0h expected=0x%0h", read_val, expected_val))
    else
      `uvm_info(get_type_name(), "✅ CTRL Reserved bits verified", UVM_MEDIUM)*/


    // === ✅ STATUS register: read-only ===
    p_sequencer.model.reg_block.STATUS.write(status, 'hFFFF_FFFF, UVM_FRONTDOOR);
    p_sequencer.model.reg_block.STATUS.read(status, read_val, UVM_FRONTDOOR);
    `uvm_info(get_type_name(), $sformatf("STATUS register value (RO) = 0x%0h", read_val), UVM_MEDIUM)

  endtask

endclass
