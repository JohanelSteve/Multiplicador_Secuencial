`timescale 1ns / 1ps


module Sync(SW, CLK, OUT_SYNC, RST);
input logic [15:0] SW;
input logic CLK, RST;
output logic [15:0] OUT_SYNC;
logic [15:0] OUT_F0, OUT_F1, OUT_F2;

    FFD FFD_0 (.CLK(CLK),.D(SW),.Q(OUT_F0),.RST(RST));
    FFD FFD_1 (.CLK(CLK),.D(OUT_F0),.Q(OUT_F1),.RST(RST));
    FFD FFD_2 (.CLK(CLK),.D(OUT_F1),.Q(OUT_F2),.RST(RST));
    FFD FFD_3 (.CLK(CLK),.D(OUT_F2),.Q(OUT_SYNC),.RST(RST));
    
endmodule
