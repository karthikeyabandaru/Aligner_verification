class cfs_algn_virtual_sequence_reg_illegal_config extends cfs_algn_virtual_sequence_base;

  rand int unsigned num_accesses;
  constraint num_accesses_default {soft num_accesses inside {[50 : 100]};}
//  int unsigned num_accesses=5;
  `uvm_object_utils(cfs_algn_virtual_sequence_reg_illegal_config)

  function new(string name = "cfs_algn_virtual_sequence_reg_illegal_config");
    super.new(name);
  endfunction

  virtual task body();
    bit [2:0] legal_size_offset[][2] = '{
        '{1, 0},
        '{1, 1},
        '{1, 2},
        '{1, 3},
        '{2, 0},
        '{2, 2},
        '{4, 0}
    };
    int i;
    bit [2:0] size;
    bit [1:0] offset;
    bit is_legal;
    uvm_reg ctrl_reg;
    uvm_status_e status;
    bit [31:0] reg_val;
uvm_reg_field size_fld, offset_fld;
    `uvm_info("SEQ", "Starting illegal config write sequence", UVM_LOW)

    // Define legal combinations (size, offset)

    for (i = 0; i < num_accesses; i++) begin

    `uvm_info("DB1",$sformatf("Inside for loop access number=%d-----------------------------------", i) , UVM_LOW)
      // Keep generating until we get an illegal combination
      do begin
        size = $urandom_range(1, 4);  // 3-bit field
        offset = $urandom_range(0, 3);  // 2-bit field
        is_legal = 0;

        foreach (legal_size_offset[j]) begin
          if ((legal_size_offset[j][0] == size) && (legal_size_offset[j][1] == offset))
            is_legal = 1;
        end
      end while (is_legal);

      // Set illegal fields using RAL
      ctrl_reg = p_sequencer.model.reg_block.CTRL;

      ctrl_reg.get_field_by_name("SIZE").set(size);
      ctrl_reg.get_field_by_name("OFFSET").set(offset);
      ctrl_reg.get_field_by_name("CLR").set(0);  // Assuming 0 for now

      //reg_val = ctrl_reg.get();
      ctrl_reg.update(status,.parent(this), .path(UVM_FRONTDOOR));
size_fld   = ctrl_reg.get_field_by_name("SIZE");
offset_fld = ctrl_reg.get_field_by_name("OFFSET");

if (size_fld != null && offset_fld != null) begin
  `uvm_info("CTRL_WRITE", $sformatf("Wrote CTRL: SIZE = %0d, OFFSET = %0d",
                                     size_fld.get(), offset_fld.get()), UVM_MEDIUM)
end else begin
  `uvm_warning("CTRL_WRITE", "SIZE or OFFSET field not found")
end
`uvm_info("SEQ", $sformatf("Sent illegal config: size=%0d offset=%0d", size, offset), UVM_LOW)

      wait_random_time();
    end

    `uvm_info("SEQ", "Done illegal config write sequence", UVM_LOW)
  endtask

  protected virtual task wait_random_time();
    cfs_algn_vif vif = p_sequencer.model.env_config.get_vif();
    int delay = $urandom_range(10, 0);
    repeat (delay) @(posedge vif.clk);
  endtask

endclass
