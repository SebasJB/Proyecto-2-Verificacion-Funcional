class mon_item extends uvm_sequence_item;
  typedef enum {EV_IN, EV_OUT} ev_t;
  localparam int PKT_W = 40;

  rand ev_t            ev_kind;           // EV_IN / EV_OUT
  rand bit [PKT_W-1:0] data;              // data_out_i_in o data_out
  rand time            ts;                // timestamp

  `uvm_object_utils_begin(mon_item)
    `uvm_field_enum(ev_t, ev_kind, UVM_ALL_ON)
    `uvm_field_int (data,   UVM_ALL_ON)
    `uvm_field_int (ts,     UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="mon_item"); super.new(name); endfunction
endclass


class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(mon_item) mon_analysis_port;
  virtual router_if vif;

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
      if (vif.popin && vif.pndng_i_in) begin
        mon_item item = mon_item::type_id::create("in_item");
        item.ev_kind = mon_item::EV_IN;
        item.data    = vif.data_out_i_in;
        item.ts      = $time;
        `uvm_info(get_type_name(),
                  $sformatf("[IN ] data=0x%0h @%0t", item.data, item.ts),
                  UVM_LOW)
        mon_analysis_port.write(item);
      end
    end
  endtask

  // SALIDAS: mientras pndng==1, asertamos pop cada ciclo y publicamos data_out
  task consume_outputs();
    wait(!vif.reset);
    vif.cb.pop <= 1'b0; // asegurar estado inicial
    forever begin
      @(posedge vif.clk);
      if (vif.pndng) begin
        // Pop en este ciclo 
        vif.cb.pop <= 1'b1;

        // Publicar el dato
        mon_item item = mon_item::type_id::create("out_item");
        item.ev_kind = mon_item::EV_OUT;
        item.data    = vif.data_out;
        item.ts      = $time;
        `uvm_info(get_type_name(),
                  $sformatf("[OUT] data=0x%0h @%0t", item.data, item.ts),
                  UVM_LOW)
        mon_analysis_port.write(item);

        // Bajar pop en el próximo ciclo
        @(posedge vif.clk);
        vif.cb.pop <= 1'b0;
      end
      else begin
        vif.cb.pop <= 1'b0;
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
