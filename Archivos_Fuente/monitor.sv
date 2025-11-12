class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(mon_item) mon_analysis_port;
  virtual router_if vif;
  router_agent_cfg cfg;
  mon_item item;

  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Could not get vif (router_if)")
    mon_analysis_port = new("mon_analysis_port", this);
  endfunction


  // ENTRADAS: cuando DUT acepta (popin && pndng_i_in) publicamos data_out_i_in
  task watch_inputs();
    wait(!vif.reset);
    forever begin
      @(posedge vif.clk);
      if (vif.popin && vif.pndng_in) begin
        item = mon_item::type_id::create("in_item");
        item.ev_kind = mon_item::EV_IN;
        item.mon_id = cfg.term_id;
        item.data = vif.data_in;
        item.time_stamp = $time;
        `uvm_info(get_type_name(),
                  $sformatf("[IN ] data=0x%0h @%0t", item.data, item.time_stamp),
                  UVM_LOW)
        mon_analysis_port.write(item);
      end
    end
  endtask

  // SALIDAS: mientras pndng==1, asertamos pop cada ciclo y publicamos data_out
  task consume_outputs();
    wait(!vif.reset);
    vif.pop <= 1'b0; // asegurar estado inicial
    forever begin
      @(posedge vif.clk);
      if (vif.pndng) begin
        // Pop en este ciclo 
        vif.pop <= 1'b1;

        // Publicar el dato
        item = mon_item::type_id::create("out_item");
        item.ev_kind = mon_item::EV_OUT;
        item.mon_id = cfg.term_id;
        item.data = vif.data_out;
        item.time_stamp = $time;
        `uvm_info(get_type_name(),
                  $sformatf("[OUT] data=0x%0h @%0t", item.data, item.time_stamp),
                  UVM_LOW)
        mon_analysis_port.write(item);

        // Bajar pop en el próximo ciclo
        @(posedge vif.clk);
        vif.pop <= 1'b0;
      end
      else begin
        vif.pop <= 1'b0;
      end
    end
  endtask

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    uvm_config_db#(router_agent_cfg)::get(this, "", "cfg", cfg);
    fork
      watch_inputs();
      consume_outputs();
    join_none
  endtask
endclass
