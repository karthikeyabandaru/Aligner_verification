class cfs_algn_virtual_sequence_num_bytes_directed extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_num_bytes_directed)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();
    cfs_md_sequence_slave_response_forever slave_seq;
    cfs_algn_virtual_sequence_rx rx_seq;

    uvm_status_e status;
    uvm_reg_data_t ctrl_val;

    // Configure CTRL register: SIZE=4, OFFSET=0
    ctrl_val = 0;
    ctrl_val[2:0] = 3'd4;   // SIZE
    ctrl_val[9:8] = 2'd0;   // OFFSET
    p_sequencer.model.reg_block.CTRL.write(status, ctrl_val);
    `uvm_info(get_type_name(), $sformatf("Wrote CTRL = 0x%08x", ctrl_val), UVM_LOW)

    // Start forever slave response
    // === First RX Packet: size = 1, offset = 0 ===
    rx_seq = cfs_algn_virtual_sequence_rx::type_id::create("rx_seq_1");
    void'(rx_seq.seq.item.randomize() with {
      data.size() == 1;
      offset == 0;
    });
    rx_seq.start(p_sequencer);

    // === Second RX Packet: size = 4, offset = 0 ===
    rx_seq = cfs_algn_virtual_sequence_rx::type_id::create("rx_seq_2");
    void'(rx_seq.seq.item.randomize() with {
      data.size() == 4;
      offset == 0;
    });
    rx_seq.start(p_sequencer);
    repeat(3) begin
rx_seq = cfs_algn_virtual_sequence_rx::type_id::create("rx_seq_2");
    void'(rx_seq.seq.item.randomize() with {
      data.size() == 1;
      offset == 3;
    });
    rx_seq.start(p_sequencer);
end
  endtask

endclass
