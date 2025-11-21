// ================= fifo_sva_cov.sv =================
module fifo_sva_cov #(
  parameter int DEPTH         = 4,
  parameter bit ACTIVE_HIGH_RST = 1
)(
  input  logic               clk,
  input  logic               reset,        // activo en alto
  input  logic               push,         // escritura (wr_en)
  input  logic               pop,          // lectura  (rd_en)
  input  logic               full,
  input  logic               empty,

  // Opcionales: si el FIFO los expone, los usamos para comprobaciones más fuertes
  input  logic [$clog2(DEPTH):0] level,    // ocupación actual (0..DEPTH)
  input  logic [$clog2(DEPTH)-1:0] wr_ptr, // puntero escritura
  input  logic [$clog2(DEPTH)-1:0] rd_ptr  // puntero lectura
);

  // ----------------- ASERCIONES -----------------
  // helper reset
  wire rst = ACTIVE_HIGH_RST ? reset : ~reset;

  // Nunca empujar cuando full
  assert property (@(posedge clk) disable iff (rst) push |-> !full)
    else $error("FIFO: push con FULL=1");

  // Nunca sacar cuando empty
  assert property (@(posedge clk) disable iff (rst) pop |-> !empty)
    else $error("FIFO: pop con EMPTY=1");

  // FULL y EMPTY no pueden ser 1 a la vez
  assert property (@(posedge clk) disable iff (rst) !(full && empty))
    else $error("FIFO: full y empty simultáneos");

  // Si tenemos level, fortalecemos aserciones:
  if (^level !== 1'bx) begin : USE_LEVEL
    // full <-> level==DEPTH
    assert property (@(posedge clk) disable iff (rst) full  |-> (level==DEPTH))
      else $error("FIFO: full sin level==DEPTH");

    assert property (@(posedge clk) disable iff (rst) (level==DEPTH) |-> full)
      else $error("FIFO: level==DEPTH sin full");

    // empty <-> level==0
    assert property (@(posedge clk) disable iff (rst) empty |-> (level==0))
      else $error("FIFO: empty sin level==0");

    /*
    assert property (@(posedge clk) disable iff (rst) (level==0) |-> empty)
      else $error("FIFO: level==0 sin empty");

    // No cambiar level por fuera de {-1,0,+1} por ciclo
    assert property (@(posedge clk) disable iff (rst)
      $changed(level) |-> ((level == $past(level)+1) ||
                           (level == $past(level)-1)))
      else $error("FIFO: salto inválido en level");*/ 
  end
  /*
  // Si tenemos punteros, verificamos que sólo avancen cuando toca
  if ((^wr_ptr !== 1'bx) && (^rd_ptr !== 1'bx)) begin : USE_PTRS
    // wr_ptr sólo cambia cuando push válido
    assert property (@(posedge clk) disable iff (rst)
                    $changed(wr_ptr) |-> (push && !full))
      else $error("FIFO: wr_ptr cambió sin push válido");

    // rd_ptr sólo cambia cuando pop válido
    assert property (@(posedge clk) disable iff (rst)
                    $changed(rd_ptr) |-> (pop && !empty))
      else $error("FIFO: rd_ptr cambió sin pop válido");
  end */

  // ----------------- COBERTURA -----------------
  
  covergroup cg_fifo_t;

    // Ocupación
    cp_level : coverpoint level iff (^level !== 1'bx) {
      bins all[] = {[0:DEPTH]};
      bins empty_b   = {0};
      bins near_full = {DEPTH-1};
      bins full_b    = {DEPTH};
    }

    // Flags / eventos
    cp_full  : coverpoint full;
    cp_empty : coverpoint empty;
    ev_push  : coverpoint push  { bins pulse = (1=>0); }
    ev_pop   : coverpoint pop   { bins pulse = (1=>0); }

    // Transiciones de borde (si hay level)
    tr_empty_to_1 : coverpoint (level==0 && $rose(push)) iff (^level !== 1'bx);
    tr_1_to_empty : coverpoint (level==1 && $rose(pop))  iff (^level !== 1'bx);
    tr_df_to_full : coverpoint (level==DEPTH-1 && $rose(push)) iff (^level !== 1'bx);
    tr_full_to_df : coverpoint (level==DEPTH   && $rose(pop))  iff (^level !== 1'bx);

    // Cruces de coherencia
    x_flags_level : cross cp_full, cp_empty, cp_level iff (^level !== 1'bx);

  endgroup

  // Instancia explícita del covergroup principal
  cg_fifo_t cg_fifo;

  // Métricas de burst (longitud de rachas push/pop)
  int burst_push, burst_pop;
  covergroup cg_bursts_t;
    cp_push_burst : coverpoint burst_push { bins len[] = {[1:DEPTH+2]}; }
    cp_pop_burst  : coverpoint burst_pop  { bins len[] = {[1:DEPTH+2]}; }
  endgroup

  // Instancia explícita del covergroup de burst  
  cg_bursts_t cg_bursts;

  // Inicializar covergroups
  initial begin
    cg_fifo = new();
    cg_bursts = new();
  end

  always @(posedge clk) if (!rst) begin
    burst_push <= push ? burst_push+1 : 0;
    burst_pop  <= pop  ? burst_pop +1 : 0;

    // Muestreo manual del covergroup principal
    cg_fifo.sample();

    // sample al final de la racha
    if (!push && $past(push)) cg_bursts.sample();
    if (!pop  && $past(pop )) cg_bursts.sample();
  end

endmodule