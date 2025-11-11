class env extends uvm_env;
  `uvm_component_utils(env)

  router_agent agt[NUM_TERMS];   // 16 agentes: uno por cada terminal del DUT
  scoreboard scb;       // Scoreboard único para todo el tráfico
  router_agent_cfg cfg;

  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb = scoreboard::type_id::create("scb", this); // Instancia scoreboard
    foreach (agt[i]) begin
      // Crea agt[i] con nombre indexado (útil para logs/rutas de config_db)
      agt[i] = router_agent::type_id::create($sformatf("agt%0d", i), this);
      cfg = new();
      cfg.term_id = i;
      uvm_config_db#(router_agent_cfg)::set(this, $sformatf("agt%0d", i), "cfg", cfg);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (agt[i]) begin
      // Conecta el analysis_port del monitor al analysis_imp del scoreboard
      agt[i].mon.mon_analysis_port.connect(scb0.m_analysis_imp);
    end
  endfunction
endclass
