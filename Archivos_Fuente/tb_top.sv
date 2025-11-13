// ============================ tb_top.sv ============================
//`timescale 1ns/1ps
import uvm_pkg::*; 
`include "uvm_macros.svh"

// RTL 
//`include "fifo.sv"
//`include "Library.sv"
`include "Router_library.sv"

//interfaz
`include "TypesandTransactions.sv"
`include "Secuencer.sv"
`include "Drivers.sv"
`include "monitor.sv"
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

  always #5 clk = ~clk;
  initial begin
    clk = 0;
    reset = 1;
    repeat (3) @(posedge clk);
    reset = 0;
  end


  
  // ---------------- Buses DUT <-> TB ----------------
  logic [PCK_SZ-1:0] data_out [N_TERMS];
  logic pndng [N_TERMS];
  logic popin [N_TERMS];

  logic [PCK_SZ-1:0] data_in [N_TERMS];
  logic pndng_in [N_TERMS];
  logic pop [N_TERMS];

  // ---------------- 16 interfaces ------------
  router_if #(PCK_SZ) term_if [N_TERMS](clk, reset);

  // ---------------- DUT ----------------
  // mesh_gnrtr instantiates the mesh network under test.
  // Parameters:
  // .fifo_depth(4), 
  // bdcst is set to 8'b11111111 (all ones) for broadcast purposes
  // .bdcst({8{1'b1}})
  //   PCK_SZ: packet size
  //   fifo_depth: FIFO depth per router
  //   bdcst: broadcast mask
  mesh_gnrtr #(
    .ROWS(ROWS), .COLUMS(COLUMS), .pckg_sz(PCK_SZ),
    .fifo_depth(4), .bdcst({8{1'b1}})
  ) dut (
    .pndng         (pndng),
    .data_out      (data_out),
    .popin         (popin),
    .pop           (pop),
    .data_out_i_in (data_in),
    .pndng_i_in    (pndng_in),
    .clk           (clk),
    .reset         (reset)
  );

  
  // ---------------- Cableado 1:1 DUT <-> Interfaces ----------------
  genvar i;
  generate
    for (i = 0; i < N_TERMS; i++) begin : BIND

      assign term_if[i].data_out = data_out[i];
      assign term_if[i].pndng    = pndng[i];
      assign term_if[i].popin    = popin[i];
      assign data_in[i]          = term_if[i].data_in;
      assign pndng_in[i]         = term_if[i].pndng_in;
      assign pop[i]              = term_if[i].pop;
    end
  endgenerate

  // ---------------- Pasar VIFs a tus agentes reales (agt0..agt15, d0/m0) ----
  // Agent se llama "agt%0d" y dentro tiene "d0" (driver) y "m0" (monitor).
// set por índice constante (genvar)
initial begin
  generate
    for (genvar g = 0; g < N_TERMS; g++) begin : CFG
      begin
        uvm_config_db#(virtual router_if#(PCK_SZ))::set(
          null, $sformatf("uvm_test_top.env.agt%0d.drv", g), "vif", term_if[g]
        );
        uvm_config_db#(virtual router_if#(PCK_SZ))::set(
          null, $sformatf("uvm_test_top.env.agt%0d.mon", g), "vif", term_if[g]
        );
      end
  endgenerate
end
  
  initial run_test("base_test");

  initial begin 
    $fsdbDumpfile("waves.fsdb"); 
    $fsdbDumpvars(0,tb_top); 
  end


endmodule
