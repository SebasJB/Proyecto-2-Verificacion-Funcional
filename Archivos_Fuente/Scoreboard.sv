// ----------------------------------------------------------------------------
// Scoreboard: empareja eventos de ENTRADA (EV_IN) y SALIDA (EV_OUT)
// por la clave (row,col,mode,payload). Usa una cola FIFO por clave para
// extraer siempre la entrada MÁS ANTIGUA que coincida con la salida.
// ----------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // TLM: implementación de analysis imp que recibe mon_item desde los monitores
  uvm_analysis_imp #(mon_item, scoreboard) m_analysis_imp;

  // Clave = (Row, Col, Mode, Payload[22:0]) extraídos del paquete [39:0]
  typedef struct packed {
    bit [3:0]  row;      // Bits [31:28]
    bit [3:0]  col;      // Bits [27:24]
    bit        mode;     // Bit  [23]
    bit [22:0] payload;  // Bits [22:0] 
  } key_t;

  // Mapa: clave -> cola FIFO ([$]) de entradas pendientes (mon_item)
  // Arreglo asociativo indexado por key_t
  mon_item exp_q[key_t][$];

  // Métricas de ejecución
  int unsigned n_in, n_out, n_match, n_miss;
  int unsigned pending;


  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Conectar canal de análisis para recibir items de los monitores
    m_analysis_imp = new("m_analysis_imp", this);
    `uvm_info(get_type_name(), "scoreboard build_phase completed", UVM_HIGH);
  endfunction

  // Extrae la clave desde el paquete de 40 bits
  function key_t make_key_from_data(bit [39:0] d);
    key_t k;
    k.row     = d[31:28];
    k.col     = d[27:24];
    k.mode    = d[23];
    k.payload = d[22:0];
    return k;
  endfunction

  // recibe cada mon_item publicado por los monitores
  virtual function void write(mon_item it);
    time lat;
    key_t k = make_key_from_data(it.data);

    if (it.ev_kind == mon_item::EV_IN) begin
      // ENTRADA: apilar en la cola de su clave (FIFO → más antiguo al frente)
      exp_q[k].push_back(it);
      n_in++;
      `uvm_info(get_type_name(),
        $sformatf("STORE IN: row=%0d col=%0d mode=%0d pay=0x%0h (pend=%0d)",
          k.row, k.col, k.mode, k.payload, exp_q[k].size()),
        UVM_LOW)
    end
    else begin // EV_OUT
      n_out++;
      // SALIDA: buscar cola por clave y extraer el más antiguo si existe
      if (exp_q.exists(k) && exp_q[k].size() > 0) begin
        mon_item oldest = exp_q[k].pop_front(); // match FIFO por clave
        n_match++;
        lat = it.time_stamp - oldest.time_stamp;           // latencia simple (ciclos/tiempo sim)
        `uvm_info(get_type_name(),
          $sformatf("PASS OUT: row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem=%0d)",
            k.row, k.col, k.mode, k.payload, lat, exp_q[k].size()),
          UVM_LOW)
        // Liberar memoria cuando la cola queda vacía, activa:
        if (exp_q[k].size()==0) exp_q.delete(k);
      end
      else if (exp_q[k].size() > 0) begin
        // No se encontró entrada equivalente pendiente → salida inesperada
        n_miss++;
        `uvm_error(get_type_name(),
          $sformatf("UNEXPECTED OUT: no hay entrada pendiente para row=%0d col=%0d mode=%0d pay=0x%0h",
            k.row, k.col, k.mode, k.payload))
      end
    end
  endfunction

  // Resumen al finalizar la simulación y listado de entradas pendientes
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    pending = 0;
    //key_t kk; // <-- declarar índice del foreach (clave del asociativo)
  
    foreach (exp_q[kk]) pending += exp_q[kk].size();
  
    `uvm_info(get_type_name(),
      $sformatf("SCB SUMMARY  in=%0d out=%0d  match=%0d  miss=%0d  pending=%0d",
        n_in, n_out, n_match, n_miss, pending),
      UVM_LOW)
  
    if (pending > 0) begin
      foreach (exp_q[kk]) begin
        `uvm_error(get_type_name(),
          $sformatf("PENDING %0d entradas sin salida asociada debido a perdida de datos: row=%0d col=%0d mode=%0d (ej. payload=0x%0h)",
            exp_q[kk].size(), kk.row, kk.col, kk.mode, exp_q[kk][0].data[22:0]))
      end
    end
  endfunction

endclass
