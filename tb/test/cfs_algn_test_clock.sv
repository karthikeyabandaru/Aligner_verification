
//import uvm_pkg::*;
//`include "uvm_macros.svh"

  import "DPI-C" context task force_clk_zero();
  import "DPI-C" context task release_clk();
class cfs_algn_test_clock extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_clock)

  function new(string name = "cfs_algn_test_clock", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // DPI-C function declarations

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "Clock Glitch Test Start");

    `uvm_info(get_type_name(), "Forcing clk = 0 using DPI", UVM_MEDIUM)
    force_clk_zero();               // Force clock to 0
    #(200ns);                       // Hold for a while

    `uvm_info(get_type_name(), "Releasing clk using DPI", UVM_MEDIUM)
    release_clk();                  // Release back to TB clocking
    #(300ns);                       // Wait to observe normal behavior

    `uvm_info(get_type_name(), "Clock glitch test completed", UVM_MEDIUM)
    phase.drop_objection(this);
  endtask

endclass
