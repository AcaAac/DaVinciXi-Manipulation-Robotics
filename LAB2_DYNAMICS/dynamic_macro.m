[DH, M] = polar_man();
syms dq1 ddq1 dq2 ddq2 real
dq = [dq1 dq2];
ddq = [ddq1 ddq2];
w0 = zeros(3, 1);
dw0 = zeros(3, 1);
syms g positive
ddp0 = [0 g 0];

tau_a = tau_NewtonEuler_polar(DH, M, zeros(2,1), ddq, zeros(3, 1), dw0, zeros(3, 1));
