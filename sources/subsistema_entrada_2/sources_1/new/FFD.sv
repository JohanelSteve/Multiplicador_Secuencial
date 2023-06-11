`timescale 1ns / 1ps

module FFD(CLK,D,Q, RST); //Se escriben las entradas y las salidas
		input CLK,D, RST; // se escriben las entradas
		output logic Q; //se escriben las salidas
	
	always@(posedge CLK or posedge RST) 
	if (RST) 
	   Q <= 0;
	
	else
	   Q <= D; 
	   
	
endmodule
