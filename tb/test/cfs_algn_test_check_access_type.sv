
`ifndef CFS_ALGN_TEST_CHECK_ACCESS_TYPE_SV
`define CFS_ALGN_TEST_CHECK_ACCESS_TYPE_SV

class cfs_algn_test_check_access_type extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_check_access_type)

  function new(string name = "cfs_algn_test_check_access_type", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_check_access_type seq;
    phase.raise_objection(this);

    #(100ns);

    fork
      begin
        cfs_md_sequence_slave_response_forever seq = cfs_md_sequence_slave_response_forever::type_id::create(
            "seq"
        );

        seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    // Start only the new access check sequence
    seq = cfs_algn_virtual_sequence_check_access_type::type_id::create("seq");
    seq.start(env.virtual_sequencer);

    #(500ns);

    phase.drop_objection(this);
  endtask

endclass

`endif
