class env extends uvm_env;
  `uvm_component_utils(env)

  router_agent agt[NUM_TERMS];   // 16 agentes: uno por cada terminal del DUT
  scoreboard scb;       // Scoreboard único para todo el tráfico
  router_agent_cfg cfg;
  int n;
  real cov_in_sum;
  real cov_out_sum;
  real cov_in_avg;
  real cov_out_avg;
  real cov_total;

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
      uvm_config_db#(router_agent_cfg)::set(this, $sformatf("agt%0d.drv", i), "cfg", cfg);
      uvm_config_db#(router_agent_cfg)::set(this, $sformatf("agt%0d.mon", i), "cfg", cfg);
    end
    `uvm_info(get_type_name(), "env build_phase completed", UVM_HIGH);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (agt[i]) begin
      // Conecta el analysis_port del monitor al analysis_imp del scoreboard
      agt[i].mon.mon_analysis_port.connect(scb.m_analysis_imp);
    end
  endfunction
  virtual function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  
  real cov_in_sum  = 0.0;
  real cov_out_sum = 0.0;
  n = 0;

  foreach (agt[i]) begin
    if (agt[i].mon != null) begin
      cov_in_sum  += agt[i].mon.cg_entrada.get_coverage();
      cov_out_sum += agt[i].mon.cg_salida.get_coverage();
      n++;
    end
  end

  cov_in_avg  = (n>0) ? cov_in_sum  / n : 0.0;
  cov_out_avg = (n>0) ? cov_out_sum / n : 0.0;
  cov_total   = (cov_in_avg + cov_out_avg) / 2.0;

  `uvm_info("COV_ENV",
    $sformatf("Cobertura GLOBAL ENTRADAS = %0.2f %%  SALIDAS = %0.2f %%  TOTAL = %0.2f %%",
              cov_in_avg, cov_out_avg, cov_total),
    UVM_NONE)
endfunction


endclass
