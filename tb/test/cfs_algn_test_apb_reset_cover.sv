class cfs_algn_test_apb_reset_cover extends cfs_algn_test_base;
  `uvm_component_utils(cfs_algn_test_apb_reset_cover)
  function new(string name = "cfs_algn_test_apb_reset_cover", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
      cfs_apb_vif vif;
    phase.raise_objection(this);
    #(100ns);
    /*fork
      begin

        cfs_md_sequence_slave_response_forever slave_seq = 
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none*/

    // === Case 1: Reset when no APB access is ongoing (psel = 0) ===
    `uvm_info(get_type_name(), "Asserting reset with psel = 0", UVM_LOW)
    vif=env.apb_agent.agent_config.get_vif();
vif.preset_n <= 1'b0;
    #10ns;
    vif.preset_n <= 1'b1;
    #50ns;

    // === Case 2: Reset during APB access (psel = 1) ===
    `uvm_info(get_type_name(), "Asserting reset during APB access (psel = 1)", UVM_LOW)
    fork
      begin
        cfs_apb_sequence_simple apb_seq;
        apb_seq = cfs_apb_sequence_simple::type_id::create("apb_seq");

        assert(apb_seq.randomize() with {
          item.addr == 32'h4;
          item.dir == CFS_APB_WRITE;
          item.data == 32'hBEEF_DEAD;
          item.pre_drive_delay == 1;
          item.post_drive_delay == 10;
        });

        apb_seq.start(env.apb_agent.sequencer);
      end
      begin
        // Assert reset while APB transaction is ongoing (psel is 1)
        @(posedge vif.psel)
        #2ns;
        vif.preset_n <= 1'b0;
        #10ns;
        vif.preset_n <= 1'b1;
      end
    join

    #(100ns);
    phase.drop_objection(this);
  endtask
endclass

