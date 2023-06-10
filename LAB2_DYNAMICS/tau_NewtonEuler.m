function tau = tau_NewtonEuler(DH, M, dq, ddq, w0, dw0, ddp0)


% Joint 1 - Revolute
A01 = DHTransf(DH(1,:));
R01 = A01(1:3,1:3);
r0_01 = A01(1:3,4);
% Joint 2 - Revolute
A12  = DHTransf(DH(2,:));
R12 = A12(1:3,1:3);
r1_12 = A12(1:3,4);
% Joint 3 - Revolute
A23 = DHTransf(DH(3,:));
R23 = A23(1:3,1:3);
r2_23 = A23(1:3,4);
% Joint 4 - Revolute
A34 = DHTransf(DH(4,:));
R34 = A34(1:3,1:3);
r3_34 = A34(1:3,4);
% Joint 5 - Prismatic
A45 = DHTransf(DH(5,:));
R45 = A45(1:3,1:3);
r4_45 = A45(1:3,4);
% z-axis
kk = [0 ; 0 ; 1];

% Forward Recursion for Joint 1
w1 = R01.'*(w0 + dq(1) * kk);
dw1 = R01.' * (dw0 + ddq(1) * kk + dq(1) * cross(w0, kk));
ddp1 = R01.' * ddp0 + cross(dw1, R01.' * r0_01) + cross(w1, cross(dw1, R01.' * r0_01));
ddpc1 = ddp1 + cross(dw1, M.rc{1}) + cross(w1, cross(w1, M.rc{1}));

% Forward Recursion for Joint 2
w2 = R12.'*(w1 + dq(2) * kk);
dw2 = R12.' * (dw1 + ddq(2) * kk + dq(2) * cross(w1, kk));
ddp2 = R12.' * ddp1 + cross(dw2, R12.' * r1_12) + cross(w2, cross(dw2, R12.' * r1_12));
ddpc2 = ddp2 + cross(dw2, M.rc{2}) + cross(w2, cross(w2, M.rc{2}));


% Forward Recursion for Joint 3
w3 = R23.' * (w2 + dq(3) * kk);
dw3 = R23.' * (dw2 + ddq(3) * kk + dq(3) * cross(w2, kk));
ddp3 = R23.' * ddp2 + cross(dw3, R23.' * r2_23) + cross(w3, cross(dw3, R23.' * r2_23));
ddpc3 = ddp3 + cross(dw3, M.rc{3}) + cross(w3, cross(w3, M.rc{3}));

% Forward Recursion for Joint 4
w4 = R34.' * (w3 + dq(4) * kk);
dw4 = R34.' * (dw3 + ddq(4) * kk + dq(4) * cross(w3, kk));
ddp4 = R34.' * ddp3 + cross(dw4, R34.' * r3_34) + cross(w4, cross(dw4, R34.' * r3_34));
ddpc4 = ddp4 + cross(dw4, M.rc{4}) + cross(w4, cross(w4, M.rc{4}));

% Forward Recursion for Joint 5
w5 = R45.' * w4;
dw5 = R45.' * dw4;
ddp5 = R45.' * (ddp4 + ddq(5) * kk) + 2 * dq(5) * cross(w5, R45.' * kk) + ...
    cross(dw5, R45.' * r4_45) + cross(w5, cross(w5, R45.' * r4_45));
ddpc5 = ddp5 + cross(dw5, M.rc{5}) + cross(w5, cross(w5, M.rc{5}));

% Backward Recursion for Joint 5
f5 = M.m{5} * ddpc5;
mu5 = M.I{5}* dw5 + cross(w5, M.I{5} * w5) + cross(R45.' * r4_45 + M.rc{5}, f5);

% Backward Recursion for Joint 4
f4 = M.m{4} * ddpc4 + R45 * f5;
mu4 = M.I{4} * dw4 + cross(w4, M.I{4} * w4) + R45 * mu5 - cross(M.rc{4}, R45 * f5) + ...
    cross(R34.' * r3_34 + M.rc{4}, f4);

% Backward Recursion for Joint 3
f3 = M.m{3} * ddpc3 + R34 * f4;
mu3 = M.I{3} * dw3 + cross(w3, M.I{3} * w3) + R34 * mu4 - cross(M.rc{3}, R34 * f4) + ...
    cross(R23.' * r2_23 + M.rc{3}, f3);

% Backward Recursion for Joint 2
f2 = M.m{2} * ddpc2 + R23 * f3;
mu2 = M.I{2} * dw2 + cross(w2, M.I{2} * w2) + R23 * mu3 - cross(M.rc{2}, R23 * f3) + ...
    cross(R12.' * r1_12 + M.rc{2}, f2);

% Backward Recursion for Joint 1
f1 = M.m{1} * ddpc1 + R12 * f2;
mu1 = M.I{1} * dw1 + cross(w1, M.I{1} * w1) + R12 * mu2 - cross(M.rc{1}, R12 * f2) + ...
    cross(R01.' * r0_01 + M.rc{1}, f1);

tau = sym(zeros(5,1));
% Joint 1 Revolute
tau(1) = kk.' * R01 * mu1;
% Joint 2 Revolute 
tau(2) = kk.' * R12 * mu2;
% Joint 3 Revolute
tau(3) = kk.' * R23 * mu3;
% Joint 4 Revolute
tau(4) = kk.' * R34 * mu4;
% Joint 5 Prismatic
tau(5) = kk.' * R45 * f5;

% % Substitution for Inertia Tensors as Defined A Priori
% r = 0.1;
% h = 0.1;
% M.m{1} = 3;
% M.m{2} = 4;
% Inertia_1 = [-1/12 * M.m{1} * (3 * r^2 + h^2) , 0 , 0;
%              0 , 1/2 * M.m{1} * r^2 , 0 ;
%              0 , 0 , 1/12 * M.m{1} * (3 * r^2 + h^2)];
% subs(M.I{1}, Inertia_1);
% 
% Inertia_2 = [1/2 * M.m{2} * r^2 , 0 , 0;
%              0 , 1/12 * M.m{2} * (3 * r^2 + h^2) , 0 ;
%              0 , 0 , 1/12 * M.m{2} * (3 * r^2 + h^2)];
% subs(M.I{2}, Inertia_2);



end

