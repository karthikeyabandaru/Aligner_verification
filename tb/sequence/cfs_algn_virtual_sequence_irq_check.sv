class cfs_algn_virtual_sequence_irq_check extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_irq_check)

  cfs_algn_virtual_sequence_rx rx_seq;
  cfs_algn_model model; // Reference model handle

  function new(string name = "");
    super.new(name);
    rx_seq = cfs_algn_virtual_sequence_rx::type_id::create("rx_seq");
  endfunction

  virtual task pre_body();
    super.pre_body();

    if (!uvm_config_db#(cfs_algn_model)::get(null, get_full_name(), "model", model)) begin
      `uvm_fatal(get_type_name(), "Unable to get reference model from config_db")
    end
  endtask

  virtual task body();
    uvm_status_e status;
    uvm_reg_data_t irq_val;
    uvm_reg_data_t status_val;
    `uvm_info(get_type_name(), "Starting IRQ check sequence with RAL", UVM_MEDIUM)

    // 1. Configure CTRL Register: size = 1, offset = 0
    model.reg_block.CTRL.set(32'h1);
    model.reg_block.CTRL.update(status);

    // 2. Enable all interrupts
    model.reg_block.IRQEN.set(32'h1F);
    model.reg_block.IRQEN.update(status);

    // 3. Drive 1 valid RX packet with size=1, offset=0
    for (int i = 0; i < 19; i++) begin
      `uvm_info("LOOP", $sformatf("Loop number ---------------- %0d", i), UVM_LOW)
      rx_seq.seq.item.data.delete();
      rx_seq.seq.item.data = new[1];
      rx_seq.seq.item.data[0] = $urandom_range(0, 255);
      rx_seq.seq.item.offset = 0;
      rx_seq.start(p_sequencer);
    end


    `uvm_info(get_type_name(), "Completed IRQ check sequence", UVM_MEDIUM)
  endtask

endclass

