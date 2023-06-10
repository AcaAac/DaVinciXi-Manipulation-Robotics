function [DH, M] = DaVinci_Man()

% Call Denavit Hartenberg Table
DH = DaVinciDH();
% Initialize symbolic variables for masses, inertia tensors and centers of
% mass
syms m1 m2 m3 m4 m5 ... 
    Ix1 Iy1 Iz1 Ix2 Iy2 Iz2 ...
    Ix3 Iy3 Iz3 Ix4 Iy4 Iz4 ... 
    Ix5 Iy5 Iz5 L1 L2 L3 L4_1 L4_2 L5_1 L5_2 real
% Creation of Structure M which holds masses, inertia tensors and centers
% of mass
M.m{1} = m1; M.m{2} = m2; M.m{3} = m3; M.m{4} = m4; M.m{5} = m5;
M.I{1} = diag([Ix1 Iy1 Iz1]);
M.I{2} = diag([Ix2 Iy2 Iz2]);
M.I{3} = diag([Ix3 Iy3 Iz3]);
M.I{4} = diag([Ix4 Iy4 Iz4]);
M.I{5} = diag([Ix5 Iy5 Iz5]);
M.rc{1} = [0;-L1;0]; M.rc{2} = [-L2;0;0]; M.rc{3} = [-L3;0;0]; 
M.rc{4} = [-L4_1;0;-L4_2]; M.rc{5} = [-L5_1;0;-L5_2];



end

