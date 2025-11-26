class monitor extends uvm_monitor;
  parameter int ROWS    = 4;
  parameter int COLUMS  = 4;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(mon_item) mon_analysis_port;
  virtual router_if#(PCK_SZ) vif;
  router_agent_cfg cfg;
  mon_item item;

  covergroup cg_entrada with function sample(
        bit [5:0] src,
        bit       mode
      );
        cp_src  : coverpoint src  { bins src_id[] = {[0:14]}; }
        cp_mode : coverpoint mode { bins col={0}; bins row={1}; }
  endgroup

  covergroup cg_salida with function sample(
        bit [5:0] dst,
        bit       mode
      );
        cp_dst  : coverpoint dst  { bins dst_id[] = {[0:14]}; }
        cp_mode : coverpoint mode { bins col={0}; bins row={1}; }
  endgroup

  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
    cg_entrada = new();
    cg_salida = new();
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
      cg_entrada.sample(
        vif.data_in[SRC_MSB:SRC_LSB],
        vif.data_in[MODE_BIT]
      );
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
  task consume_outputs();
    wait(!vif.reset);
    vif.pop <= 1'b0; // asegurar estado inicial
    forever begin
      @(posedge vif.clk);
      cg_salida.sample(
        vif.data_out[DST_MSB:DST_LSB],
        vif.data_out[MODE_BIT]
      );
      if (vif.pndng) begin
        // Handshake de salida (pop activo 1 ciclo)
        vif.pop <= 1'b1;

        // Construir y LOG del OUT (Src/Dst)
        item = mon_item::type_id::create("out_item");
        item.ev_kind     = mon_item::EV_OUT;
        item.mon_id      = cfg.term_id;
        item.data        = vif.data_out;
        item.time_stamp  = $time;
        `uvm_info(get_type_name(),
          $sformatf("[OUT] Src:%0d Dst:%0d Data:0x%0h @%0t",
            item.data[PCK_SZ-18 : PCK_SZ-23], // SRC
            item.data[PCK_SZ-24 : PCK_SZ-29], // DST
            item.data, item.time_stamp),
          UVM_LOW)
        #1step;  // REQ: garantiza que el OUT siempre llegue al SCB después del IN
        mon_analysis_port.write(item);

        // Bajar pop en el próximo ciclo (mantener protocolo)
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
    fork
      watch_inputs();
      consume_outputs();
    join_none
  endtask
endclass
