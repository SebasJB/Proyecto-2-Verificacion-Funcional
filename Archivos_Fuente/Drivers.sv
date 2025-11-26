import hdr_map_pkg::*;
class driver extends uvm_driver #(drv_item);
    `uvm_component_utils(driver)

    // Virtual interface handle
    virtual router_if#(PCK_SZ) vif; 
    bit [PCK_SZ-1:0] fifo_in [$];
    router_agent_cfg cfg;
    drv_item req;

    covergroup cg_hdr with function sample(
        bit [5:0] dst,
        bit [5:0] src,
        bit       mode
      );
        cp_dst  : coverpoint dst  { bins dst_id[] = {[0:15]}; }
        cp_src  : coverpoint src  { bins src_id[] = {[0:15]}; }
        cp_mode : coverpoint mode { bins col={0}; bins row={1}; }
    endgroup

    // Constructor
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
        cg_hdr = new();
    endfunction : new

    // Build phase to get the virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual router_if #(PCK_SZ))::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not found")
        end
        if(!uvm_config_db#(router_agent_cfg)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal("DRV", "Could not get driver configuration object")
        end
            `uvm_info(get_type_name(), "driver build_phase completed", UVM_HIGH);
    endfunction : build_phase
    
    // Main run phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // Declare req as a handle to the sequence item type
        vif.pndng_in <= 1'b0;
        vif.data_in  <= '0;
        fifo_in.delete();

        fork
            begin : get_items
                forever begin
                    seq_item_port.get_next_item(req);
                    if (req == null) begin
                        `uvm_fatal(get_type_name(), "Received null transaction")
                    end
                    repeat (req.delay_cycles) @(posedge vif.clk);
                    `uvm_info(get_type_name(),$sformatf("Driving Src:%0d Dst:%0d Data:%0h", req.src_id, req.dest_addr, req.data_in), UVM_LOW)
                    fifo_in.push_back(req.data_in);
                    seq_item_port.item_done();
                end
            end

            // 2) Hilo de servicio de interfaz (handshake sincronizado al reloj)
            begin : drive_interface
              forever begin
                @(posedge vif.clk);
                cg_hdr.sample(
                      vif.data_in[DST_MSB:DST_LSB],
                      vif.data_in[SRC_MSB:SRC_LSB],
                      vif.data_in[MODE_BIT]
                    );
                // indicar si hay datos pendientes
                vif.pndng_in <= (fifo_in.size() > 0);

                if (fifo_in.size() > 0) begin
                  // presentar la cabeza de la cola estable mientras esperamos el popin
                  vif.data_in <= fifo_in[0];

                  // si el DUT pide (popin=1), consumimos 1 elemento
                  if (vif.popin) begin
                    // ------- muestreo de cobertura (ya hay vif válido) -------
                    
                    // ----------------------------------------------------------
                    void'(fifo_in.pop_front());
                    // si quedó vacía, bajará pndng_in en el próximo ciclo por la asignación de arriba
                    end
                end
                else begin
                  // sin datos: mantenemos data_in en algo definido
                  vif.data_in <= vif.data_in;
                end
                end
            end
        join

        
    endtask : run_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        $display("Coverage report for base_test: %0f %%", cg_hdr.get_inst_coverage());
    endfunction
endclass //driver