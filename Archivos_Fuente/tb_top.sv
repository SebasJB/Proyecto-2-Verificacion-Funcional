// ============================ tb_top.sv ============================
`timescale 1ns/1ps
import uvm_pkg::*; 
`include "uvm_macros.svh"

// RTL 
`include "fifo.sv"
`include "Library.sv"
`include "Router_library.sv"

//interfaz
`include "Secuencer.sv"
`include "Drivers.sv"
`include "Monitor.sv"
`include "Agente.sv"
`include "Scoreboard.sv"
`include "environment.sv"
`include "test.sv"


module tb_top;
  // ---------------- Parámetros DUT/mesh ----------------
  localparam int ROWS    = 4;
  localparam int COLUMS  = 4;
  localparam int PCK_SZ = 40;
  localparam int N_TERMS = (2*ROWS + 2*COLUMS); // 16

  // ---------------- Reloj / Reset ----------------
  logic clk;  
  logic reset;
  initial begin 
    clk = 0; 
    forever #5 clk = ~clk; 
  end
  initial begin 
    reset = 1; 
    #10 reset = 0; 
  end

  // ---------------- Buses DUT <-> TB ----------------
  logic [PCK_SZ-1:0] data_out [N_TERMS];
  logic pndng [N_TERMS];
  logic popin [N_TERMS];

  logic [PCK_SZ-1:0] data_out_i_in [N_TERMS];
  logic pndng_i_in [N_TERMS];
  logic pop [N_TERMS];

  // ---------------- 16 interfaces ------------
  router_if #(PCK_SZ) term_if [N_TERMS]();

  // ---------------- DUT ----------------
  mesh_gnrtr #(
    .ROWS(ROWS), .COLUMS(COLUMS), .PCK_SZ(PCK_SZ),
    .fifo_depth(4), .bdcst({8{1'b1}})
  ) dut (
    .pndng         (pndng),
    .data_out      (data_out),
    .popin         (popin),
    .pop           (pop),
    .data_out_i_in (data_out_i_in),
    .pndng_i_in    (pndng_i_in),
    .clk           (clk),
    .reset         (reset)
  );

  // ---------------- Cableado 1:1 DUT <-> Interfaces ----------------
  genvar i;
  generate
    for (i = 0; i < N_TERMS; i++) begin : BIND
      assign term_if[i].clk   = clk;
      assign term_if[i].reset = reset;

      assign term_if[i].data_out = data_out[i];
      assign term_if[i].pndng    = pndng[i];
      assign term_if[i].popin    = popin[i];
      assign data_out_i_in[i] = term_if[i].data_out_i_in;
      assign pndng_i_in[i]    = term_if[i].pndng_i_in;
      assign pop[i]           = term_if[i].pop;
    end
  endgenerate

  // ---------------- Pasar VIFs a tus agentes reales (agt0..agt15, d0/m0) ----
  // Agent se llama "agt%0d" y dentro tiene "d0" (driver) y "m0" (monitor).
  initial begin
    for (int k = 0; k < N_TERMS; k++) begin
      uvm_config_db#(virtual router_if)::set(
        null, $sformatf("uvm_test_top.env.agt%0d.drv", k), "vif", term_if[k]
      );
      uvm_config_db#(virtual router_if)::set(
        null, $sformatf("uvm_test_top.env.agt%0d.mon", k), "vif", term_if[k]
      );
    end
    // Llama explícitamente a tu test por nombre para evitar depender de +UVM_TESTNAME
    run_test("base_test");
  end
endmodule
