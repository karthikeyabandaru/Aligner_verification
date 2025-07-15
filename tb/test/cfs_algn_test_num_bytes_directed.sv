class cfs_algn_test_num_bytes_directed extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_num_bytes_directed)

  function new(string name = "cfs_algn_test_num_bytes_directed", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_num_bytes_directed seq;

    phase.raise_objection(this);

    // Small delay before starting
    #100ns;

    fork
      begin

        cfs_md_sequence_slave_response_forever slave_seq = 
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    seq = cfs_algn_virtual_sequence_num_bytes_directed::type_id::create("seq");

    // Connect virtual sequencer
    seq.start(env.virtual_sequencer);

    // Allow time for transaction completion
    #100ns;

    phase.drop_objection(this);
  endtask

endclass

