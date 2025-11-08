class env extends uvm_env;
  `uvm_component_utils(env)

  agent      agt [16];   // 16 agentes: uno por cada terminal del DUT
  scoreboard scb0;       // Scoreboard único para todo el tráfico

  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb0 = scoreboard::type_id::create("scb0", this); // Instancia scoreboard
    foreach (agt[i]) begin
      // Crea agt[i] con nombre indexado (útil para logs/rutas de config_db)
      agt[i] = agent::type_id::create($sformatf("agt%0d", i), this);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (agt[i]) begin
      // Conecta el analysis_port del monitor al analysis_imp del scoreboard
      agt[i].m0.mon_analysis_port.connect(scb0.m_analysis_imp);
    end
  endfunction
endclass
