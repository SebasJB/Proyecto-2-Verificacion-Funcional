class router_agent_cfg extends uvm_object;
  `uvm_object_utils(router_agent_cfg)

  virtual router_if vif;
  int unsigned term_id;          // índice 0..NUM_TERMS-1
  function new(string name = "router_agent_cfg");
    super.new(name); 
  endfunction
endclass

class gen_item_seq extends uvm_sequence #(drv_item);
    typedef enum {GENERAL, SATURATION, COLLISION, INVALID, SWEEP_ORDERED} scenario_t;
    `uvm_object_utils(gen_item_seq)

    // Test scenario selector
    //router_agent_cfg cfg;
    
    bit [PCK_SZ-1:0] data;
    int unsigned seq_id;
    scenario_t scenario;
    

    // Constructor
    function new(string name = "gen_item_seq");
        super.new(name);
    endfunction : new

    `uvm_declare_p_sequencer(uvm_sequencer #(drv_item));


    // Body: generates items according to scenario
    virtual task body();
        drv_item itm;
        int num_items;
        string scn_str;

        case (scenario)
           GENERAL   : scn_str = "GENERAL";
           SATURATION: scn_str = "SATURATION";
           COLLISION : scn_str = "COLLISION";
           INVALID   : scn_str = "INVALID";
           SWEEP_ORDERED : scn_str = "SWEEP_ORDERED";
           default   : scn_str = "UNKNOWN";
        endcase

        // Retrieve configuration object
        //if (!uvm_config_db #(router_agent_cfg)::get(null, "seq", "cfg", cfg)) begin
        //    `uvm_fatal("CFG", "Failed to get router_agent_cfg from config DB")
        //end
        case (scenario)
            GENERAL: begin
                `uvm_info(get_type_name(), "Generating GENERAL traffic", UVM_MEDIUM)
                num_items = $urandom_range(60, 80);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::GENERAL;
                    itm.src_id = seq_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end 
            end
            SATURATION: begin
                `uvm_info(get_type_name(), "Generating SATURATION traffic", UVM_MEDIUM)
                num_items = $urandom_range(80, 100);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::SATURATION;
                    itm.src_id = seq_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end 
            end
            COLLISION: begin
                `uvm_info(get_type_name(), "Generating COLLISION traffic", UVM_MEDIUM)
                num_items = $urandom_range(50, 60);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::COLLISION;
                    itm.src_id = seq_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end 
            end
            INVALID: begin
                `uvm_info(get_type_name(), "Generating INVALID traffic", UVM_MEDIUM)
                num_items = $urandom_range(50, 60);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::INVALID;
                    itm.src_id = seq_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end 
            end
            SWEEP_ORDERED: begin
                `uvm_info(get_type_name(), "Generating SWEEP_ORDERED traffic", UVM_MEDIUM)
                for (int i = 0; i < NUM_TERMS; i++) begin
                    if (i != seq_id) begin
                        // Evitar enviar a uno mismo
                        itm = drv_item::type_id::create("itm");
                        start_item(itm);
                        itm.test_mode = drv_item::SWEEP_ORDERED;
                        itm.randomize();
                        itm.src_id = seq_id;
                        itm.dest_addr = i;
                        itm.pkt_id = i;
                        data = itm.build_flit();
                        itm.data_in = data;
                        finish_item(itm);
                    end
                    else begin
                        `uvm_info(get_type_name(), $sformatf("Skipping sending to self for src_id=%0d", seq_id), UVM_LOW)
                        continue;
                    end
                end 
            end 
            default: begin
                `uvm_error("SEQ", "Unknown scenario selected")
            end
        endcase
               
    endtask : body

endclass : gen_item_seq