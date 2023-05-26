`timescale 1ns / 1ps

module Antirrebote_ff_tb;
    reg clk;
    reg reset;
    reg [15:0] botones;
    reg enable;
    wire [15:0] salida;

    Antirrebote_ff uut (
        .clk(clk),
        .reset(reset),
        .botones(botones),
        .enable(enable),
        .salida(salida)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        botones = 16'b0000000000000000;
        enable = 0;

        #10 reset = 1;
        #20 reset = 0;

        // Test 1: Pulsar el botón 0 con habilitación
        #10 enable = 1;
        #5 botones = 16'b0000000000000001;
        #100;
        enable = 0;

        // Test 2: Pulsar el botón 5 sin habilitación
        #10 enable = 0;
        #5 botones = 16'b0000010000000000;
        #100;
        $finish;
    end
endmodule