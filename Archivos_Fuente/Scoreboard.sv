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

  // CSV
  integer csv_fd; // handle del archivo


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Conectar canal de análisis para recibir items de los monitores
    m_analysis_imp = new("m_analysis_imp", this);
    `uvm_info(get_type_name(), "scoreboard build_phase completed", UVM_HIGH);
    // === CSV ===
    csv_fd = $fopen("router_report.csv", "w");
    if (csv_fd == 0)
      `uvm_fatal("SCB/CSV", "No se pudo abrir router_report.csv");
    $fdisplay(csv_fd,
      "status,tx_time,tx_term,tx_data,rx_time,rx_term,rx_data,latency,row,col,mode,payload,src_id,dst_id");

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
      // ENTRADA: apilar en la cola de su clave (FIFO → más antiguo al frente)
      exp_q[k].push_back(it);
      n_in++;
      `uvm_info(get_type_name(),
        $sformatf("STORE IN: row=%0d col=%0d mode=%0d pay=0x%0h (pend=%0d)",
          k.row, k.col, k.mode, k.payload, exp_q[k].size()),
        UVM_MEDIUM)
    end
    else begin // EV_OUT
      n_out++;
      if (exp_q.exists(k) && exp_q[k].size() > 0) begin
        mon_item oldest = exp_q[k].pop_front();
        n_match++;
        lat = it.time_stamp - oldest.time_stamp;
    
        // Logs informativos que ya tenías
        if (!is_valid_term(k.row, k.col)) begin
          `uvm_info(get_type_name(),
            $sformatf("PASS OUT, destino del dato no está mapeado en terminales del ROUTER: row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem=%0d)",
              k.row, k.col, k.mode, k.payload, lat, exp_q[k].size()), UVM_LOW)
        end
        else begin
          bit [4:0] dst_id = it.data[DST_MSB:DST_LSB];
          if (dst_id != it.mon_id) begin
            `uvm_info(get_type_name(),
              $sformatf("PASS OUT, destino del dato no corresponde a terminal de salida: row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem=%0d)",
                k.row, k.col, k.mode, k.payload, lat, exp_q[k].size()), UVM_LOW)
          end
          else begin
            `uvm_info(get_type_name(),
              $sformatf("PASS OUT: row=%0d col=%0d mode=%0d pay=0x%0h (lat=%0t, rem=%0d)",
                k.row, k.col, k.mode, k.payload, lat, exp_q[k].size()), UVM_LOW)
          end
        end
    
        // === CSV: fila OK (match) ===
        $fdisplay(csv_fd, "OK,%0t,%0d,0x%0h,%0t,%0d,0x%0h,%0t,%0d,%0d,%0d,0x%0h,%0d,%0d",
                  oldest.time_stamp, oldest.mon_id, oldest.data,
                  it.time_stamp,     it.mon_id,     it.data,
                  lat, k.row, k.col, k.mode, k.payload,
                  it.data[PCK_SZ-18:PCK_SZ-23],  // src_id (del OUT)
                  it.data[DST_MSB:DST_LSB]);     // dst_id (del OUT)
    
        if (exp_q[k].size()==0) exp_q.delete(k);
      end
      else begin
        // UNEXPECTED OUT
        n_miss++;
        `uvm_error(get_type_name(),
          $sformatf("UNEXPECTED OUT: no hay entrada pendiente para row=%0d col=%0d mode=%0d pay=0x%0h",
            k.row, k.col, k.mode, k.payload))
    
        // === CSV: fila UNEXPECTED_OUT (sin tx_*) ===
        $fdisplay(csv_fd, "UNEXPECTED_OUT,-,-,-,%0t,%0d,0x%0h,-,%0d,%0d,%0d,0x%0h,%0d,%0d",
                  it.time_stamp, it.mon_id, it.data,
                  k.row, k.col, k.mode, k.payload,
                  it.data[PCK_SZ-18:PCK_SZ-23],
                  it.data[DST_MSB:DST_LSB]);
      end
    end
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    pending = 0;
    foreach (exp_q[kk]) pending += exp_q[kk].size();
  
    `uvm_info(get_type_name(),
      $sformatf("SCB SUMMARY  in=%0d out=%0d  match=%0d  miss=%0d  pending=%0d",
        n_in, n_out, n_match, n_miss, pending),
      UVM_LOW)
  
    // === CSV: entradas pendientes (NO_OUTPUT) ===
    if (pending > 0) begin
      foreach (exp_q[kk]) begin
        foreach (exp_q[kk][ii]) begin
          mon_item tin = exp_q[kk][ii];
          `uvm_error(get_type_name(),
            $sformatf("PENDING entrada sin salida: row=%0d col=%0d mode=%0d (ej. payload=0x%0h)",
              kk.row, kk.col, kk.mode, tin.data[22:0]))
  
          $fdisplay(csv_fd, "NO_OUTPUT,%0t,%0d,0x%0h,-,-,-,-,%0d,%0d,%0d,0x%0h,%0d,%0d",
                    tin.time_stamp, tin.mon_id, tin.data,
                    kk.row, kk.col, kk.mode, kk.payload,
                    tin.data[PCK_SZ-18:PCK_SZ-23],   // src_id (del IN)
                    tin.data[DST_MSB:DST_LSB]);      // dst_id (del IN)
        end
      end
    end
  
    if (csv_fd) begin
      $fclose(csv_fd);
      `uvm_info(get_type_name(),"CSV generado: router_report.csv", UVM_LOW)
    end
  endfunction


endclass
