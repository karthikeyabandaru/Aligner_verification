/*
* Test Intention: To verify the read only nature of Reserved bits in
* IRQEN, CTRL registers and STATUS register
* 1. Write all 1s to IRQEN register, Read to get 'h1F
* 2. Write 'hFFFF_FFF1 to CTRL regsiter and read to get 'h301
* 3. Write all 1s to STATUS regsiter and read to get all 0s
*/
class cfs_algn_test_reserved_bits extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_test_reserved_bits)

  function new(string name = "cfs_algn_test_reserved_bits", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_algn_virtual_sequence_reserved_bits_check seq;
    phase.raise_objection(this, "Starting Reserved Bits Test");
    #100;
    // Create and start the reserved bits check sequence
    seq = cfs_algn_virtual_sequence_reserved_bits_check::type_id::create("seq");
    seq.start(env.virtual_sequencer);
    #100;
    phase.drop_objection(this, "Reserved Bits Test Complete");
  endtask

endclass
