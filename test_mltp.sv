`timescale 1ns / 1ps

// Prueba del multiplicador binario
module test_mltp;
  // Entradas del multiplicador
  reg S, CLK, Clr;
  reg [7:0] Binput, Qinput; // Modificado para datos de entrada de 8 bits
  
  // Datos a exhibir
  wire C;
  wire [7:0] A, Q; // Modificado para datos de salida de 8 bits
  wire [2:0] P;
  
  // Crear instancia del multiplicador
  mltp mp(S, CLK, Clr, Binput, Qinput, C, A, Q, P);
  
  initial
  begin
    S = 0; CLK = 0; Clr = 0;
    #5 S = 1; Clr = 1;
    Binput = 8'b11101111; // Modificado para datos de entrada de 8 bits
    Qinput = 8'b11111110; // Modificado para datos de entrada de 8 bits
    #15 S = 0;
  end
  
  initial
  begin
    repeat (52) // Modificado para 52 ciclos de reloj para datos de 8 bits
      #5 CLK = ~CLK;
  end
  
  // Exhibir cálculos y comparar con la tabla
  always @(negedge CLK)
    $display("C=%b A=%b Q=%b P=%b time=%0d", C, A, Q, P, $time);
  
endmodule