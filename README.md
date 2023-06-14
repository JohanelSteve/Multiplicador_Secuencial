# Proyecto_3_Multiplicador_Secuencial

Se trabajara en este reposito el proyecto del curso de Diseño Logico 2023. En el proyecto se busca desarrollar habilidades en diseño de hardware.


<h4>Equipo de trabajo:</h4>
<p>-Fabrizio Vivas <br> -Johanel Álvarez <br> </p>


# Descripcion del proyecto #

<p>
  
Se solicita el desarrollo de una unidad de multiplicación secuencial. El mismo deberá construirse
según las pautas fundamentales de diseño digital sincrónico. El circuito constará de tres bloques de constructivos o subsistemas:
  
1. Subsistema de lectura de datos.
2. Subsistema de cálculo de multiplicación.
3. Subsistema de despliegue de resultado.


# Subsistema de lectura de datos #
  El subsistema de lectura realiza la operación de multiplicación utilizando operandos A y B de 8 bits cada uno. Estos operandos se interpretan como enteros sin signo. Para capturar y sincronizar la entrada del código con el sistema principal, se utiliza un circuito antirrebote que consta de al menos 4 etapas (4 Flip-Flops en cascada) por interruptor. El circuito espera la activación de un botón pulsador y no iniciará otra operación hasta que el botón vuelva a su estado inicial (cero).

  
  
# Subsistema de cálculo de multiplicación #
  El subsistema de cálculo de multiplicación recibe los operandos A y B del subsistema de lectura. La operación de multiplicación se inicia cuando el subsistema de lectura le indica a este subsistema que los operandos son válidos mediante una señal de inicio. El cálculo de multiplicación se realiza de manera iterativa utilizando el algoritmo que se describe en la sección "Algoritmo de Booth". Una vez que se obtiene el resultado, el bloque emite una señal de "listo" (ready) para indicar que el resultado es válido. Se debe implementar este sistema siguiendo la metodología de separar la ruta de control de la ruta de datos.
  ![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/3b07ed9a-0a95-4560-b5b0-4848e322e742)

 
# Subsistema de despliegue de resultado #
  
 El subsistema de despliegue tiene las siguientes características:

1. Después de completar la operación, el sistema mostrará los resultados en los LEDs disponibles, que son 16 en total.
2. La información mostrada en los LEDs se actualiza solo al finalizar una operación. No se mostrarán valores intermedios durante el proceso.
  
  ![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/51005e38-8b82-4c6d-9de9-12d58cfc9732)

# Algoritmo de Booth #
El algoritmo de Booth es un método iterativo para la multiplicación que requiere menos componentes combinacionales que la implementación directa. Sin embargo, su rendimiento es menor, ya que toma varios ciclos de reloj para obtener el resultado final.
  
  Fuente de informacion:  http://vlabs.iitkgp.ernet.in/coa/exp7/index.html.
  
  
 # Entregable (informe) #
  
Los estudiantes deben presentar un informe en formato Markdown que incluya una descripción del funcionamiento general del circuito y de cada subsistema, diagramas de bloques y estados, una simulación funcional, análisis de consumo de recursos y potencia, y una discusión de los problemas encontrados y sus soluciones.
 
  # Evaluación #
  
  ![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/797fdf7c-c53c-4be8-a7e5-055fb9389ca5)

  
  # Diseño (Progreso del proyecto) #
  
  
  Podemos observar la etapa de entrada mediante 4 FF en cascadas 
![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/c7a451ac-bf43-4168-a3a7-2adbbf0c45f6)




# Maquina microprogramada #


![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/04e5e51e-32c9-4fb0-b107-5b5f898455ff)


![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/94fe9324-028e-4ebd-ac97-24509e18bebe)


# Tabla de estados de control # 
![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/a4541863-4bf6-43f7-831e-afdf2d854c41)

![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/8546eda2-c06f-447d-99ed-1776d544f642)

# Testbench # 
Para comprobar el funcionamiento nos basamos en probar principalmente el multiplicador, puesto la entrada del sistema fue reciclada de proyectos anteriores y ya se realizaron su verificación. 
![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/ee29fbde-3cb3-4dd2-a554-f219ca8062df)


# Diagrama del multiplicador #
![image](https://github.com/JohanelSteve/Multiplicador_Secuencial/assets/104220377/d97c611e-b905-41e8-bdd7-b3f8bde29577)

# Referencias: #

Patterson, D. A., & Hennessy, J. L. (2004). Computer organization and design: The hardware/software interface. Morgan Kaufmann.





