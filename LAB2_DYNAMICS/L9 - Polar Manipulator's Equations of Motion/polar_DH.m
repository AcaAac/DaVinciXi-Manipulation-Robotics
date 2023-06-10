function [DH,M] = polar_DH()

syms q1 q2 real
syms m1 m2 Ix1 Iy1 Iz1 Ix2 Iy2 Iz2 L1 L2 real

DH    = [  0   q1   0   pi/2    0  ;
          q2   0    0   0       0  ];

M.m{1}=m1; M.m{2}=m2;
M.I{1}=diag([ Ix1 Iy1 Iz1 ]); 
M.I{2}=diag([ Ix2 Iy2 Iz2 ]);
M.rc{1}=[0;0;L1]; M.rc{2}=[0;0;-L2];

end

