
class cfs_algn_virtual_sequence_status_block_check extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_status_block_check)

  // Handle to model
  cfs_algn_model model;
  rand int unsigned num_packets;

  constraint pkt_range {num_packets inside {[0 : 19]};}

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();

    if (!uvm_config_db#(cfs_algn_model)::get(null, get_full_name(), "model", model)) begin
      `uvm_fatal(get_type_name(), "Failed to get model from config_db")
    end
  endtask

  virtual task body();
    uvm_status_e status;
    uvm_reg_data_t status_val_before, status_val_after;
    cfs_algn_virtual_sequence_rx rx_seq;



    // Step 3: Send RX packets
    for (int i = 0; i < num_packets; i++) begin
      $display("LOOP NUMBER ----------------------------%0d", i);
      rx_seq = cfs_algn_virtual_sequence_rx::type_id::create($sformatf("rx_seq_%0d", i));
      rx_seq.set_sequencer(p_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(p_sequencer);
    end

    // Step 2: Read STATUS before sending packets
    model.reg_block.STATUS.read(status, status_val_before, UVM_FRONTDOOR);
    // Step 4: Attempt to write 0 to STATUS (assumed RO)
    model.reg_block.STATUS.set(32'h0);
    model.reg_block.STATUS.update(status);  // Should not affect a RO reg

    // Step 5: Read STATUS after packets sent
    model.reg_block.STATUS.read(status, status_val_after, UVM_FRONTDOOR);

    if (status_val_before == status_val_after)
      `uvm_info(get_type_name(), "STATUS unchanged as expected for RO register", UVM_LOW)
    else
      `uvm_warning(get_type_name(), "STATUS changed unexpectedly — check if register is not RO")
  endtask

endclass
