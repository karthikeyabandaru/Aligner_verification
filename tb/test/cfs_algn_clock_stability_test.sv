
class cfs_algn_clock_stability_test extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_clock_stability_test)

rand int num=$urandom_range(5,3);
  function new(string name = "cfs_algn_clock_stability_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uvm_status_e   status;
    uvm_reg_data_t irq_val;
cfs_md_sequence_slave_response_forever slave_seq;
    phase.raise_objection(this, "Clock halt stability test");
    // 1. Wait for initial stabilization
    #(100ns);

    fork
      begin
        slave_seq = 
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    repeat(num) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create($sformatf("seq%d",num));

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize());

      seq.start(env.virtual_sequencer);
  end
    // 2. Force clock to 0
    if (!uvm_hdl_force("testbench.clk", 1'b0)) begin
      `uvm_error(get_type_name(), "Failed to force clock to 0")
    end else begin
      `uvm_info(get_type_name(), "Clock forced to 0------------------------------------------------", UVM_LOW)
    end

    // 3. Wait while clock is halted
    #(50ns);

    // 4. Release the clock
    if (!uvm_hdl_release("testbench.clk")) begin
      `uvm_error(get_type_name(), "Failed to release clock")
    end else begin
      `uvm_info(get_type_name(), "Clock released--------------------------------------------------", UVM_LOW)
    end
    
    repeat(num) begin
    cfs_algn_virtual_sequence_rx seq2 = cfs_algn_virtual_sequence_rx::type_id::create($sformatf("seq%d",num));
      seq2.set_sequencer(env.virtual_sequencer);
      void'(seq2.randomize());
      seq2.start(env.virtual_sequencer);
  end
    // 5. Observe behavior
    #(500ns);

    // Optionally: check IRQ or STATUS registers
    if (env.model != null) begin
      env.model.reg_block.IRQ.read(status, irq_val);
      `uvm_info(get_type_name(), $sformatf("IRQ after clock release: 0x%0h", irq_val), UVM_LOW)
    end

    phase.drop_objection(this);
    #100;
  endtask

endclass
