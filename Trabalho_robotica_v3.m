%%%%%%%%%BLU3704-07754 (20181) - IntroduÁ„o a Robatica Industrial%%%%%%%%%
%Universidade Federal de Santa Catarina
%Engenharia de Controle e AutomaÁ„o
%Trabalho 1 - Modelo e simulacao Robo KUKA KR 3 R540
%Professor: Marcelo Roberto Petry
%Alunos: Christian Correa de Borba      <christian962000@hotmail.com>
%        Gustavo Abiel Link             <gustavo_abiel@hotmail.com>
%Blumenau, 28 de maio de 2018


clear
close all
clc

%% Parametros Denavit-Hartenberg
L(1) = Link('d', -345, 'a', 20, 'alpha', pi/2, 'qlim', [-170*pi/180 170*pi/180]);
L(2) = Link('offset', -pi/2, 'd', 0, 'a', 260, 'alpha', 0, 'qlim', [-170*pi/180 50*pi/180]);
L(3) = Link('d', 0, 'a', 20, 'alpha', pi/2, 'qlim', [-110*pi/180 155*pi/180]);
L(4) = Link('d', -260, 'a', 0, 'alpha', -pi/2, 'qlim', [-175*pi/180 175*pi/180]);
L(5) = Link('d', 0, 'a', 0, 'alpha', pi/2, 'qlim', [-120*pi/180 120*pi/180]);
L(6) = Link('d', -195, 'a', 0, 'alpha', 0, 'qlim', [-350*pi/180 350*pi/180]);

robo = SerialLink(L, 'name', 'KR 3 R540', 'manufacturer', 'KUKA'); %Cria o robo com os parametros acima definidos

%% Q.1 - Cinematica direta
%Entrada do usuario, usada para determinar a posicao final do manipulador
Q1 = deg2rad(input ('Fornecer o angulo da junta 1 ([-170,170] graus): ')); % +-170
Q2 = deg2rad(input ('Fornecer o angulo da junta 2 ([0, 50] graus): ')); % 0 - 50
Q3 = deg2rad(input ('Fornecer o angulo da junta 3 ([0, 94] graus): ')); %% 0 - 94
Q4 = deg2rad(input ('Fornecer o angulo da junta 4 ([-175, 175] graus): ')); % 175 !0
Q5 = deg2rad(input ('Fornecer o angulo da junta 5 ([-120, 120] graus): ')); % 120 !0
Q6 = deg2rad(input ('Fornecer o angulo da junta 6  ([0, 180] graus): ')); % <180 !0


T1 = L(1).A(Q1).T;  T1(1,2) = 0;    T1(2,2) = 0;    T1(3,3) = 0;
T2 = L(2).A(Q2).T;
T3 = L(3).A(Q3).T;  T3(1,2) = 0;    T3(2,2) = 0;    T3(3,3) = 0;
T4 = L(4).A(Q4).T;  T4(1,2) = 0;    T4(2,2) = 0;    T4(3,3) = 0;
T5 = L(5).A(Q5).T;  T5(1,2) = 0;    T5(2,2) = 0;    T5(3,3) = 0;
T6 = L(6).A(Q6).T;

Q = [Q1 Q2 Q3 Q4 Q5 Q6]; %Condicao inicial do robo, posicao de masterizacao
M = T1*T2*T3*T4*T5*T6; %Matriz cinematica direta

clc
disp('As coordenadas (X,Y,Z) do manipulador sao: ');
disp(M(1:3,4));

set(gca,'Zdir','reverse','Xdir','reverse') %Reverte os eixos Z e X
robo.teach(Q, 'notiles', 'floorlevel', 115.50, 'lightpos',[0 0 -20]) %Posicao do chao e ajustes graficos

%% Q.2 - Cinematica inversa
M = T1*T2*T3*T4*T5*T6;  d6=[0; 0; 195]; %Matriz cinematica conhecida, usada para determinar o angulo das juntas

% Calculando a posicao
p06 = M(1:3,4);
R = M(1:3,1:3);
p04_aux = p06+R*d6;
q1 = atan2(p04_aux(2,1),p04_aux(1,1));

