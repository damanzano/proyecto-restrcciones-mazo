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
   Procesor
   Procesor1
   Procesor2
   InternalMemory
   InternalMemory1
   InternalMemory2
   Size
in
   %% Estructura de la respuesta
   Root = sol(mcv:MovementControlSystem ss:SpeedSensor ps:PositionSensor ps1:PositionSensor1 ps2:PositionSensor2 ps3:PositionSensor3 ps4:PositionSensor4 p:Procesor p1:Procesor1 p2:Procesor2 im:InternalMemory im1:InternalMemory1 im2:InternalMemory2 s:Size)

   %% Paso 2: Definir los dominios de cada variable
   MovementControlSystem  = {FD.int 0#1}
   SpeedSensor  = {FD.int 0#1}
   PositionSensor  = {FD.int 0#1}
   PositionSensor1  = {FD.int 0#1}
   PositionSensor2  = {FD.int 0#1}
   PositionSensor3  = {FD.int 0#1}
   PositionSensor4  = {FD.int 0#1}
   Procesor  = {FD.int 0#1}
   Procesor1  = {FD.int 0#1}
   Procesor2  = {FD.int 0#1}
   InternalMemory1  = {FD.int 0#1}
   InternalMemory2  = {FD.int 0#1}
   Size  = {FD.int [0 128 512 1024]}

   %% Paso 3: Definir las restricciones correspondientes a las relaciones
   %%         entre las Features y su clones (cardinalidad)

   % PostionSensor
   {FD.impl PositionSensor1 PositionSensor}
   {FD.impl PositionSensor2 PositionSensor}
   {FD.impl PositionSensor3 PositionSensor}
   {FD.impl PositionSensor4 PositionSensor}

   % Procesor
   {FD.impl Procesor1 Procesor}
   {FD.impl Procesor2 Procesor}

   % InternalMemory
   {FD.impl InternalMemory1 InternalMemory}
   {FD.impl InternalMemory2 InternalMemory}

   %% Paso 4: Definir las restricciones correspondientes a la cardinalidad
   %%         de cada una de las Features
   % PositionSensor
   {FD.impl PositionSensor {FD.conj (PositionSensor1+PositionSensor2+PositionSensor3+PositionSensor4>=:0) (PositionSensor1+PositionSensor2+PositionSensor3+PositionSensor4=<:4)}}

   % Procesor
   {FD.impl Procesor {FD.conj (Procesor1+Procesor2>=:1) (Procesor1+Procesor2=<:2)}}

   % InternalMemory
   {FD.impl InternalMemory {FD.conj (InternalMemory1+InternalMemory2>=:1) (InternalMemory1+InternalMemory2=<:2)}}

   %% Paso 5: Definir las restricciones correspondientes a las relaciones padre-hijo
   {FD.equi MovementControlSystem SpeedSensor}
   {FD.equi MovementControlSystem Procesor}
   {FD.equi Procesor InternalMemory}
   {FD.impl MovementControlSystem PositionSensor>=:0}
   {FD.impl PositionSensor MovementControlSystem}

   %% Paso 6: Definir las restriciones correspondientes a los atributos
   {FD.equi InternalMemory Size>:0}

   %% Paso 7: Definir restricciones correspondientes a relaciones de requerimientos y excluisiones
   {FD.impl SpeedSensor PositionSensor}
   
   %% specify distribution strategy
   {FD.distribute ff Root}
end

{ExploreOne MCS}
{Browse {SearchOne MCS}}