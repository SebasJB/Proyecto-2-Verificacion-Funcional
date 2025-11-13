class router_agent extends uvm_agent;
  `uvm_component_utils(router_agent)
  
  driver                drv;      
  monitor               mon;      
  uvm_sequencer #(drv_item)  sequencer;    

  function new(string name="router_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = uvm_sequencer#(drv_item)::type_id::create("sequencer", this);
    drv = driver::type_id::create("drv", this);
    mon = monitor::type_id::create("mon", this);
    `uvm_info(get_type_name(), "agt build_phase completed", UVM_HIGH);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sequencer.seq_item_export); 
  endfunction
endclass
