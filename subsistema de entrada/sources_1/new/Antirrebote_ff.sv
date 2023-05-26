`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////
module Antirrebote_ff (
    input wire clk,
    input wire reset,
    input wire [15:0] botones,
    input wire enable, //prueba enable
    output reg [15:0] salida
);

    localparam N = 19; // Ventana de 10ms para estabilizar

    reg [N-1:0] contador;
    wire [15:0] flanco;
    reg habilitar; //prueba de enable*******

//etapa de contador para establecer tiempo del antirrebote

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            contador <= 0;
        else
            contador <= contador + 1;
    end

    assign flanco = &contador; // AND de todos los bits de count consigo mismo. Tick solo se pondrá en alto cuando los 19 bits de count sean 1, es decir, después de 10 ms.


    
 //antirrebote con FSM  
    localparam [2:0]
        est_0 = 3'b000, //est_0: estado cero no se ha tocado ningun boton
        activo1 = 3'b001, //activo1: estado de transicion si es estable pasa a activo2 si no lo es se devuelve a est_0
        activo2 = 3'b010, // mismo
        activo3 = 3'b011, // mismo
         est_1 = 3'b100,  // est_1: estado estable antirrebote completo
         bajo1 = 3'b101,  //  boton presionado nuevamente antirrebote ahora contrario hasta estado 0
         bajo2 = 3'b110, // mismo descendente
         bajo3 = 3'b111; // mismo descendente

    reg [2:0] reg_estados [15:0];
    reg [2:0] paso_estado [15:0];
always @(posedge clk or posedge reset)
 // ciclo para asignar los estados a los 16 botones (8 bits del operando A y 8 bits del operando B)
begin
    if (reset)
        for (int i = 0; i < 16; i = i + 1)
            reg_estados[i] <= est_0;
    else
        for (int i = 0; i < 16; i = i + 1)
            reg_estados[i] <= paso_estado[i];
end

    always @(*)
    begin
        for (int i = 0; i < 16; i = i + 1)
        begin
            paso_estado[i] <= reg_estados[i]; // Para que el estado actual sea el estado por defecto
            salida[i] <= 1'b0; // Salida predeterminado en bajo

            case (reg_estados[i])
                est_0:
                    if (enable && botones[i]) // Si se detecta el boton, pasar a activo1.
                        paso_estado[i] <= activo1 ;
                activo1 :
                    if (~botones[i]) // Si el boton vuelve a cero, no estable y devuelta a est_0.
                        paso_estado[i] <= est_0;
                    else if (flanco) // Si el boton se mantiene alto después de 10 ms, vaya a activo2.
                        paso_estado[i] <=  activo2;
                 activo2:
                    if (~botones[i]) // Si el boton esta en bajo, la entrada aun no es estable y se vuelva a est_0.
                        paso_estado[i] <= est_0;
                    else if (flanco) // Si el boton se mantiene alto después de 20 ms, pasar activo3.
                        paso_estado[i] <= activo3;
                activo3:
                    if (~botones[i]) // Si el boton vuelve a cero, la entrada aun no es estable y se vuelve a est_0.
                        paso_estado[i] <= est_0;
                    else if (flanco) // Si el boton se mantiene alto despues de 30 ms, pasar a est_1.
                        paso_estado[i] <= est_1;
                est_1: // rebote eliminado,  salida en high.
                    begin
                        salida[i] <= 1'b1;
                        if (~botones[i]) // Si el boton se suelta, pasa al siguiente estado bajo1.
                            paso_estado[i] <=  bajo1;
                    end
                 bajo1:
                    if (botones[i]) // Si el boton vuelve a ser presionado, la entrada aun no es estable y se vuele a est_1.
                        paso_estado[i] <= est_1;
                    else if (flanco) // Si el boton se mantiene bajo despues de 10 ms, pasa a est_2.
                        paso_estado[i] <=  bajo2;
                 bajo2:
                    if (botones[i]) // Si el boton vuelve a ser presionado, la entrada aun no es estable y se vuelve a est_1.
                        paso_estado[i] <= est_1;
                    else if (flanco) // Si el boton se mantiene bajo después de 20 ms, pasar al estado bajo3.
                        paso_estado[i] <=  bajo3;
                 bajo3:
                    if (botones[i]) // Si el boton se vuelve a presionar, la entrada aun no es estable y se vuelve a est_1.
                        paso_estado[i] <= est_1;
                    else if (flanco) // boton presionado, sin rebote regresa al estado est_0 para esperar la siguiente entrada.
                        paso_estado[i] <= est_0;
            endcase
        end
    end
endmodule