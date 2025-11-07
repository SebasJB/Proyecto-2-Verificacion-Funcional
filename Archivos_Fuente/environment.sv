// env.sv
class env extends uvm_env;
  `uvm_component_utils(env)

  localparam int N_TERMS = 16;

  // 16 agentes (uno por terminal) y un scoreboard
  agent      agt [N_TERMS];
  scoreboard scb0;

  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Crear scoreboard y agentes
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    scb0 = scoreboard::type_id::create("scb0", this);

    foreach (agt[i]) begin
      agt[i] = agent::type_id::create($sformatf("agt%0d", i), this);
      // opcional: agt[i].is_active = UVM_ACTIVE; // si decides usarlo
    end
  endfunction

  // Conectar todos los monitores al único scoreboard
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (agt[i]) begin
      // El agente NO reexporta el analysis_port, así que conectamos
      // directamente el puerto del monitor al imp del scoreboard:
      agt[i].m0.mon_analysis_port.connect(scb0.m_analysis_imp);
    end
  endfunction

  // Helper para que el test arranque secuencias fácilmente
  function uvm_sequencer#(item) get_sequencer(int i);
    if (i < 0 || i >= N_TERMS) return null;
    return agt[i].s0;
  endfunction
endclass
