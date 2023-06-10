function tau = tau_NewtonEuler_polar(DH, M, dq, ddq, w0, dw0, ddp0)

%funciona com qqlr manipuldor
% testar algoritmo do projeto com o apendice B

A01 = DHTransf(DH(1,:));
R01 = A01(1:3,1:3);
r0_01 = A01(1:3,4);
A12  = DHTransf(DH(2,:));
R12 = A12(1:3,1:3);
r1_12 = A12(1:3,4);
kk = [0 ; 0 ; 1];
% I = 1 (revolution)

w1=R01.'*(w0+dq(1) * kk);
dw1 = R01.' * (dw0 + ddq(1) * kk + dq(1) * cross(w0, kk));
ddp1 = R01.' * ddp0 + cross(dw1, R01.' * r0_01) + cross(w1, cross(dw1, R01.' * r0_01));
ddpc1 = ddp1 + cross(dw1, M.rc{1}) + cross(w1, cross(w1, M.rc{1}));

%i = 1 prismatic
w2 = R12.' * w1;
dw2 = R12.' * dw1;
ddp2 = R12.' * (ddp1 + ddq(2) * kk) + 2 * dq(2) * cross(w2, R12.' * kk) + ...
    cross(dw2, R12.' * r1_12) + cross(w2, cross(w2, R12.' * r1_12));
ddpc2 = ddp2 + cross(dw2, M.rc{2}) + cross(w2, cross(w2, M.rc{2}));

%i = 2 
f2 = M.m{2} * ddpc2;
m2 = M.I{2}* dw2 + cross(w2, M.I{2} * w2) + cross(R12.' * r1_12 + M.rc{2}, f2);
%i = 1
f1 = M.m{1} * ddpc1 + R12 * f2;
m1 = M.I{1} * dw1 + cross(w1, M.I{1} * w1) + R12 * m2 - cross(M.rc{1}, R12 * f2) + ...
    cross(R01.' * r0_01 + M.rc{1}, f1);

tau = sym(zeros(2,1));
tau(1) = kk.' * R01 * m1;
tau(2) = kk.' * R12 * m2;



