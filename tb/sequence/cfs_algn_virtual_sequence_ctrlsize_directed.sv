class cfs_algn_virtual_sequence_ctrlsize_directed extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_ctrlsize_directed)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    uvm_reg_data_t ctrl_val;

    int ctrl_offsets[] = '{0};
    int ctrl_sizes[]   = '{3, 4}; // values we want to hit

    foreach (ctrl_offsets[i]) begin
      foreach (ctrl_sizes[j]) begin
        ctrl_val = 0;
        ctrl_val[2:0] = ctrl_sizes[j];   // SIZE in bits [2:0]
        ctrl_val[9:8] = ctrl_offsets[i]; // OFFSET in bits [9:8]

        `uvm_info(get_type_name(), $sformatf("Writing CTRL reg with OFFSET=%0d, SIZE=%0d", 
                    ctrl_offsets[i], ctrl_sizes[j]), UVM_LOW)

        p_sequencer.model.reg_block.CTRL.write(status, ctrl_val);

        #10ns; // Let it be sampled
      end
    end
  endtask

endclass

