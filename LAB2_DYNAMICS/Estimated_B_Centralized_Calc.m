function [B] = Estimated_B_Centralized_Calc()

[DH, M] = DaVinci_Man();
syms ddq1 ddq2 ddq5 real;
ddq = [ddq1 ddq2 -ddq2 ddq2 ddq5].';
ddqb = [ddq1 ddq2 ddq5].';
w0 = zeros(3, 1);
dw0 = zeros(3, 1);
S = [1 0 0 0 0 ; 0 1 -1 1 0 ; 0 0 0 0 1];
% acceleration dynamics

tau_a = tau_NewtonEuler(DH, M, zeros(5,1), ddq, w0, dw0, zeros(3,1));
B = jacobian(tau_a, ddqb);
B = S * B;
B = simplify( B );
disp('B is done')
end
