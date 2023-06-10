function tau = tau_NewtonEuler(DH,M,dq,ddq,w0,dw0,ddp0)

kk=[0;0;1];
A01=DHTransf(DH(1,:)); R01=A01(1:3,1:3); r0_01=A01(1:3,4);
A12=DHTransf(DH(2,:)); R12=A12(1:3,1:3); r1_12=A12(1:3,4);

% i = 1  (revolute)
w1=R01.'*(w0+dq(1)*kk);
dw1=R01.'*( dw0+ddq(1)*kk+dq(1)*cross( w0,kk ) );
ddp1=R01.'*ddp0+cross( dw1, R01.'*r0_01 )+cross( w1, cross( w1,R01.'*r0_01 ) );
% i = 2  (prismatic)
w2=R12.'*w1;
dw2=R12.'*dw1;
ddp2=R12.'*(ddp1+ddq(2)*kk)+2*dq(2)*cross(w2,R12.'*kk)+...
    cross(dw2,R12.'*r1_12)+cross( w2,cross( w2, R12.'*r1_12) );

% mass center's acceleration
ddpc1=ddp1+cross(dw1,M.rc{1})+cross(w1,cross(w1,M.rc{1}));
ddpc2=ddp2+cross(dw2,M.rc{2})+cross(w2,cross(w2,M.rc{2}));

% i = 2
f2=M.m{2}*ddpc2;
mu2=M.I{2}*dw2+cross(w2,M.I{2}*w2)+...
    cross(R12.'*r1_12+M.rc{2},f2);
% i = 1
f1=M.m{1}*ddpc1+R12*f2;
mu1=M.I{1}*dw1+cross(w1,M.I{1}*w1)+...
    R12*mu2-cross(M.rc{1},R12*f2)+...
    cross(R01.'*r0_01+M.rc{1},f1);

% generalized force projection
tau=sym(zeros(2,1));
tau(1)=kk.'*R01*mu1;    % revolute
tau(2)=kk.'*R12*f2;     % prismatic

end