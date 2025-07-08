
class cfs_algn_clock_stability_test extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_clock_stability_test)

  function new(string name = "cfs_algn_clock_stability_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uvm_status_e status;
    uvm_reg_data_t irq_val;
    phase.raise_objection(this, "Clock halt stability test");

    // 1. Wait for initial stabilization
    #(100ns);

    // 2. Force clock to 0
    if (!uvm_hdl_force("testbench.dut.clk", 1'b0)) begin
      `uvm_error(get_type_name(), "Failed to force clock to 0")
    end else begin
      `uvm_info(get_type_name(), "Clock forced to 0", UVM_LOW)
    end

    // 3. Wait while clock is halted
    #(200ns);

    // 4. Release the clock
    if (!uvm_hdl_release("testbench.dut.apb_if.pclk")) begin
      `uvm_error(get_type_name(), "Failed to release clock")
    end else begin
      `uvm_info(get_type_name(), "Clock released", UVM_LOW)
    end

    // 5. Observe behavior
    #(500ns);

    // Optionally: check IRQ or STATUS registers
    if (env.model != null) begin
      env.model.reg_block.IRQ.read(status, irq_val);
      `uvm_info(get_type_name(), $sformatf("IRQ after clock release: 0x%0h", irq_val), UVM_LOW)
    end

    phase.drop_objection(this);
  endtask

endclass
