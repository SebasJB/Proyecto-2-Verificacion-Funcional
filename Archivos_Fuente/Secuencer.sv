`include "Secuencer_pkg.sv"
import secuencer_pkg::*;

class router_agent_cfg extends uvm_object;
  `uvm_object_utils(router_agent_cfg)

  virtual router_if vif;
  int unsigned term_id;          // índice 0..NUM_TERMS-1
  function new(string name = "router_agent_cfg");
    super.new(name);
  endfunction
endclass

class gen_item_seq extends uvm_sequence #(drv_item);
    `uvm_object_utils(gen_item_seq)

    // Test scenario selector
    router_agent_cfg cfg;
    scenario_t scenario;
    bit [PCK_SZ-1:0] data;

    // Constructor
    function new(string name = "gen_item_seq");
        super.new(name);
    endfunction : new

    `uvm_declare_p_sequencer(uvm_sequencer #(drv_item))


    // Body: generates items according to scenario
    virtual task body();
        drv_item itm;
        int num_items;
        `uvm_config_db #(router_agent_cfg)::get(this, "seq", "cfg", cfg);
        case (scenario)
            GENERAL: begin
                num_items = $urandom_range(10, 50);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::NORMAL;
                    itm.src_id = cfg.term_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end
            end
            SATURATION: begin
                num_items = $urandom_range(80, 120);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::SATURATION;
                    itm.src_id = cfg.term_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end
            end
            COLLISION: begin
                `uvm_config_db #(router_agent_cfg)::get(this, "seq", "cfg", cfg);
                num_items = $urandom_range(20, 50);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::COLLISION;
                    itm.src_id = cfg.term_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end
            end
            INVALID: begin
                `uvm_config_db #(router_agent_cfg)::get(this, "seq", "cfg", cfg);
                num_items = $urandom_range(30, 60);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::INVALID_DIRECTIONS;
                    itm.src_id = cfg.term_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end
            end
            RESET: begin
                `uvm_config_db #(router_agent_cfg)::get(this, "seq", "cfg", cfg);
                num_items = $urandom_range(20, 40);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::NORMAL;
                    itm.src_id = cfg.term_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                    // Simulate reset event (user should implement actual reset logic)
                    if (i == num_items/2) begin
                        `uvm_info("RESET", "Reset triggered mid-sequence", UVM_MEDIUM)
                        // Insert DUT reset logic here
                    end
                end
            end
            default: begin
                `uvm_error("SEQ", "Unknown scenario selected")
            end
        endcase
    endtask : body

endclass : gen_item_seq