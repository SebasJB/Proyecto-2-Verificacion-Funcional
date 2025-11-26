class router_agent_cfg extends uvm_object;
  `uvm_object_utils(router_agent_cfg)

  virtual router_if vif;
  int unsigned term_id;          // índice 0..NUM_TERMS-1
  function new(string name = "router_agent_cfg");
    super.new(name); 
  endfunction
endclass

class gen_item_seq extends uvm_sequence #(drv_item);
    typedef enum {GENERAL, SATURATION, COLLISION, INVALID, RESET} scenario_t;
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
    // --- knob para activar/desactivar sin recompilar ---
    static bit DIR_SWEEP_ENABLE = 1'b1;

    // lee plusarg (+NO_DIR_SWEEP) una sola vez
    static bit dir_init_done = 0;
    function void init_dir_knob();
      if (dir_init_done) return;
      if ($test$plusargs("NO_DIR_SWEEP")) DIR_SWEEP_ENABLE = 1'b0;
      dir_init_done = 1;
    endfunction

    // Preambulo dirigido: 8~12 paquetes por agente
    task do_directed_preamble();
      drv_item it;
      int unsigned targets[$];

      // Particiona en 4 destinos por agente (cubre 16 entre todos)
      targets.push_back( seq_id                    % 16 );
      targets.push_back( (seq_id + 4 )            % 16 );
      targets.push_back( (seq_id + 8 )            % 16 );
      targets.push_back( (seq_id + 12)            % 16 );

      // Para cada destino, envía en ambos modos (COL_FIRST/ROW_FIRST)
      foreach (targets[t]) begin
        for (int mm = 0; mm < 2; mm++) begin
          it = drv_item::type_id::create($sformatf("dir_%0d_%0d",targets[t],mm));
          start_item(it);
          // Fijamos campos vía constraint 'with' para que no los cambie la aleatorización
          it.randomize() with {
            test_mode   == drv_item::GENERAL;
            src_id      == seq_id;
            pkt_id      == 16*seq_id + t*2 + mm;     // ayuda a toggle
            dest_addr   == targets[t];
            mode        == drv_item::route_mode_e'(mm);
            error_flag  == 0;
            delay_cycles inside {[0:1]};             // entrega inmediata
          };
          it.data_in = it.build_flit();
          finish_item(it);
        end
      end

      // Un solo paquete con dirección inválida (lo hace el agente 0)
      if (seq_id == 0) begin
        it = drv_item::type_id::create("dir_invalid");
        start_item(it);
        it.randomize() with {
          test_mode   == drv_item::INVALID;
          src_id      == 0;
          pkt_id      == 32'hDE;
          // activa camino inválido en tu build_flit() vía error_flag
          error_flag  == 1;
          delay_cycles inside {[0:1]};
        };
        it.data_in = it.build_flit();
        finish_item(it);
      end

      // Micro-saturación/colisión: agentes 0..3 tiran ráfaga al mismo destino (5)
      if (seq_id < 4) begin
        repeat (4) begin
          it = drv_item::type_id::create($sformatf("dir_sat_%0d", seq_id));
          start_item(it);
          it.randomize() with {
            test_mode   == drv_item::SATURATION;
            src_id      == seq_id;
            dest_addr   == 5;                // mismo terminal de salida
            mode        == drv_item::COL_FIRST;
            error_flag  == 0;
            delay_cycles == 0;               // back-to-back
          };
          it.data_in = it.build_flit();
          finish_item(it);
        end
      end
    endtask

    virtual task body();
        drv_item itm;
        int num_items;
        string scn_str;

        init_dir_knob();              // lee +NO_DIR_SWEEP si viene
        if (DIR_SWEEP_ENABLE) begin
          do_directed_preamble();     // <<— aquí el barrido dirigido
        end

        case (scenario)
           GENERAL   : scn_str = "GENERAL";
           SATURATION: scn_str = "SATURATION";
           COLLISION : scn_str = "COLLISION";
           INVALID   : scn_str = "INVALID";
           RESET     : scn_str = "RESET";
           default   : scn_str = "UNKNOWN";
        endcase

        // Retrieve configuration object
        //if (!uvm_config_db #(router_agent_cfg)::get(null, "seq", "cfg", cfg)) begin
        //    `uvm_fatal("CFG", "Failed to get router_agent_cfg from config DB")
        //end
        case (scenario)
            GENERAL: begin
                `uvm_info(get_type_name(), "Generating GENERAL traffic", UVM_MEDIUM)
                num_items = $urandom_range(10, 20);
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
                num_items = $urandom_range(20, 30);
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
                num_items = $urandom_range(10, 20);
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
                num_items = $urandom_range(20, 30);
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
            RESET: begin
                `uvm_info(get_type_name(), "Generating RESET traffic", UVM_MEDIUM)
                num_items = $urandom_range(20, 30);
                for (int i = 0; i < num_items; i++) begin
                    itm = drv_item::type_id::create("itm");
                    start_item(itm);
                    itm.test_mode = drv_item::RESET;
                    itm.src_id = seq_id;
                    itm.pkt_id = i;
                    itm.randomize();
                    data = itm.build_flit();
                    itm.data_in = data;
                    finish_item(itm);
                end 
            end
            default: begin
                `uvm_error("SEQ", "Unknown scenario selected")
            end
        endcase
               
    endtask : body

endclass : gen_item_seq