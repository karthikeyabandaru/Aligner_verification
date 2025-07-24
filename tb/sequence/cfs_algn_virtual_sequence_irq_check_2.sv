
class cfs_algn_virtual_sequence_irq_check_2 extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_irq_check_2)

  cfs_algn_virtual_sequence_rx rx_seq;
  cfs_algn_virtual_sequence_rx_err rx_err;
  cfs_algn_model model;  // Reference model handle

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
    uvm_status_e   status;
    uvm_reg_data_t irq_val;
    uvm_reg_data_t status_val;
cfs_algn_virtual_sequence_rx rx_seq2;
    `uvm_info(get_type_name(), "Starting IRQ check sequence with RAL", UVM_MEDIUM)

    // 1. Configure CTRL Register: size = 1, offset = 0
    model.reg_block.CTRL.set(32'h4);
    model.reg_block.CTRL.update(status);

    // 2. Enable all interrupts
    model.reg_block.IRQEN.set(32'h1D);
    model.reg_block.IRQEN.update(status);

    // 3. Drive 1 valid RX packet with size=1, offset=0
    for (int i = 0; i < 20; i++) begin
      `uvm_info("LOOP", $sformatf("Loop number ---------------- %0d", i), UVM_LOW)
      rx_seq.seq.item.data.delete();
      rx_seq.seq.item.data = new[1];
      rx_seq.seq.item.data[0] = $urandom_range(0, 255);
      rx_seq.seq.item.offset = 0;
      rx_seq.start(p_sequencer);
      if(i==7) begin
          #10;
           model.reg_block.STATUS.read(status, status_val);
       end
       rx_seq2 = cfs_algn_virtual_sequence_rx::type_id::create($sformatf("rx%d",i));

    void'(rx_seq2.seq.item.randomize() with {
      data.size() == 4;
      offset == 0;
    });

    rx_seq2.start(p_sequencer);
  end
  //void'(rx_err.randomize());
 // rx_err.set_sequencer();
//rx_err.start(p_sequencer);

    model.reg_block.STATUS.read(status, status_val);

    `uvm_info(get_type_name(), "Completed IRQ check 2 sequence", UVM_MEDIUM)
  endtask

endclass

