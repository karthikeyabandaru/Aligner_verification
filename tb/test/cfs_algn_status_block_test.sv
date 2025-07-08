
class cfs_algn_status_block_test extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_status_block_test)

  function new(string name = "cfs_algn_status_block_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_status_block_check status_seq;

    phase.raise_objection(this);
#100;
    fork
      begin
          cfs_md_sequence_md_tx_ready_block block_seq = 
        cfs_md_sequence_md_tx_ready_block::type_id::create("block_seq");
      block_seq.start(env.md_tx_agent.sequencer);
              end
    join_none
    status_seq = cfs_algn_virtual_sequence_status_block_check::type_id::create("status_seq");

      void'(status_seq.randomize());
    status_seq.start(env.virtual_sequencer);
#100;
    phase.drop_objection(this);
  endtask

endclass
