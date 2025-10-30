class item extends uvm_sequence_item #(pck_sz);
    `uvm_object_utils(item)

    // Data fields
    rand bit [pck_sz-1:0] data_in;
    bit [pck_sz-1:0] data_out;
    
    // Test configuration variables
    rand int delay_cycles;            // Ciclos de retardo entre envíos
    rand bit error;            // Flag para inyectar error
    rand bit [7:0] dest_addr;         // Dirección de destino
    
    // Test mode control (set by test/sequence)
    typedef enum {NORMAL, SATURATION, COLLISION, INVALID_DIRECTIONS} test_mode_t;
    test_mode_t test_mode = NORMAL;
    
    // Error injection rate control
    int error_rate = 8; // Default 8% (0-100)
    
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
            solve error_rate before error;
            error dist {0 := (100 - error_rate), 1 := error_rate};
            error_rate inside {[0:10]};
        }
        else if (test_mode == INVALID_DIRECTIONS) {
            solve error_rate before error;
            error dist {0 := (100 - error_rate), 1 := error_rate};
            error_rate inside {[30:40]};
        }
        else { // SATURATION
            solve error_rate before error;
            error dist {0 := (100 - error_rate), 1 := error_rate};
            error_rate inside {[0:10]};
        }
    }
    
    // Constraint for destination address
    constraint c_dest_addr {
        if (test_mode == NORMAL) {
            dest_addr dist {
                [0:15]    := 95,  // Válidas - 95%
                [16:255]  := 5   // Inválidas - 5%
            };
        }
        else if (test_mode == SATURATION) {
            if (error_rate > 10) begin
                // Si se inyecta error, más probabilidad de inválidas
                // Congestión sucia
                dest_addr dist {
                    [0:15]    := 70,  // Válidas - 70%
                    [16:255]  := 30   // Inválidas - 30%
                };
            end
            else // Congestión limpia
            dest_addr dist {
                [0:15]    := 90,  // Válidas - 90%
                [16:255]  := 10   // Inválidas - 10%
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
                [16:255]  := 60   // Inválidas - 60%
            };
        }
        else { // ROBUSTNESS
            // Mayor probabilidad de direcciones inválidas
            dest_addr dist {
                [0:15]    := 80,  // Válidas - 80%
                [16:255]  := 20   // Inválidas - 20%
            };
        }
    }

    // Constructor
    function new(string name = "item");
        super.new(name);
    endfunction : new

    // Print method for debugging
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("data_in", data_in, $bits(data_in));
        printer.print_field_int("data_out", data_out, $bits(data_out));
        printer.print_field_int("num_transactions", num_transactions, 32);
        printer.print_field_int("delay_cycles", delay_cycles, 32);
        printer.print_field_int("error_rate", error_rate, 1);
        printer.print_field_int("dest_addr", dest_addr, 8);
        printer.print_string("test_mode", test_mode.name());
    endfunction : do_print

endclass : item

class gen_item_seq extends uvm_sequence #(item);
    `uvm_object_utils(gen_item_seq)

    // Test scenario selector
    typedef enum {GENERAL, SATURATION, COLLISION, INVALID, RESET} scenario_t;
    scenario_t scenario;

    // Constructor
    function new(string name = "gen_item_seq");
        super.new(name);
    endfunction : new

    // Body: generates items according to scenario
    virtual task body();
        item itm;
        int num_items;

        case (scenario)
            GENERAL: begin
                num_items = $urandom_range(10, 50);
                for (int i = 0; i < num_items; i++) begin
                    itm = item::type_id::create("itm");
                    itm.test_mode = item::NORMAL;
                    itm.randomize();
                    start_item(itm);
                    finish_item(itm);
                end
            end
            SATURATION: begin
                num_items = $urandom_range(80, 120);
                for (int i = 0; i < num_items; i++) begin
                    itm = item::type_id::create("itm");
                    itm.test_mode = item::SATURATION;
                    itm.randomize();
                    start_item(itm);
                    finish_item(itm);
                end
            end
            COLLISION: begin
                num_items = $urandom_range(20, 50);
                for (int i = 0; i < num_items; i++) begin
                    itm = item::type_id::create("itm");
                    itm.test_mode = item::COLLISION;
                    itm.randomize();
                    start_item(itm);
                    finish_item(itm);
                end
            end
            INVALID: begin
                num_items = $urandom_range(30, 60);
                for (int i = 0; i < num_items; i++) begin
                    itm = item::type_id::create("itm");
                    itm.test_mode = item::INVALID_DIRECTIONS;
                    itm.randomize();
                    start_item(itm);
                    finish_item(itm);
                end
            end
            RESET: begin
                num_items = $urandom_range(20, 40);
                for (int i = 0; i < num_items; i++) begin
                    itm = item::type_id::create("itm");
                    itm.test_mode = item::NORMAL;
                    itm.randomize();
                    start_item(itm);
                    finish_item(itm);
                    // Simulate reset event (user should implement actual reset logic)
                    if (i == num_items/2) begin
                        `uvm_info("RESET", "Reset triggered mid-sequence", UVM_MEDIUM)
                        // Insert DUT reset logic here
                    end
                end
            end
            default: begin
                `uvm_error("SEQ", "Unknown scenario selected")
            end
        endcase
    endtask : body

endclass : gen_item_seq
