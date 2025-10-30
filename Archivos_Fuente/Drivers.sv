interface router_if #(pckg_sz = 40);
    // Define signals for the router interface
    logic clk;
    logic reset;
    logic [pckg_sz-1:0] data_out;
    logic [pckg_sz-1:0] data_out_i_in;
    logic pop;
    logic popin;
    logic pndng;
    logic pndng_i_in;

    // Clocking block for synchronous operations
    clocking cb @(posedge clk);
        input data_out, popin, pndng;
        output data_out_i_in, pop, pndng_i_in;
    endclocking
endinterface : router_if

 class driver extends uvm_driver ;
    `uvm_component_utils(driver)

    // Virtual interface handle
    virtual router_if vif;
    bit [pck_sz-1:0] fifo_in [$];
    bit [pck_sz-1:0] data_out_i_in;
    bit pndng_i_in;
    bit popin;

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

    // Main run phase to drive transactions
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Wait for a transaction from the sequencer
            seq_item_port.get_next_item(req);
            if (req == null) begin
                `uvm_fatal(get_type_name(), "Received null transaction")
            end
            else begin
                `uvm_info(get_type_name(), $sformatf("Driving transaction with data: %0h", req.data), UVM_LOW)
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
            end
            seq_item_port.item_done();
        end
    endtask : run_phase
 endclass //driver extends superClass