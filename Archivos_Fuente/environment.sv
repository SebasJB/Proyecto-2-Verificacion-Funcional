class env extends uvm_env;
  `uvm_component_utils(env)

  router_agent agents[NUM_TERMS];   // 16 agentes: uno por cada terminal del DUT
  scoreboard scb0;       // Scoreboard único para todo el tráfico
  router_agent_cfg cfg;

  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb0 = scoreboard::type_id::create("scb0", this); // Instancia scoreboard
    foreach (agent) begin
      // Crea agt[i] con nombre indexado (útil para logs/rutas de config_db)
      agents[i] = agent::type_id::create($sformatf("agt%0d", i), this);
      cfg = new();
      cfg.term_id = i;
      `uvm_config_db#(router_agent_cfg)::set(this, $sformatf("Agente_%0d", i), "cfg", cfg);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (agents[i]) begin
      // Conecta el analysis_port del monitor al analysis_imp del scoreboard
      agents[i].mon.mon_analysis_port.connect(scb0.m_analysis_imp);
    end
  endfunction
endclass
