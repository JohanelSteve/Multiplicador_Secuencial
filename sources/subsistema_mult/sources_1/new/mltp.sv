`timescale 1ns / 1ps


module mltp (
  input S, CLK, Clr,
  input [7:0] Binput, Qinput,
  output C,
  output [7:0] A, Q,
  output [2:0] P
);

  // Registros del sistema
  reg C;
  reg [7:0] A, Q, B;
  reg [2:0] P;
  reg [2:0] pstate, nstate; // Registro de control

  // Parámetros de estado
  parameter T0 = 3'b000, T1 = 3'b001, T2 = 3'b010, T3 = 3'b011;

  // Circuito combinacional
  wire Z;
  assign Z = ~|P; // Verificar si es cero

  // Transición de estado para control
  always @(negedge CLK or negedge Clr)
    if (~Clr) pstate <= T0;
    else pstate <= nstate;

  always @(S or Z or pstate)
    case (pstate)
      T0: if (S) nstate <= T1; else nstate <= T0;
      T1: nstate <= T2;
      T2: nstate <= T3;
      T3: if (Z) nstate <= T0;
          else nstate <= T2;
    endcase

  // Operaciones de transferencia de registros
  always @(negedge CLK)
    case (pstate)
      T0: B <= Binput; // Introducir multiplicando
      T1: begin
        A <= 8'b00000000; // Registro de 8 bits
        C <= 1'b0;
        P <= 3'b101; // Iniciar contador en n=5
        Q <= Qinput; // Introducir multiplicador
      end
      T2: begin
        P <= P - 3'b001; // Decrementar contador
        if (Q[0])
          {C, A} <= A + B; // Sumar multiplicando
      end
      T3: begin
        C <= 1'b0; // Despejar C
        A <= {C, A[7:1]}; // Desplazar A a la derecha (de 8 bits)
        Q <= {A[0], Q[7:1]}; // Desplazar Q a la derecha (de 8 bits)
      end
    endcase
    endmodule