/*
*   Test Intention: To verify the FIFO full conditions and check the W1C
*   functionality of IRQ bits
*   
    *   Test Steps:
    *   1. Make md_tx_ready=0
    *   2. Send packets with CTRL OFFSET=0 and SIZE =1
    *   3. Enable all the interrupts in IRQEN
    *   4. Drive 20 packets with same SIZE and OFFSET
    *   5. Read IRQ register
    *   6. Clear IRQ register
    *   7. Read IRQ register
Next steps to be added: Back relief
1. Remove md_tx_ready=0
2. Let packets go out
*/
class cfs_algn_irq_check_test extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_irq_check_test)

  function new(string name = "cfs_algn_irq_check_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_irq_check irq_seq;
    cfs_algn_virtual_sequence_irq_rw rw_seq;
    cfs_algn_virtual_sequence_rx rx_seq;
    int i;
    phase.raise_objection(this);

    #(100ns);

    // === 2. Block md_tx_ready using ready_at_end == 0 ===
    fork
      begin : block_tx
        cfs_md_sequence_md_tx_ready_block block_seq = 
        cfs_md_sequence_md_tx_ready_block::type_id::create(
            "block_seq"
        );
        block_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    // === 3. Run the IRQ check virtual sequence ===
    irq_seq = cfs_algn_virtual_sequence_irq_check::type_id::create("irq_seq");
    irq_seq.randomize();
    irq_seq.start(env.virtual_sequencer);

    #(150ns);

    rw_seq = cfs_algn_virtual_sequence_irq_rw::type_id::create("rw_seq");
    rw_seq.start(env.virtual_sequencer);
    $display("[%0t] Disabling fork", $time);
    disable block_tx;
    fork
      begin
        cfs_md_sequence_slave_response_forever slave_seq = 
            cfs_md_sequence_slave_response_forever::type_id::create(
            "slave_seq"
        );
        slave_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    /*repeat(1) begin 
    rx_seq = cfs_algn_virtual_sequence_rx::type_id::create("rx_seq");
    rx_seq.set_sequencer(env.virtual_sequencer);
    rx_seq.randomize();
    rx_seq.start(env.virtual_sequencer);
end*/
    #(600ns);
    phase.drop_objection(this);
  endtask

endclass
