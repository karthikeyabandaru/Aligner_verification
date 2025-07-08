class cfs_algn_virtual_sequence_alignment_check extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_alignment_check)

  cfs_algn_virtual_sequence_rx rx_seq;
  cfs_algn_model model;

  // All valid (size, offset) pairs
  int sizes[7]   = '{1, 1, 1, 1, 2, 2, 4};
  int offsets[7] = '{0, 1, 2, 3, 0, 2, 0};

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
    uvm_reg_data_t ctrl_val;
uvm_reg_data_t irq_val;
uvm_reg_data_t irq_clear_val = 32'hF;
      int size   =1;
      int offset =0;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
      size   =1;
      offset =1;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end

      size   =1;
      offset =2;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
      size   =1;
      offset =3;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
      size   =2;
      offset =0;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
      size   =2;
      offset =2;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
      size   =4;
      offset =0;
      // Encode size/offset into CTRL register (assuming LSBs represent offset, next bits represent size)
      ctrl_val = (offset << 8) | (size & 3'b111); // adjust bit positions if different in your RTL
      model.reg_block.CTRL.set(ctrl_val);
      model.reg_block.CTRL.update(status);

      `uvm_info(get_type_name(), $sformatf("CTRL set to size=%0d, offset=%0d (value=0x%0h)---------------------------------------------------", size, offset, ctrl_val), UVM_MEDIUM)

      // Drive 7 matching RX packets
      for (int j = 0; j < 7; j++) begin
        rx_seq.seq.item.data.delete();
        void'(rx_seq.seq.item.randomize() with {
      data.size() == sizes[j];
      offset      == offsets[j];
      data.size() + offset <= 4;
    }); 

        rx_seq.start(p_sequencer);
      end
    `uvm_info(get_type_name(), "Completed full alignment test across all combinations",UVM_MEDIUM)

    //TEST FOR CLEARING INTERRUPT BITS BY WRITING 1 TO THEM
model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
model.reg_block.IRQ.write(status, irq_clear_val, UVM_FRONTDOOR);

`uvm_info(get_type_name(), $sformatf("Wrote 0x%0h to IRQ register", irq_clear_val), UVM_MEDIUM)
model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
  endtask

endclass

