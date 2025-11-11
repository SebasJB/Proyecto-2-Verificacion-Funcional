typedef enum bit { COL_FIRST = 1'b0, ROW_FIRST = 1'b1 } route_mode_e;
typedef enum {GENERAL, SATURATION, COLLISION, INVALID, RESET} scenario_t;
typedef enum logic [1:0] {
        SIDE_TOP    = 2'b00,
        SIDE_LEFT   = 2'b01,
        SIDE_BOTTOM = 2'b10,
        SIDE_RIGHT  = 2'b11
    } side_e;

  parameter int ROWS      = 4;
  parameter int COLUMNS   = 4;
  parameter int PCK_SZ    = 40;
  parameter int NUM_TERMS = ROWS*2 + COLUMNS*2;
  parameter int ADDR_W    = 8;   // campo MSB que compara con ntrfs_id/broadcast

  

  class drv_item extends uvm_sequence_item;

    // --- Campos alatorizables del ítem ---
    rand int unsigned dest_addr;  // terminal donde se ESPERA recibir
    rand int unsigned delay_cycles; // ciclos de retardo antes de enviar
    rand int unsigned error_rate;    // tasa de error (0-100)
    rand route_mode_e mode;         // modo de ruta (fila primero / col primero)
    rand bit          error_flag;      // indica si inyectar error en este paquete
    
    

    // Paquete completo (40 bits)
    bit [PCK_SZ-1:0] data_in;        
    

    // Información del terminal origen
    scenario_t test_mode;      // modo de prueba
    
    // --- Campos para construir el paquete físico ---
    bit [2:0]        dst_row;   // fila destino dentro de la malla
    bit [2:0]        dst_col;   // columna destino
    bit [4:0]        src_id;    // se mapea al campo "src" del paquete
    bit [4:0]        dst_id;    // se mapea al campo "dst" del paquete
    bit [7:0]        pkt_id;    // ID de paquete
    bit [PCK_SZ-1:0] flit = '0;
    

    // Constraint for delay between messages
    constraint c_delay_cycles {
        if (test_mode == NORMAL) {
            // Distribución: mayoría medio, algunos largo, pocos corto
            delay_cycles dist {
                [0:5]   := 15,  // Corto - 15%
                [5:10]  := 70,  // Medio - 70%
                [10:20] := 15   // Largo - 15%
            };
        }
        else if (test_mode == SATURATION) {
            // Favorece retardos cortos
            delay_cycles dist {
                [0:5]   := 70,  // Corto - 70%
                [5:10]  := 15,   // Medio - 15%
                [10:20] := 15    // Largo - 15%
            };
        }
        else { // COLLISION e INVALID_DIRECTIONS
            delay_cycles inside {[0:5]};
        }
    }
    

    // Constraint for error injection
    constraint c_inject_error {
        if (test_mode == NORMAL) {
            solve error_rate before error_flag;
            error_flag dist {0 := (100 - error_rate), 1 := error_rate};
        }
        else if (test_mode == INVALID_DIRECTIONS) {
            solve error_rate before error_flag;
            error_flag dist {0 := (100 - error_rate), 1 := error_rate};
        }
        else { // SATURATION
            solve error_rate before error_flag;
            error_flag dist {0 := (100 - error_rate), 1 := error_rate};
        }
    }

    // Constraint for destination address
    constraint c_dest_addr {
        if (test_mode == NORMAL) {
            dest_addr dist {
                [0:15]    := 90,  // Válidas - 90%
                [16:32]  := 10   // Inválidas - 10%
            };
        }
        else if (test_mode == SATURATION) {
            if (error_flag == 1) {
                // Si se inyecta error, más probabilidad de inválidas
                // Congestión sucia
                dest_addr dist {
                    [0:15]    := 60,  // Válidas - 60%
                    [16:32]  := 40   // Inválidas - 40%
                };
            }
            else // Congestión limpia
            dest_addr dist {
                [0:15]    := 90,  // Válidas - 90%
                [16:32]  := 10   // Inválidas - 10%
            };
        }
        else if (test_mode == COLLISION) {
            // Colisión de destino: todos apuntan al mismo terminal
            // El valor específico debe ser configurado por la secuencia
            dest_addr == 5; // Terminal 5 por defecto, modificable vía constraint_mode
        }
        else if (test_mode == INVALID_DIRECTIONS) {
            // Solo direcciones inválidas
            dest_addr dist {
                [0:15]    := 40,  // Válidas - 40%
                [16:32]   := 60   // Inválidas - 60%
            };
        }
        else { // ROBUSTNESS
            // Mayor probabilidad de direcciones inválidas
            dest_addr dist {
                [0:15]    := 80,  // Válidas - 80%
                [16:32]   := 20   // Inválidas - 20%
            };
        }
    }

    constraint c_error_rate {
        if (test_mode == NORMAL) {
            error_rate inside {[0:10]}; // tasa de error entre 0% y 5%
        }
        else if (test_mode == INVALID_DIRECTIONS) {
            error_rate inside {[30:40]}; // tasa de error entre 5% y 15%
        }
        else { // SATURATION y COLLISION
        error_rate inside {[0:20]}; // tasa de error entre 0% y 20%
    }
    }
    

    // Algunas restricciones básicas
    constraint c_limits {
      0 < dst_row     < ROWS;
      0 < dst_col     < COLUMNS;
    }

    `uvm_object_utils(drv_item)

    function new(string name = "drv_item");
      super.new(name);
    endfunction

    // ------------ Mapeo a bits físicos del paquete ------------

    // Índices de campos dentro del vector (coherentes con el DUT)
    localparam int ID_LSB      = PCK_SZ-38;
    localparam int ID_MSB      = PCK_SZ-30;
    localparam int DST_LSB     = PCK_SZ-29;
    localparam int DST_MSB     = PCK_SZ-24;
    localparam int SRC_LSB     = PCK_SZ-23;
    localparam int SRC_MSB     = PCK_SZ-18;
    localparam int MODE_BIT    = PCK_SZ-17;
    localparam int TRGT_C_LSB  = PCK_SZ-16;
    localparam int TRGT_C_MSB  = PCK_SZ-13;
    localparam int TRGT_R_LSB  = PCK_SZ-12;
    localparam int TRGT_R_MSB  = PCK_SZ-9;
    localparam int NXT_JUMP_LSB = PCK_SZ-8; // campo no usado
    localparam int NXT_JUMP_MSB = PCK_SZ-1; // campo no usado


    // term_id = 0..15
    // Convierte terminal ID a fila/columna extendida
    function void term_to_rc(
        input  logic [4:0] term_id,
        output logic [2:0] trgt_r,   // filas extendidas 0..5
        output logic [2:0] trgt_c
    );
    side_e side;
    logic [1:0] pos;

    side = side_e'(term_id[5:2]); // lado
    pos  = term_id[1:0];          // índice 0..3
    if(error_flag) begin
        // Si se inyecta error, asignar una dirección inválida
        trgt_r = $urandom_range(6,7);
        trgt_c = $urandom_range(6,7);
        return;
    end
    else begin 
        unique case (side)
            SIDE_TOP: begin
                trgt_r = 4'd0;
                trgt_c = pos + 4'd1;        // 1..4
            end
            SIDE_LEFT: begin
                trgt_r = pos + 4'd1;        // 1..4
                trgt_c = 4'd0;
            end
            SIDE_BOTTOM: begin
                trgt_r = ROWS + 4'd1;       // 5
                trgt_c = pos + 4'd1;        // 1..4
            end
            SIDE_RIGHT: begin
                trgt_r = pos + 4'd1;        // 1..4
                trgt_c = COLUMNS + 4'd1;    // 5
            end
        endcase
    end
    endfunction
    // Construye el vector a mandar por data_in
    function bit [PCK_SZ-1:0] build_flit();
      term_to_rc(dest_addr, dst_row, dst_col);
      flit = '0;

      // Fila/columna destino
      flit[TRGT_R_MSB:TRGT_R_LSB] = dst_row;
      flit[TRGT_C_MSB:TRGT_C_LSB] = dst_col;

      // Modo de ruteo
      flit[MODE_BIT] = mode;
      
      // Campo de interfaz destino / broadcast
      flit[DST_MSB:DST_LSB] = dest_addr; // addr lo genera el sequencer
      // Origen e ID
      flit[SRC_MSB:SRC_LSB] = src_id;
      flit[ID_MSB:ID_LSB] = pkt_id;
      return flit;
    endfunction

    // Decodifica un vector que viene del router
    function void from_flit(bit [PCK_SZ-1:0] flit);
      dst_row  = flit[TRGT_R_MSB:TRGT_R_LSB];
      dst_col  = flit[TRGT_C_MSB:TRGT_C_LSB];
      mode     = route_mode_e'(flit[MODE_BIT]);
      src_id   = flit[SRC_MSB:SRC_LSB];
      pkt_id   = flit[ID_MSB:ID_LSB];
      dst_id  = flit[DST_MSB:DST_LSB];
      // src_term_id y dest_addr los setea el agente según su terminal
    endfunction

    function string convert2string();
      return $sformatf(
        "src_term=%0d dst_term=%0d addr=0x%0h dst_r=%0d dst_c=%0d mode=%0b src_id=%0h pkt_id=%0h",
        src_term_id, dest_addr, addr, dst_row, dst_col, mode, src_id, pkt_id
      );
    endfunction

  endclass

  class mon_item extends uvm_sequence_item;
    typedef enum {EV_IN, EV_OUT} ev_t;
    localparam int PKT_W = 40;
  
    ev_t ev_kind;           // EV_IN / EV_OUT
    bit [PKT_W-1:0] data;              // data_out_i_in o data_out
    bit [3:0] mon_id;
    time time_stamp;                // timestamp
  
    `uvm_object_utils_begin(mon_item)
      `uvm_field_enum(ev_t, ev_kind, UVM_ALL_ON)
      `uvm_field_int (data,   UVM_ALL_ON)
      `uvm_field_int (time_stamp,     UVM_ALL_ON)
    `uvm_object_utils_end
  
    function new(string name="mon_item"); super.new(name); endfunction
  endclass



