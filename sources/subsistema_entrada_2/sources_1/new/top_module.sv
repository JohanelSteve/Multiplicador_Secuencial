`timescale 1ns / 1ps


module top_module(SW,RST,CLK, OUT_Final,AN);
input logic [15:0] SW;
input logic CLK, RST;
logic [15:0] OUT_SYNC_top;

output logic [6:0] OUT_Final;
output logic [3:0] AN;

    Sync Sync_top(.SW(SW),.RST(RST), .CLK(CLK), .OUT_SYNC(OUT_SYNC_top));
 //   Modulo_00 Modulo_00_top(.IN_00(OUT_SYNC_top) , .OUT_00(OUT_00_top));
    


 
 //   top_7segmt top_7segmt_top( .Clk_signal(CLK) , .bits_on(OUT_Mux_top) , .hex_reg(OUT_Final) , .anodes(AN) );


endmodule
