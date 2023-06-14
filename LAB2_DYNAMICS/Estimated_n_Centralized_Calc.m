function [n] = Estimated_n_Centralized_Calc()

[DH, M] = DaVinci_Man();
syms dq1 dq2 dq5 real
dq = [dq1 dq2 -dq2 dq2 dq5].';
% syms g positive
ddp0 = [0 9.81 0].';
S = [1 0 0 0 0 ; 0 1 -1 1 0 ; 0 0 0 0 1];

% velocity dynamics

phi = tau_NewtonEuler(DH, M, dq, zeros(5,1), zeros(3,1), zeros(3,1), zeros(3,1));
phi = S * phi;
phi = simplify(phi);
disp('phi is done')

% gravity dynamics

G = tau_NewtonEuler(DH, M, zeros(5,1), zeros(5,1), zeros(3,1), zeros(3,1), ddp0);
G = S * G;
G = simplify(G);
disp('G is done')

n = phi + G;
n = simplify(n);

end

