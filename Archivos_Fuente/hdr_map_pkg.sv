
package hdr_map_pkg;
  parameter int PCK_SZ = 40;

  // === bit map (MSB:LSB) según tu definición ===
  localparam int ID_LSB       = PCK_SZ-38; // 10:2 para PCK_SZ=40
  localparam int ID_MSB       = PCK_SZ-30;

  localparam int DST_LSB      = PCK_SZ-29; // 16:11
  localparam int DST_MSB      = PCK_SZ-24;

  localparam int SRC_LSB      = PCK_SZ-23; // 22:17
  localparam int SRC_MSB      = PCK_SZ-18;

  localparam int MODE_BIT     = PCK_SZ-17; // 23

  localparam int TRGT_C_LSB   = PCK_SZ-16; // 27:24
  localparam int TRGT_C_MSB   = PCK_SZ-13;

  localparam int TRGT_R_LSB   = PCK_SZ-12; // 31:28
  localparam int TRGT_R_MSB   = PCK_SZ-9;

  // Campo no usado
  localparam int NXT_JUMP_LSB = PCK_SZ-8;  // 39:32
  localparam int NXT_JUMP_MSB = PCK_SZ-1;

  // Útil para el SCB: payload “resto” = [SRC_MSB:0] (22..0)
  localparam int PAYLOAD_MSB  = SRC_MSB;
  localparam int PAYLOAD_LSB  = 0;
endpackage
