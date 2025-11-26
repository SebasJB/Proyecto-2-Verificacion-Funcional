// ============================ tb_top.sv ============================
//`timescale 1ns/1ps
import uvm_pkg::*; 
`include "uvm_macros.svh"

// RTL 
//`include "fifo.sv"
//`include "Library.sv"
`include "Router_library.sv"


//interfaz
`include "hdr_map_pkg.sv"
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
  reg clk;
  reg reset;

  always #5 clk = ~clk;

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

  // 1) Covergroup parametrizado por una interface
  covergroup cg_payload (ref router_if #(PCK_SZ) rif) @(posedge rif.clk);
    option.per_instance = 1;

    cp_src : coverpoint rif.data_out[hdr_map_pkg::SRC_MSB:hdr_map_pkg::SRC_LSB]
             iff (!rif.reset && rif.pndng) {
      bins src[] = {[0:31]};
    }

    cp_dst : coverpoint rif.data_out[hdr_map_pkg::DST_MSB:hdr_map_pkg::DST_LSB]
             iff (!rif.reset && rif.pndng) {
      bins dst[] = {[0:31]};
    }

    cp_id  : coverpoint rif.data_out[hdr_map_pkg::ID_MSB:hdr_map_pkg::ID_LSB]
             iff (!rif.reset && rif.pndng) {
      bins id[] = {[0:(1<<9)-1]};
    }
  endgroup

  // 2) Arreglo de covergroups, uno por terminal
  cg_payload cg_payload_term [N_TERMS];

  initial begin
    // crear cada covergroup y enlazarlo a la interfaz correspondiente
    for (int k = 0; k < N_TERMS; k++) begin
      cg_payload_term[k] = new(term_if[k]);
    end
  end


  
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
  generate
    for (genvar g = 0; g < N_TERMS; g++) begin : CFG
      initial begin
        uvm_config_db#(virtual router_if #(PCK_SZ))::set(null, $sformatf("uvm_test_top.env.agt%0d.drv", g), "vif", term_if[g]);
        uvm_config_db#(virtual router_if #(PCK_SZ))::set(null, $sformatf("uvm_test_top.env.agt%0d.mon", g), "vif", term_if[g]
        );
      end
    end
  endgenerate
  
  initial begin
    reset = 1;
    repeat (5) @(posedge clk);
    reset = 0;
    repeat (10) @(posedge clk);
  end
  // ---------------- Iniciar test UVM ----------------
  initial begin
    clk = 0;
    uvm_config_db#(virtual router_if #(PCK_SZ))::set(null, "uvm_test_top", "vif", term_if[0]);
    run_test("base_test");
  end

  initial begin 
    $fsdbDumpfile("waves.fsdb"); 
    $fsdbDumpvars(0,tb_top); 
  end
endmodule

