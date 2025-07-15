///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_random.sv
// Author:      Cristian Florin Slav
// Date:        2023-12-17
// Description: Random test
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_TEST_RANDOM_SV
`define CFS_ALGN_TEST_RANDOM_SV 

class cfs_algn_test_random extends cfs_algn_test_base;

  //Number of MD RX transactions
  rand protected int unsigned num_md_rx_transactions = $urandom_range(1000, 256);

  `uvm_component_utils(cfs_algn_test_random)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);

    //num_md_rx_transactions = 20;
  endfunction

  virtual task run_phase(uvm_phase phase);
    uvm_status_e status;
    cfs_algn_virtual_sequence_rx seq;
    phase.raise_objection(this, "TEST_DONE");

    #(100ns);

    fork
      begin

        cfs_md_sequence_slave_response_forever slave_seq = 
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    if (env.model.is_empty()) begin
      cfs_algn_virtual_sequence_reg_config seq = cfs_algn_virtual_sequence_reg_config::type_id::create(
          "seq"
      );

      void'(seq.randomize());

      seq.start(env.virtual_sequencer);
    end


    ////////////////////////////////////////////////////////////////////////////////
    repeat (num_md_rx_transactions) begin
      cfs_algn_virtual_sequence_rx seq = cfs_algn_virtual_sequence_rx::type_id::create("seq");

      seq.set_sequencer(env.virtual_sequencer);

      void'(seq.randomize());

      seq.start(env.virtual_sequencer);
    end
    ////////////////////////////////////////////////////////////////////////////////
    begin
      cfs_algn_vif vif = env.env_config.get_vif();

      repeat (100) begin
        @(posedge vif.clk);
      end
    end
    /////////////////////////////////////////////////////////////////////////////////      




    /////////////////////////////////////////////////////////////////////////////////      
    /*begin
        cfs_algn_virtual_sequence_clr_check clr_seq = cfs_algn_virtual_sequence_clr_check::type_id::create(
            "clr_seq");
        clr_seq.start(env.virtual_sequencer);
      end*/
    //////////////This was used to check the CLR bit functionality but was
    //running the test_random_rx_err
    /////////////////////////////////////////////////////////////////////////////////      



    //////////////////////////////////////////////////////////////////////////////////
    /*begin
        cfs_algn_virtual_sequence_reg_status seq = cfs_algn_virtual_sequence_reg_status::type_id::create(
            "seq"
        );

        void'(seq.randomize());

        seq.start(env.virtual_sequencer);
      end*/
    // Use this whenever required, used this in illegal config test for
    // CTRL.SIZE and CTRL.OFFSET
    /////////////////////////////////////////////////////////////////////////////////

    begin
      cfs_algn_virtual_sequence_irq_rw seq = cfs_algn_virtual_sequence_irq_rw::type_id::create(
          "seq"
      );
      seq.start(env.virtual_sequencer);
    end
    #(500ns);

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif

