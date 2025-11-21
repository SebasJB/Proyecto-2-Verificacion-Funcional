import hdr_map_pkg::*;

class monitor extends uvm_monitor;
  parameter int ROWS    = 4;
  parameter int COLUMS  = 4;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(mon_item) mon_analysis_port;
  virtual router_if#(PCK_SZ) vif;
  router_agent_cfg cfg;
  mon_item item;

  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
    cg_hdr = new();
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
  task consume_outputs();
    wait(!vif.reset);
    vif.pop <= 1'b0; // asegurar estado inicial
    forever begin
      @(posedge vif.clk);
      if (vif.pndng) begin
        // Handshake de salida (pop activo 1 ciclo)
        vif.pop <= 1'b1;

        // Construir y LOG del OUT (Src/Dst)
        item = mon_item::type_id::create("out_item");
        item.ev_kind     = mon_item::EV_OUT;
        item.mon_id      = cfg.term_id;
        item.data        = vif.data_out;
        item.time_stamp  = $time;

        // ------- muestreo de cobertura (ya hay vif válido) -------
        cg_hdr.sample(
          vif.data_out[DST_MSB     : DST_LSB],
          vif.data_out[MODE_BIT],
          vif.data_out[TRGT_R_MSB  : TRGT_R_LSB],
          vif.data_out[TRGT_C_MSB  : TRGT_C_LSB]
        );
        // ----------------------------------------------------------
        
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

  covergroup cg_hdr with function sample(
    bit [5:0] dst,
    bit       mode,
    bit [3:0] row,
    bit [3:0] col
  );
    cp_dst  : coverpoint dst  { bins id[] = {[0:15]}; }
    cp_mode : coverpoint mode { bins col={0}; bins row={1}; }
    cp_row  : coverpoint row  { bins r[]   = {[0:ROWS-1]}; }
    cp_col  : coverpoint col  { bins c[]   = {[0:COLUMS-1]}; }
    x_dst_mode : cross cp_dst, cp_mode;
    x_rc_mode  : cross cp_row, cp_col, cp_mode;
  endgroup


  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase); 
    fork
      watch_inputs();
      consume_outputs();
    join_none
  endtask
endclass
