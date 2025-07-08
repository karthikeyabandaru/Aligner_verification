/*
* Test Intention: To verify the reset functionality and see if the DUT
* responds accordingly
    * 1. Start the complete slave response forever sequence
    * 2. Get the interface using config_db
    * 3. Assert reset_n=1
    * 4. Send some Random number pf packets
    * 5. Make reset_n=0
    * 6. Read IRQ and STATUS register.
*/
class cfs_algn_reset_test extends cfs_algn_test_base;
  `uvm_component_utils(cfs_algn_reset_test)

  function new(string name = "cfs_algn_reset_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_vif vif;
    cfs_algn_virtual_sequence_rx rx_seq;
    uvm_status_e status;
    uvm_reg_data_t irq_val;
    uvm_reg_data_t status_val;
int num_packets;
int i;
    phase.raise_objection(this, "Reset Test Start");
    #(100ns);
fork
      begin
        cfs_md_sequence_slave_response_forever seq = cfs_md_sequence_slave_response_forever::type_id::create(
            "seq"
        );

        seq.start(env.md_tx_agent.sequencer);
      end
    join_none
    // 🔹 Get the virtual interface directly
    if (!uvm_config_db#(cfs_algn_vif)::get(null, "*", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Failed to get vif from config_db")
    end

    // 🔹 Deassert reset to begin normal operation
    vif.reset_n <= 1;
    repeat (3) @(posedge vif.clk);

    // 🔹 Send random number of RX packets (50–100)
    num_packets = $urandom_range(10, 20);
    `uvm_info(get_type_name(), $sformatf("Sending %0d RX packets before reset...", num_packets), UVM_MEDIUM)
    for (i = 0; i < num_packets; i++) begin
        $display("LOOP NUMBER ----------------------------%0d",i);
      rx_seq = cfs_algn_virtual_sequence_rx::type_id::create($sformatf("rx_seq_%0d",i));
      rx_seq.set_sequencer(env.virtual_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(env.virtual_sequencer);
    end
//disable fork;
    // 🔹 Unexpected reset
    `uvm_info(get_type_name(), "Applying unexpected reset...", UVM_MEDIUM)
    vif.reset_n <= 0;
    repeat (5) @(posedge vif.clk);
    vif.reset_n <= 1;
    repeat (5) @(posedge vif.clk);
#50;
    // 🔹 Check IRQ register
    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    if (irq_val != 0)
      `uvm_error(get_type_name(), $sformatf("IRQ register not cleared after reset: 0x%0h", irq_val))
    else
      `uvm_info(get_type_name(), "IRQ register correctly cleared post-reset", UVM_MEDIUM)

    // 🔹 Check STATUS register
    env.model.reg_block.STATUS.read(status, status_val, UVM_FRONTDOOR);
    if (status_val != 0)
      `uvm_error(get_type_name(), $sformatf("STATUS register not cleared after reset: 0x%0h", status_val))
    else
      `uvm_info(get_type_name(), "STATUS register correctly cleared post-reset", UVM_MEDIUM)

    phase.drop_objection(this);
  endtask
endclass

