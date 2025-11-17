class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(mon_item) mon_analysis_port;
  virtual router_if#(PCK_SZ) vif;
  router_agent_cfg cfg;
  mon_item item;

  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual router_if #(PCK_SZ))::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Could not get vif (router_if)")

    if (!uvm_config_db#(router_agent_cfg)::get(this, "", "cfg", cfg))
      `uvm_fatal("MON", "Could not get monitor configuration object")
    mon_analysis_port = new("mon_analysis_port", this);
        `uvm_info(get_type_name(), "mon build_phase completed", UVM_HIGH);
  endfunction


  // ENTRADAS: cuando DUT acepta (popin && pndng_i_in) publicamos data_out_i_in
  task watch_inputs();
    wait(!vif.reset);
    forever begin
      @(posedge vif.clk);
      if (vif.popin) begin
        item = mon_item::type_id::create("in_item");
        item.ev_kind     = mon_item::EV_IN;
        item.mon_id      = cfg.term_id;
        item.data        = vif.data_in;
        item.time_stamp  = $time;
        `uvm_info(get_type_name(),
          $sformatf("[IN ] agt#:%0d Src:%0d Dst:%0d Data:0x%0h @%0t",
            item.mon_id,
            item.data[PCK_SZ-18 : PCK_SZ-23], // SRC_MSB:SRC_LSB
            item.data[PCK_SZ-24 : PCK_SZ-29], // DST_MSB:DST_LSB
            item.data, item.time_stamp),
          UVM_LOW)
        mon_analysis_port.write(item);
      end
    end
  endtask

  // SALIDAS: mientras pndng==1, asertamos pop cada ciclo y publicamos data_out
  // SALIDAS: handshake pop con muestreo 1 ciclo después
  task consume_outputs();
    wait(!vif.reset);
    vif.pop <= 1'b0;
  
    bit sample_next = 0;   // cuando =1, en este ciclo debo capturar y publicar el OUT
  
    forever begin
      @(posedge vif.clk);
  
      // 1) Si el ciclo pasado afirmé pop, HOY capturo y publico el dato nuevo
      if (sample_next) begin
        sample_next = 0;
        item = mon_item::type_id::create("out_item");
        item.ev_kind    = mon_item::EV_OUT;
        item.mon_id     = cfg.term_id;
        item.data       = vif.data_out;     // dato ya avanzó por el pop del ciclo anterior
        item.time_stamp = $time;
        `uvm_info(get_type_name(),
          $sformatf("[OUT] Src:%0d Dst:%0d Data:0x%0h @%0t",
            item.data[PCK_SZ-18:PCK_SZ-23],
            item.data[PCK_SZ-24:PCK_SZ-29],
            item.data, item.time_stamp),
          UVM_LOW)
        #1step; // mantener orden IN→OUT en el SCB
        mon_analysis_port.write(item);
        // Nota: aquí NO tocamos pop; ya se bajó al inicio de este ciclo
      end
  
      // 2) Por defecto, pop en 0 (pulso de 1 ciclo)
      vif.pop <= 1'b0;
  
      // 3) Si hay dato pendiente, genero pulso de pop ESTE ciclo
      if (vif.pndng) begin
        vif.pop <= 1'b1;   // pulso de 1 ciclo
        sample_next = 1;   // y programo capturar el dato en el PRÓXIMO ciclo
      end
    end
  endtask

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    fork
      watch_inputs();
      consume_outputs();
    join_none
  endtask
endclass
