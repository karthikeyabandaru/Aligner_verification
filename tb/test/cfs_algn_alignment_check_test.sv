/*
   Test Intention: To verify if the DUT is correctly aligning data with valid combinations of SIZE and OFFSET on CTRL regsiter and input packets
   Steps:
   1. Write a valid combination in the CTRL regsiter
   2. Send packets to the DUT with valid combinations
   3. Verify if the DUT is aligning it according to the programmed value in the CTRL  register
   4. Repeat the same for all the valid combinations


   **Test Intention: To check if the RX and TX bits are set when the FIFOs are drained out and W1C functionality of the bits works properly.
   **1. Since both FIFOs will become empty once all the transactions are done. A read operation to IRQ was register was performed.
   **2. Write operation was also performed on IRQ registers to verify if the bits are cleared.
   **3. Read operation on IRQ register was performed to verify the functionality.
*/


class cfs_algn_alignment_check_test extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_alignment_check_test)

  function new(string name = "cfs_algn_alignment_check_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_alignment_check seq;
    super.run_phase(phase);


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
    // Create and start the virtual sequence
    seq = cfs_algn_virtual_sequence_alignment_check::type_id::create("seq");
    seq.start(env.virtual_sequencer);

    #(1000ns);
    phase.drop_objection(this);
  endtask

endclass

