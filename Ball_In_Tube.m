%%  PTC 5880 - Controle H_? - PPGEE – EPUSP – Prof. Diego
% Projeto final - Moisés William Oliveira Santin – 12503372

clear all; close all; clc;
s = tf('s');

%% Planta
g_n = 90;
ct_n = 1.1;
 
%% Planta Gs com as incertezas no modelo variando 30%
p1 = 30;    % Porcentagem para gerar as incertezas
p2 = 30;    % Porcentagem para gerar as incertezas

g = ureal('ganho',g_n,'Percentage',p1); 
ct = ureal('Constante_de_Tempo',ct_n,'Percentage',p2);
 
Gs = g / (ct*s + 1)



%% Funções peso                
A = 0.02;   % Baixas frequencias
M = 0.98;   % Altas frequencias
wb = 0.01;  % Inclinação


Wp = ((s/M)+ wb) / (s + (A*wb));
Wu = 2;     % Valor de teste empírico  

P = augw(Gs,Wp,Wu);   % calcula um modelo de espaço de estados de um plano de LTI aumentado, com funções de ponderação
Ptf = tf(P)

%% Controlador sensibilidade mista
K = mixsyn(Gs, Wp, Wu, 1)
[K,CL, GAM] = hinfsyn(P, 1, 1)% Calcula um controlador sensibilidade mista para um sistema SISO

%% Funções: Sensibilidade S, Sensibilidade Complementar T, função L

Gs.outputdelay = 1.25% atraso da planta
looptransfer = loopsens(Gs,K)% Já realiza o fechamento da malha com controlador unitário
L = looptransfer.Li;% tira a função L
T = looptransfer.Ti;% tira a função sensibilidade complementar T 
S = looptransfer.Si;% tira a função sensibilidade

KG = K * Gs; % multiplicando o controlador com a planta 
KS = K * S;


%% Plotagens
%% Plotagens
figure (9)
bode(Gs,'k') ; hold on % bode da função T
grid
title('Bode da planta')

figure (1)
bode(KG,'k') ; hold on % bode da função T
bode(T,'g') ; hold on % bode da função T
grid
bode(S,'r') ; hold on % bode da função S
title('Bode da planta com o controlador(Kg)')

figure(2)
bode (KS, 'b') ; hold on
bode (K, 'k') ; hold on
bode (L, 'k') ; hold on
title('Bode de KS, K e L')
grid

figure(3)
step (T, S)
title('Step de T e S')
grid

figure(4)
nyquist (Gs, 'k')
title('Nyquist da planta')
grid

figure(5)
nyquist (KG, 'k')
title('Nyquist da planta multiplicando o controlador')
grid

figure(6)
step(KG)
title('Step da planta multiplicando o controlador')


%% Simulação
t_run = 500; t_step = 1; Amp_step =1; Ts = 0.5;
sim('simulink_controlehinf'); % chamando a simulação

figure(7)

plot(controle,'k');
hold on;
grid;
title('Resposta da familia de plantas de boost e esforço do controlador H-inf')
ylim ([- 0.1, 1.1]);
ylabel('Degrau');
xlabel('tempo');


plot(planta,'b');
plot(controle1,'k');
plot(planta1,'b');
plot(controle2,'k');
plot(planta2,'b');
plot(controle3,'k');
plot(planta3,'b');
plot(controle4,'k');
plot(planta4,'b');
plot(controle5,'k');
plot(planta5,'b');
plot(controle6,'k');
plot(planta6,'b');
plot(controle7,'k');
plot(planta7,'b');
plot(controle8,'k');
plot(planta8,'b');
plot(controle9,'k');
plot(planta9,'b');
plot(controle10,'k');
plot(planta10,'b');
plot(controle11,'k');
plot(planta11,'b');
plot(controle12,'k');
plot(planta12,'b');
plot(controle13,'k');
plot(planta13,'b');
plot(controle14,'k');
plot(planta14,'b');
plot(controle15,'k');
plot(planta15,'b');

legend('Esforço de controle (Preto)', 'Resposta da planta (Azul)');

figure(8)

plot(planta16,'b');
hold on
grid
plot(planta17,'b');
plot(planta18,'b');
plot(planta19,'b');
plot(planta20,'b');
plot(planta21,'b');
plot(planta22,'b');
plot(planta23,'b');
plot(planta24,'b');
plot(planta25,'b');
plot(planta26,'b');
plot(planta27,'b');
plot(planta28,'b');
plot(planta29,'b');
plot(planta30,'b');
plot(planta31,'b');
title('Resposta da familia de plantas malha aberta')


