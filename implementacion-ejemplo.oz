% Christian Camilo Urcuqui López
% David Andrés Manzano Herrera
% Introducción a la programación por restricciones
% Proyecto Final - Entrega 1
% Implementación del ejemplo planteado por los autores en
%"Transforming attribute and clone-enabled feature models into constraint programs over finite domains"
declare
proc {MCS Root}
   %% declare variables
   %% Paso 1: Definir las variables de acuerdo a las Features del modelo, su cardinalidad y atributos 
   MovementControlSystem
   SpeedSensor
   PositionSensor
   PositionSensor1
   PositionSensor2
   PositionSensor3
   PositionSensor4
   Processor
   Processor1
   Processor2
   InternalMemory
   InternalMemory1
   InternalMemory2
   Size
in
   %% Estructura de la respuesta
   Root = sol(mcv:MovementControlSystem ss:SpeedSensor ps:PositionSensor ps1:PositionSensor1 ps2:PositionSensor2 ps3:PositionSensor3 ps4:PositionSensor4 p:Processor p1:Processor1 p2:Processor2 im:InternalMemory im1:InternalMemory1 im2:InternalMemory2 s:Size)

   %% Paso 2: Definir los dominios de cada variable
   MovementControlSystem  = {FD.int 0#1}
   SpeedSensor  = {FD.int 0#1}
   PositionSensor  = {FD.int 0#1}
   PositionSensor1  = {FD.int 0#1}
   PositionSensor2  = {FD.int 0#1}
   PositionSensor3  = {FD.int 0#1}
   PositionSensor4  = {FD.int 0#1}
   Processor  = {FD.int 0#1}
   Processor1  = {FD.int 0#1}
   Processor2  = {FD.int 0#1}
   InternalMemory1  = {FD.int 0#1}
   InternalMemory2  = {FD.int 0#1}
   Size  = {FD.int [0 128 512 1024]}

   %% Paso 3: Definir las restricciones correspondientes a las relaciones
   %%         entre las Features y su clones (cardinalidad)

   % PostionSensor
   {FD.impl PositionSensor1 PositionSensor 1}
   {FD.impl PositionSensor2 PositionSensor 1}
   {FD.impl PositionSensor3 PositionSensor 1}
   {FD.impl PositionSensor4 PositionSensor 1}

   % Processor
   {FD.impl Processor1 Processor 1}
   {FD.impl Processor2 Processor 1}

   % InternalMemory
   {FD.impl InternalMemory1 InternalMemory 1}
   {FD.impl InternalMemory2 InternalMemory 1}

   %% Paso 4: Definir las restricciones correspondientes a la cardinalidad
   %%         de cada una de las Features

   % PositionSensor
   {FD.impl PositionSensor {FD.conj (PositionSensor1+PositionSensor2+PositionSensor3+PositionSensor4>=:0) (PositionSensor1+PositionSensor2+PositionSensor3+PositionSensor4=<:4)} 1}

   % Processor
   {FD.impl Processor {FD.conj (Processor1+Processor2>=:1) (Processor1+Processor2=<:2)} 1}

   % InternalMemory
   {FD.impl InternalMemory {FD.conj (InternalMemory1+InternalMemory2>=:1) (InternalMemory1+InternalMemory2=<:2)} 1}

   %% Paso 5: Definir las restricciones correspondientes a las relaciones padre-hijo
   {FD.equi MovementControlSystem SpeedSensor 1}
   {FD.equi MovementControlSystem Processor 1}
   {FD.equi Processor InternalMemory 1}
   {FD.impl MovementControlSystem PositionSensor>=:0 1}
   {FD.impl PositionSensor MovementControlSystem 1}

   %% Paso 6: Definir las restriciones correspondientes a los atributos
   {FD.equi InternalMemory Size>:0 1}

   %% Paso 7: Definir restricciones correspondientes a relaciones de requerimientos y excluisiones
   {FD.impl SpeedSensor PositionSensor 1}
   
   %% specify distribution strategy
   {FD.distribute ff Root}
   %{FD.distribute naive Root}
end

%{ExploreOne MCS}
%{Browse {SearchOne MCS}}

{ExploreAll MCS}
{Browse {SearchAll MCS}}