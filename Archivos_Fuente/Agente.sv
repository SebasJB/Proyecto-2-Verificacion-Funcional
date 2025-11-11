class router_agent extends uvm_agent;
  `uvm_component_utils(router_agent)
  
  driver                drv;      
  monitor               mon;      
  uvm_sequencer #(drv_item)  seq;
  router_agent_cfg    cfg;      

  function new(string name="router_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(router_agent_cfg)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal("AGENT", "Could not get agent configuration object")
    end
    seq = uvm_sequencer#(drv_item)::type_id::create("seq", this);
    drv = driver::type_id::create("drv", this);
    mon = monitor::type_id::create("mon", this);
    `uvm_config_db#(router_agent_cfg)::set(this, "seq", "cfg", cfg);
    `uvm_config_db#(router_agent_cfg)::set(this, "drv", "cfg", cfg);
    `uvm_config_db#(router_agent_cfg)::set(this, "mon", "cfg", cfg);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seq.seq_item_export); 
  endfunction
endclass
