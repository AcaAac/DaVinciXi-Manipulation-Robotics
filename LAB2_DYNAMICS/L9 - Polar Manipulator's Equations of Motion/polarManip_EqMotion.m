[DH,M]=polar_DH();
syms dq1 dq2 ddq1 ddq2 real
syms g positive
dq=[dq1 dq2].';
ddq=[ddq1 ddq2].';
w0=[0;0;0]; dw0=[0;0;0]; ddp0=[0;g;0];
% tau_NewtonEuler(DH,M,dq,ddq,w0,dw0,ddp0)
%% acceleration dynamics
tau_a=tau_NewtonEuler(DH,M,zeros(2,1),ddq,zeros(3,1),dw0,subs(ddp0,g,0));
B=simplify( jacobian(tau_a,ddq) );
%% velocity dynamics
phi=tau_NewtonEuler(DH,M,dq,zeros(2,1),w0,zeros(3,1),zeros(3,1));
phi=simplify(phi);
%% gravity dynamics
G=tau_NewtonEuler(DH,M,zeros(2,1),zeros(2,1),zeros(3,1),zeros(3,1),ddp0-subs(ddp0,g,0));
G=simplify(G);