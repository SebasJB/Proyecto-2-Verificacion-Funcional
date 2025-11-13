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
    
      // Estado inicial + esperar reset desasertado
      vif.data_in  <= '0;
      vif.pndng_in <= 1'b0;
      @(negedge vif.reset);
    
      fork
        // Hilo A: recibir ítems del sequencer
        forever begin
          seq_item_port.get_next_item(req);
          if (req == null) `uvm_fatal(get_type_name(),"Received null transaction");
          repeat (req.delay_cycles) @(posedge vif.clk);
    
          `uvm_info(get_type_name(),
            $sformatf("ENQUEUE  src=%0d  dest=%0d  data=%0h",
                      req.src_id, req.dest_addr, req.data_in), UVM_LOW)
    
          fifo_in.push_back(req.data_in);
          seq_item_port.item_done();
        end
    
        // Hilo B: emitir hacia el DUT (valid = pndng_in, ready = popin)
        forever begin
          @(posedge vif.clk);
    
          if (fifo_in.size()!=0) begin
            // Mientras haya elementos, mantén válido y dato estable
            vif.pndng_in <= 1'b1;
            vif.data_in  <= fifo_in[0];
    
            if (vif.popin) begin
              // El DUT consumió: retira en el siguiente flanco
              @(posedge vif.clk);
              void'(fifo_in.pop_front());
              if (fifo_in.size()==0) begin
                vif.pndng_in <= 1'b0;
                vif.data_in  <= '0;
              end
            end
          end else begin
            vif.pndng_in <= 1'b0;
            vif.data_in  <= '0;
          end
        end
      join_none
    endtask

endclass //driver