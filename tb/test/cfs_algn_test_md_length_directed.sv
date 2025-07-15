class cfs_algn_test_md_length_directed extends cfs_algn_test_base;
  `uvm_component_utils(cfs_algn_test_md_length_directed)

  function new(string name = "cfs_algn_test_md_length_directed", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
      uvm_status_e status;
    cfs_md_sequence_slave_response_forever slave_seq;
cfs_md_sequence_length_directed_7 seq7; 
cfs_md_sequence_length_directed_8 seq8;
cfs_md_sequence_length_directed_9 seq9;
cfs_md_sequence_length_directed_10 seq10;
    phase.raise_objection(this);
    #(100ns);
env.model.reg_block.CTRL.write(status, 32'h2, UVM_FRONTDOOR);
    fork
      begin
        slave_seq = cfs_md_sequence_slave_response_forever::type_id::create("slave_seq");
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none
fork
   seq7=cfs_md_sequence_length_directed_7::type_id::create("seq7");
   seq7.start(env.md_tx_agent.sequencer);
join_none
    repeat (10) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize()with {
            seq.item.data.size()==1;
            seq.item.offset==0;});

      seq.start(env.virtual_sequencer);
    end
    #50;
fork
   seq8=cfs_md_sequence_length_directed_8::type_id::create("seq8");
   seq8.start(env.md_tx_agent.sequencer);
join_none
    repeat (10) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize()with {
            seq.item.data.size()==1;
            seq.item.offset==0;});
      seq.start(env.virtual_sequencer);
    end
    #50;
fork
   seq9=cfs_md_sequence_length_directed_9::type_id::create("seq9");
   seq9.start(env.md_tx_agent.sequencer);
join_none
    repeat (10) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize()with {
            seq.item.data.size()==1;
            seq.item.offset==0;});
      seq.start(env.virtual_sequencer);
    end
    #50;
fork
   seq10=cfs_md_sequence_length_directed_10::type_id::create("seq10");
   seq10.start(env.md_tx_agent.sequencer);
join_none
    repeat (10) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize()with {
            seq.item.data.size()==1;
            seq.item.offset==0;});
      seq.start(env.virtual_sequencer);
    end
    #(100ns);
    phase.drop_objection(this);
  endtask
endclass

