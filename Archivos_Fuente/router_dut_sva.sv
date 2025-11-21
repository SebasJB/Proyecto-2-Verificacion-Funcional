module router_dut_sva #(
  int ROWS=4, COLUMS=4, PCK_SZ=40, N_TERMS=(2*ROWS + 2*COLUMS)
)(
  input  logic                          clk, reset,
  input  logic [PCK_SZ-1:0]             data_out     [N_TERMS],
  input  logic                          pndng        [N_TERMS],
  input  logic                          pop          [N_TERMS],
  input  logic [PCK_SZ-1:0]             data_out_i_in[N_TERMS],
  input  logic                          pndng_i_in   [N_TERMS],
  input  logic                          popin        [N_TERMS]
);
  localparam int N_TERMS = 2*ROWS + 2*COLUMS;

  function automatic logic [5:0] dst_of (logic [PCK_SZ-1:0] p);
    return p[DST_MSB:DST_LSB];
  endfunction

  genvar i;
  generate
    for (i=0;i<N_TERMS;i++) begin : SVA
      // Progreso: si hay pndng[i] debe llegar pop[i] en ventana
      assert property (@(posedge clk) disable iff (reset)
                       pndng[i] |-> ##[1:128] pop[i]);
  
      // Correctitud de destino: SIN broadcast (debe salir por su terminal)
      assert property (@(posedge clk) disable iff (reset)
                       pndng[i] |-> (dst_of(data_out[i]) == i))
        else $error("Salida %0d con destino %0d inválido", i, dst_of(data_out[i]));
    end
  endgenerate
endmodule