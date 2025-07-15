
class cfs_algn_test_slow_pace extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_slow_pace)

  function new(string name = "cfs_algn_test_slow_pace", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_slow_pace seq;

    phase.raise_objection(this, "Slow Pace RX-TX Test");

    // 🔹 Start slave response forever to support TX side responses
    fork
      begin
        cfs_md_sequence_slave_response_forever slave_seq =
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    // 🔹 Run the RX-to-TX slow paced virtual sequence
    seq = cfs_algn_virtual_sequence_slow_pace::type_id::create("seq");
    seq.start(env.virtual_sequencer);

    #(100ns);
    phase.drop_objection(this, "Slow Pace RX-TX Test Done");
  endtask

endclass
