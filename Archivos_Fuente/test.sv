// base_test.sv — ejecuta TODOS los escenarios, 16 secuencias en paralelo por escenario
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  virtual router_if #(PCK_SZ) vif;
  env e;
  gen_item_seq seq [NUM_TERMS]; // un secuenciador por agente
  gen_item_seq::scenario_t scenarios[$]; // cola de escenarios a ejecutar

  function new(string name="base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_top.set_report_verbosity_level_hier(UVM_LOW);
    if (!uvm_config_db#(virtual router_if #(PCK_SZ))::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for base_test")
    end
    `uvm_info(get_type_name(), "Test build_phase started", UVM_HIGH);
    e = env::type_id::create("env", this); // 16 agents + scoreboard
    for (int i = 0; i < NUM_TERMS; i++) begin
        seq[i] = gen_item_seq::type_id::create($sformatf("seq%0d", i), this);
        seq[i].randomize();
    end
    `uvm_info(get_type_name(), "Test build_phase completed", UVM_HIGH);
  endfunction

  virtual task run_phase(uvm_phase phase);;
  
    //scenarios[$] = {GENERAL, SATURATION, COLLISION, INVALID, RESET};
    scenarios.push_back(gen_item_seq::GENERAL);
    scenarios.push_back(gen_item_seq::SATURATION);
    scenarios.push_back(gen_item_seq::COLLISION);
    scenarios.push_back(gen_item_seq::INVALID);
    scenarios.push_back(gen_item_seq::RESET);

// debug opcional
`uvm_info(get_type_name(), $sformatf("scenarios.size=%0d", scenarios.size()), UVM_HIGH)

  
    foreach (scenarios[s]) begin
      `uvm_info(get_type_name(),$sformatf("=== RUN scenario: %s ===", scenarios[s].name()), UVM_HIGH)
      apply_reset();  
      for (int i = 0; i < NUM_TERMS; i++) begin
        automatic int idx = i;
        automatic gen_item_seq::scenario_t sc = scenarios[s];
        fork
          begin
            phase.raise_objection(this);
            seq[idx].scenario = sc;
            seq[idx].seq_id = idx;
            seq[idx].start(e.agt[idx].sequencer);
            phase.drop_objection(this);
          end
        join_none
      end
  
      `uvm_info(get_type_name(), "Waiting for scenario completion...", UVM_HIGH);
      wait fork;
      `uvm_info(get_type_name(), $sformatf("=== END scenario: %s ===", scenarios[s].name()), UVM_HIGH)                         
      repeat (500) @(posedge vif.clk); // pausa de drenaje
    end
  endtask

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

  function void apply_reset();
    // Aplicar reset global al DUT
    vif.reset <= 1;
    repeat (5) @(posedge vif.clk);
    vif.reset <= 0;
    repeat (10) @(posedge vif.clk);
    `uvm_info(get_type_name(), "Global reset applied", UVM_HIGH);
  endfunction
endclass
