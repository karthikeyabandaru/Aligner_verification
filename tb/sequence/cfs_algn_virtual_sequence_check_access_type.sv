class cfs_algn_virtual_sequence_check_access_type extends cfs_algn_virtual_sequence_base;

  `uvm_object_utils(cfs_algn_virtual_sequence_check_access_type)

  function new(string name = "cfs_algn_virtual_sequence_check_access_type");
    super.new(name);
  endfunction

  virtual task body();

    uvm_status_e   status;
    uvm_reg_data_t read_val;
    uvm_reg        ctrl_reg;
    uvm_reg        irqen_reg;
    uvm_reg        irq_reg;
    uvm_reg        status_reg;
    uvm_reg_field size_f, offset_f, clr_f;
    uvm_reg_field    f;
    // string           fname;
    string rw_fields[];

    `uvm_info("ACCESS_TYPE", "Starting access type check", UVM_LOW)
    // --- CTRL (RW/WO fields only) ---
    ctrl_reg = p_sequencer.model.reg_block.CTRL;
    if (ctrl_reg != null) begin
      size_f   = ctrl_reg.get_field_by_name("SIZE");
      offset_f = ctrl_reg.get_field_by_name("OFFSET");
      clr_f    = ctrl_reg.get_field_by_name("CLR");

      if (size_f && offset_f && clr_f) begin
        size_f.set(1);
        offset_f.set(0);
        clr_f.set(0);  // WO write
        ctrl_reg.update(status, .parent(this), .path(UVM_FRONTDOOR));
        `uvm_info("ACCESS_TYPE", "CTRL written with legal SIZE=1, OFFSET=0--------CTRL", UVM_MEDIUM)

        ctrl_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
        `uvm_info("ACCESS_TYPE", $sformatf("CTRL read = 0x%0h", read_val), UVM_MEDIUM)
      end
    end

    // --- STATUS (all RO) ---
    status_reg = p_sequencer.model.reg_block.STATUS;
    if (status_reg != null) begin
      status_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", $sformatf("STATUS read 1 = 0x%0h", read_val), UVM_MEDIUM)

      status_reg.write(status, 32'hDEAD_BEEF, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", "STATUS attempted write (should be ignored)", UVM_LOW)

      status_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", $sformatf("STATUS read 2 = 0x%0h", read_val), UVM_MEDIUM)
    end

    // --- IRQEN (bits [4:0] are RW) ---
    irqen_reg = p_sequencer.model.reg_block.IRQEN;
    if (irqen_reg != null) begin
      rw_fields = '{"MAX_DROP", "TX_FIFO_FULL", "TX_FIFO_EMPTY", "RX_FIFO_FULL", "RX_FIFO_EMPTY"};
      for (int i = 0; i < rw_fields.size(); i++) begin
        uvm_reg_field f = irqen_reg.get_field_by_name(rw_fields[i]);
        if (f != null) f.set(1);
      end

      irqen_reg.update(status, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", "IRQEN fields [4:0] written to 1", UVM_MEDIUM)

      irqen_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", $sformatf("IRQEN read = 0x%0h", read_val), UVM_MEDIUM)
    end

    // --- IRQ (RO only) ---
    irq_reg = p_sequencer.model.reg_block.IRQ;
    if (irq_reg != null) begin
      irq_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", $sformatf("IRQ read 1 = 0x%0h", read_val), UVM_MEDIUM)

      irq_reg.write(status, 32'hABAB_ABAB, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", "IRQ attempted write (should be ignored)", UVM_LOW)
      irq_reg.write(status, 32'h0, .parent(this), .path(UVM_FRONTDOOR));
      irq_reg.read(status, read_val, .parent(this), .path(UVM_FRONTDOOR));
      `uvm_info("ACCESS_TYPE", $sformatf("IRQ read 2 = 0x%0h", read_val), UVM_MEDIUM)
    end

    `uvm_info("ACCESS_TYPE", "Completed access type check", UVM_LOW)
  endtask

endclass
