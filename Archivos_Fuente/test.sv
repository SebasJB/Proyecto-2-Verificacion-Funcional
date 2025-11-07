// base_test.sv
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  env e;

  function new(string name="base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Lanzar una secuencia por cada terminal (ejemplo: GENERAL)
    for (int i = 0; i < 16; i++) begin
      automatic int idx = i;
      gen_item_seq seq = gen_item_seq::type_id::create($sformatf("seq%0d", idx));
      seq.scenario = gen_item_seq::GENERAL;
      // Arrancamos en paralelo, cada una sobre su sequencer
      fork
        seq.start(e.get_sequencer(idx));
      join_none
    end

    // Espera simple (ajustar a tu duración de prueba)
    // Puedes reemplazar por un mecanismo de fin basado en contadores/eventos
    #(100_000);

    phase.drop_objection(this);
  endtask
endclass
