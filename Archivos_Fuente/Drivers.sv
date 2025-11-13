class driver extends uvm_driver #(drv_item);
    `uvm_component_utils(driver)

    // Virtual interface handle
    virtual router_if#(PCK_SZ) vif; 
    bit [PCK_SZ-1:0] fifo_in [$];
    router_agent_cfg cfg;
    drv_item req;

    // Constructor
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
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
    endfunction : build_phase
    
    // Main run phase task
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
    
      // Estado inicial y espera de reset desasertado
      vif.data_in  <= '0;
      vif.pndng_in <= 1'b0;
      @(negedge vif.reset);
    
      forever begin
        seq_item_port.get_next_item(req);
        if (req == null) `uvm_fatal(get_type_name(), "Received null transaction");
    
        // Espera opcional por retardo aleatorio de la transacción
        repeat (req.delay_cycles) @(posedge vif.clk);
    
        `uvm_info(get_type_name(),
          $sformatf("Driving packet - Src:%0d Dest:%0d Data:%0h",
                    req.src_id, req.dest_addr, req.data_in), UVM_LOW)
    
        // Cola local del driver (puede haber varias pendientes)
        fifo_in.push_back(req.data_in);
    
        // === HANDSHAKE TB->DUT ===
        // Mientras haya elementos, mantiene válido y dato estable.
        // El DUT indica consumo con popin=1.
        while (fifo_in.size() != 0) begin
          // Coloca el head de la cola y aserta válido
          vif.data_in  <= fifo_in[0];
          vif.pndng_in <= 1'b1;
    
          @(posedge vif.clk);
    
          if (vif.popin) begin
            // Consumido por el DUT: retirar en el siguiente ciclo
            void'(fifo_in.pop_front());
            if (fifo_in.size() == 0) begin
              // No quedan más → baja válido y limpia dato
              vif.pndng_in <= 1'b0;
              vif.data_in  <= '0;
            end else begin
              // Aún quedan → en el próximo ciclo se presentará el nuevo head
              // (dejamos pndng_in en 1 de forma continua)
            end
          end
          // Si popin==0, se mantiene el dato y pndng_in=1 hasta que el DUT esté listo.
        end
    
        seq_item_port.item_done();
      end
    endtask

endclass //driver