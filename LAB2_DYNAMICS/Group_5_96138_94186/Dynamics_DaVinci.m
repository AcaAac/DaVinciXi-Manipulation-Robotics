function [B, phi, G] = Dynamics_DaVinci()

[DH, M] = DaVinci_Man();
syms dq1 dq2 dq5 real
dq = [dq1 dq2 -dq2 dq2 dq5].';
syms ddq1 ddq2 ddq5 real;
ddq = [ddq1 ddq2 -ddq2 ddq2 ddq5].';
ddqb = [ddq1 ddq2 ddq5].';
w0 = zeros(3, 1);
dw0 = zeros(3, 1);
% syms g positive
ddp0 = [0 9.81 0].';
S = [1 0 0 0 0 ; 0 1 -1 1 0 ; 0 0 0 0 1];
B_max = zeros(3,1);
% acceleration dynamics

tau_a = tau_NewtonEuler(DH, M, zeros(5,1), ddq, w0, dw0, zeros(3,1));
B = jacobian(tau_a, ddqb);
B = S * B;
B = simplify( B );
disp('B is done')
B_max = Worst_Inertia(B);

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

end
