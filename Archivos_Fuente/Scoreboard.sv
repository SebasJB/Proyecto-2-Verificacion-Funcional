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
  mon_item exp_q[key_t][$];   // IN pendientes
  mon_item out_q[key_t][$];   // OUT huérfanos (nuevo)

  // Métricas de ejecución
  int unsigned n_in, n_out, n_match, n_miss;
  int unsigned pending_in, pending_out;


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

  // --- helpers para validación de destino ---
localparam int DST_MSB = 16; // campo destino en el flit [16:11]
localparam int DST_LSB = 11;

function bit is_valid_term(input bit [3:0] r, input bit [3:0] c);
  return ( (r==0 && (c>=1 && c<=4))  ||  // TOP: 01..04
           (c==0 && (r>=1 && r<=4))  ||  // LEFT: 10,20,30,40
           (r==5 && (c>=1 && c<=4))  ||  // BOTTOM: 51..54
           (c==5 && (r>=1 && r<=4)) );   // RIGHT: 15,25,35,45
endfunction


  // recibe cada mon_item publicado por los monitores
  virtual function void write(mon_item it);
    time lat;
    key_t k = make_key_from_data(it.data);

    if (it.ev_kind == mon_item::EV_IN) begin
      n_in++;
      // ¿ya había OUT adelantado?
      if (out_q.exists(k) && out_q[k].size()>0) begin
        mon_item early_out = out_q[k].pop_front();
        n_match++;
        lat = early_out.time_stamp - it.time_stamp; // puede ser 0 o 1 ciclo
        `uvm_info(get_type_name(),
          $sformatf("PASS OUT (late IN): row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem_out=%0d)",
            k.row, k.col, k.mode, k.payload, lat, out_q[k].size()),
          UVM_LOW)
        if (out_q[k].size()==0) out_q.delete(k);
      end
      else begin
        exp_q[k].push_back(it);
        `uvm_info(get_type_name(),
          $sformatf("STORE IN: row=%0d col=%0d mode=%0d pay=0x%0h (pend_in=%0d)",
            k.row, k.col, k.mode, k.payload, exp_q[k].size()),
          UVM_MEDIUM)
      end
    end
    else begin // EV_OUT
      n_out++;
      // ¿hay IN pendiente?
      if (exp_q.exists(k) && exp_q[k].size()>0) begin
        mon_item oldest = exp_q[k].pop_front();
        n_match++;
        lat = it.time_stamp - oldest.time_stamp;
        `uvm_info(get_type_name(),
          $sformatf("PASS OUT: row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem_in=%0d)",
            k.row, k.col, k.mode, k.payload, lat, exp_q[k].size()),
          UVM_LOW)
        if (exp_q[k].size()==0) exp_q.delete(k);
      end
      else begin
        // Guarda OUT adelantado y NO dispares error
        out_q[k].push_back(it);
        `uvm_info(get_type_name(),
          $sformatf("STORE OUT EARLY: row=%0d col=%0d mode=%0d pay=0x%0h (pend_out=%0d)",
            k.row, k.col, k.mode, k.payload, out_q[k].size()),
          UVM_MEDIUM)
      end
    end
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    pending_in=0;
    pending_out=0;
    foreach (exp_q[kk])  pending_in  += exp_q[kk].size();
    foreach (out_q[kk])  pending_out += out_q[kk].size();
    `uvm_info(get_type_name(),
      $sformatf("SCB SUMMARY in=%0d out=%0d match=%0d miss=%0d pending_in=%0d pending_out=%0d",
        n_in, n_out, n_match, n_miss, pending_in, pending_out),
      UVM_LOW)
    if (pending_in>0) foreach (exp_q[kk])
      `uvm_error(get_type_name(),
        $sformatf("PENDING IN %0d sin OUT: row=%0d col=%0d mode=%0d (ej. pay=0x%0h)",
          exp_q[kk].size(), kk.row, kk.col, kk.mode, exp_q[kk][0].data[22:0]))
    if (pending_out>0) foreach (out_q[kk])
      `uvm_error(get_type_name(),
        $sformatf("PENDING OUT %0d sin IN: row=%0d col=%0d mode=%0d (ej. pay=0x%0h)",
          out_q[kk].size(), kk.row, kk.col, kk.mode, out_q[kk][0].data[22:0]))
  endfunction

endclass
