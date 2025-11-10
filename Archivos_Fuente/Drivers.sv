interface router_if #(pckg_sz = 40)(input logic clk, reset);
    // Define signals for the router interface
    
    // DUT → TB (salida de paquetes)
    logic [pckg_sz-1:0] data_in;    // mapea a data_out_i_in[t]
    logic pndng_in;                 // mapea a pndng_i_in[t]
    logic popin;                    // mapea a popin[t] (ack de consumo de entrada)

    // TB → DUT  (salida de paquetes)
    logic [pckg_sz-1:0] data_out;  // mapea a data_out[t]
    logic pop;                     // mapea a pop[t] (ack de consumo de salida)
    logic pndng;                   // mapea a pndng[t]

    // Clocking block for synchronous operations
    clocking cb @(posedge clk);
        input data_out, popin, pndng;
        output data_in, pop, pndng_in;
    endclocking
endinterface : router_if

class driver extends uvm_driver;
    `uvm_component_utils(driver)

    // Virtual interface handle
    virtual router_if vif;
    bit [pck_sz-1:0] fifo_in [$];
    bit [pck_sz-1:0] data_out_i_in;
    bit pndng_i_in;
    bit popin;

    // Declare req as a handle to the sequence item type
    drv_item req;

    // Constructor
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // Build phase to get the virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface not found")
        end
    endfunction : build_phase
    
    // Main run phase task
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        if(!uvm_config_db#(router_agent_cfg)::get(this, "drv", "cfg", cfg)) begin
            `uvm_fatal("DRV", "Could not get driver configuration object")
        end
        forever begin
            seq_item_port.get_next_item(req);
            if (req == null) begin
                `uvm_fatal(get_type_name(), "Received null transaction")
            end
            repeat (req.delay_cycles) @(posedge vif.clk);
            
            
            `uvm_info(get_type_name(), $sformatf("Driving packet - Src: %0d, Dest: %0d, Data: %0h", 
                      req.src_id, req.dest_addr, req.data_in), UVM_LOW)
            
            fifo_in.push_back(req.data_in);
            
            if (fifo_in.size() > 0) begin
                vif.cb.pndng_i_in <= 1'b1; // Indicate pending data
            end
            
            if (vif.cb.popin == 1'b1) begin
                vif.cb.data_out_i_in <= fifo_in.pop_front();
                if (fifo_in.size() == 0) begin
                    vif.cb.pndng_i_in <= 1'b0; // Clear pending if popped
                end
            end
            
            seq_item_port.item_done();
        end
    endtask : run_phase
endclass //driver