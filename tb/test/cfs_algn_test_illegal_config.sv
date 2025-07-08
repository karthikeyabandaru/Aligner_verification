class cfs_algn_test_illegal_config extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_illegal_config)

  function new(string name = "cfs_algn_test_illegal_config", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uvm_status_e status;
cfs_algn_virtual_sequence_reg_illegal_config i_seq;
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
begin 
        i_seq = cfs_algn_virtual_sequence_reg_illegal_config::type_id::create("i_seq");

        void'(i_seq.randomize());

        i_seq.start(env.virtual_sequencer);
    end
      begin
        cfs_algn_vif vif = env.env_config.get_vif();

        repeat (100) begin
          @(posedge vif.clk);
        end
      end

      begin
        cfs_algn_virtual_sequence_reg_status seq = cfs_algn_virtual_sequence_reg_status::type_id::create(
            "seq"
        );

        void'(seq.randomize());

        seq.start(env.virtual_sequencer);
      end
      #100;
    phase.drop_objection(this);
  endtask
endclass