p04 = sqrt(p04_aux(1,1)^2+p04_aux(2,1)^2+p04_aux(3,1)^2);
p01_aux = L(1).A(q1);
p01_aux = [p01_aux.t(1,1); p01_aux.t(2,1); p01_aux.t(3,1)];
p01 = sqrt(p01_aux(1,1)^2+p01_aux(2,1)^2+p01_aux(3,1)^2);
p14_aux = p04_aux-p01_aux;
p14 = sqrt(p14_aux(1,1)^2+p14_aux(2,1)^2+p14_aux(3,1)^2);
p23 = sqrt(260^2+20^2);


beta = atan(345/20);
gama = acos((p04^2-p01^2-p14^2)/(-2*p01*p14));
omega = acos((-p14^2-260^2+p23^2)/(-2*260*p14));
q2 = 2*pi-(pi/2+beta+gama+omega);



if rad2deg(gama)>180+atand(20/345)+0.000000000000001e+02
    disp('Ponto invalido');
end

epsolon = acos((p14^2-260^2-p23^2)/(-2*260*p23));
phi = atan(260/20);
q3 = pi-epsolon-phi;


if rad2deg(epsolon)>180 || rad2deg(epsolon)<0
    disp('Ponto invalido');
end


% Calculando a orientacao
T1 = L(1).A(q1).T;
T2 = L(2).A(q2).T;
T3 = L(3).A(q3).T;
T03 = (T1*T2*T3);
T36 = T03\M;

q4 = atan2(T36(2,3),T36(1,3));
q5 = atan2(sqrt(T36(1,3)^2+T36(2,3)^2),T36(3,3));
q6 = atan2(T36(3,2),-T36(3,1));

q14 = atan2(-T36(2,3),-T36(1,3));
q15 = atan2(-sqrt(T36(1,3)^2+T36(2,3)^2),T36(3,3));
q16 = atan2(-T36(3,2),T36(3,1));


Q2 = [rad2deg(q1); rad2deg(q2); rad2deg(q3); rad2deg(q4); rad2deg(q5); rad2deg(q6)];
Q1=[rad2deg(q14);rad2deg(q15);rad2deg(q16)];

%% Tratamento de erro para theta 5 entre 0 e pi 
J=zeros(1,6);
error = 0;
disp(' Resposta da cinematica inversa se o theta5 estiver entre 0 e pi ')
if Q2(1,1) <= -171 || Q2(1,1)>= 171
   J(1)=1;
   error = 1;
end

if Q2(2,1) <= -171 || Q2(2,1)> 51
   J(2)=1;
   error = 1;
end

if Q2(3,1) < -110 || Q2(3,1)> 155
    error = 1;
    J(3)=1;
end

if Q2(4,1) < -175 || Q2(4,1)> 175
    error = 1;
    J(4)=1;
end

if Q2(5,1) < -120 || Q2(5,1)> 120
    error = 1;
    J(5)=1;
end

if Q2(6,1) < -350 || Q2(6,1)> 350
    error = 1;
    J(6)=1;
end

if error == 1 
    disp('Nao eh possivel alcancar este ponto')
    disp('Vetor de erro da junta:') %% se for aparecer um no Vetor h· erro J=[J1 J2 J3 J4 J5 J6]
    disp(J);
end
   
    
if error ~= 1
    disp('Os angulos das juntas sao:')
    disp(Q2)
  end

%% Tratamento de erro para theta 5 entre 0 e -pi 
J=zeros(1,6);
error = 0;
Q2(4:6,1)=Q1;
disp(' Resposta da cinematica inversa se o theta5 estiver entre -pi e 0 ')
if Q2(1,1) <= -171 || Q2(1,1)>= 171
   J(1)=1;
   error = 1;
end

if Q2(2,1) <= -171 || Q2(2,1)> 51
   J(2)=1;
   error = 1;
end

if Q2(3,1) < -110 || Q2(3,1)> 155
    error = 1;
    J(3)=1;
end

if Q2(4,1) < -175 || Q2(4,1)> 175
    error = 1;
    J(4)=1;
end

if Q2(5,1) < -120 || Q2(5,1)> 120
    error = 1;
    J(5)=1;
end

if Q2(6,1) < -350 || Q2(6,1)> 350
    error = 1;
    J(6)=1;
end

if error == 1 
    disp('Nao eh possivel alcancar este ponto')
    disp('Vetor de erro da junta:') %% se for aparecer um no Vetor h· erro J=[J1 J2 J3 J4 J5 J6]
    disp(J);
    
end
   
    
if error ~= 1
    disp('Os angulos das juntas sao:')
    disp(Q2)
end



