// base_test.sv — ejecuta TODOS los escenarios, 16 secuencias en paralelo por escenario
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  env e;
  gen_item_seq seq;
  gen_item_seq::scenario_t scenarios[$]; // cola de escenarios a ejecutar

  function new(string name="base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("env", this); // 16 agents + scoreboard
    for (int i = 0; i < NUM_TERMS; i++ ) begin
      seq = gen_item_seq::type_id::create($sformatf("seq_%0d", i), this);
      seq.randomize();
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Cola de escenarios a ejecutar en serie
    scenarios[$] = {
      GENERAL,
      SATURATION,
      COLLISION,
      INVALID,
      RESET
    };

    //int s; 
    foreach (scenarios[s]) begin
      `uvm_info(get_type_name(),
        $sformatf("=== RUN scenario: %s ===", scenarios[s].name()), UVM_MEDIUM)

      // Para este escenario, lanza 16 secuencias EN PARALELO (una por agente)
      for (int i = 0; i < 16; i++) begin
        automatic int idx = i;
        automatic gen_item_seq::scenario_t sc = scenarios[s];

        // Cada iteración lanza su propio hilo
        fork
          begin
            seq.scenario = sc;
            seq.start(e.agt[idx].seq); // bloquea este hilo hasta que la secuencia termine
          end
        join_none
      end

      // Espera a que terminen los 16 hilos del escenario actual
      wait fork;

      // Pequeña pausa entre escenarios
      #(500);
    end

    phase.drop_objection(this);
  endtask
endclass
