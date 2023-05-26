`timescale 1ns / 1ps


module top_7segmt(
input Clk_signal,
input [3:0] bits_on,
output [6:0] hex_reg,
output [3:0] anodes
);

wire [6:0] hex_reg0, hex_reg1, hex_reg2, hex_reg3;

display_7segmt d0(.hex_bits(bits_on), .hex_reg(hex_reg0));
display_7segmt d1(.hex_bits(bits_on), .hex_reg(hex_reg1));
display_7segmt d2(.hex_bits(bits_on), .hex_reg(hex_reg2));
display_7segmt d3(.hex_bits(bits_on), .hex_reg(hex_reg3));
    


mux_7segmt mux_7segmet_top(.Clk_signal(Clk_signal), .Reset(1'b0), .disp_0(hex_reg0), .disp_1(hex_reg1), .disp_2(hex_reg2), .disp_3(hex_reg3));
endmodule