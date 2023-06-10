%% INIT
[DH, M] = DaVinci_Man();
syms dq1 ddq1 dq2 ddq2 dq3 ddq3 dq4 ddq4 dq5 ddq5 real
dq = [dq1 dq2 dq3 dq4 dq5].';
ddq = [ddq1 ddq2 ddq3 ddq4 ddq5].';
w0 = zeros(3, 1);
dw0 = zeros(3, 1);
syms g positive
ddp0 = [0 g 0].';
%% acceleration dynamics

tau_a = tau_NewtonEuler(DH, M, dq, ddq, w0, dw0, subs(ddp0,g,0));
B = simplify( jacobian(tau_a, ddq) );


%% velocity dynamics

phi = tau_NewtonEuler(DH, M, dq, zeros(2,1), w0, zeros(3,1), zeros(3,1));
phi = simplify(phi);


%% gravity dynamics

G = tau_NewtonEuler(DH, M, zeros(2,1), zeros(2,1), zeros(3,1), zeros(3,1), ddp0-subs(ddp0,g,0));
G = simplify(G);
