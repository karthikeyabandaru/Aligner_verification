class cfs_algn_test_clr_check extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_clr_check)
  rand int num = $urandom_range(300, 256);
  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_rx_err seq;

    //cfs_algn_virtual_sequence_irqen_write w_seq;
    phase.raise_objection(this, "TEST_DONE");
    #(100ns);
    fork
      begin
        cfs_md_sequence_slave_response_forever seq = cfs_md_sequence_slave_response_forever::type_id::create(
            "seq"
        );

        seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    repeat (num) begin
      seq = cfs_algn_virtual_sequence_rx_err::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize());

      seq.start(env.virtual_sequencer);
    end
    begin
      cfs_algn_virtual_sequence_clr_check clr_seq = cfs_algn_virtual_sequence_clr_check::type_id::create(
          "clr_seq"
      );
      clr_seq.start(env.virtual_sequencer);
    end
    repeat (num) begin
      cfs_algn_virtual_sequence_rx_err seq = cfs_algn_virtual_sequence_rx_err::type_id::create(
          "seq"
      );

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize());

      seq.start(env.virtual_sequencer);
    end
    #100;
    phase.drop_objection(this);
  endtask
endclass
