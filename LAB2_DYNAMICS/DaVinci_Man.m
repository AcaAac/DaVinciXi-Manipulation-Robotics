function [DH, M] = DaVinci_Man()

% Call Denavit Hartenberg Table
DH = DaVinciDH();

% Inertia Tensor Solo Variables
r = 0.1;
h = 0.2;
w = 0.1;
d = 0.2;
h_1 = 0.1;
% Creation of Structure M which holds masses, inertia tensors and 
% centers of mass
% MASSES
M.m{1} = 3; M.m{2} = 1.5; M.m{3} = 1.5; M.m{4} = 1; M.m{5} = 3;

% INERTIA TENSORS
M.I{1} = diag([-1/12 * M.m{1} * (3 * r^2 + h^2), ...
    1/2 * M.m{1} * r^2, 1/12 * M.m{1} * (3 * r^2 + h^2)]);
M.I{2} = diag([1/2 * M.m{2} * r^2, 1/12 * M.m{2} * (3 * r^2 + h^2), ...
    1/12 * M.m{2} * (3 * r^2 + h^2)]);
M.I{3} = diag([1/2 * M.m{3} * r^2, 1/12 * M.m{3} * (3 * r^2 + h^2), ...
    1/12 * M.m{3} * (3 * r^2 + h^2)]);
M.I{4} = diag([1/12 * M.m{4} * (3 * r^2 + h^2), 1/12 * M.m{4} * (3 * r^2 + h^2), ...
    1/2 * M.m{4} * r^2]);
M.I{5} = diag([1/12 * M.m{5} * ((h_1)^2 + d^2), 1/12 * M.m{5} * (w^2 + d^2), ...
    1/12 * M.m{5} * (w^2 + (h_1)^2)]);

% CENTERS OF MASS
M.rc{1} = [0;-0.2;0]; M.rc{2} = [-0.125;0;0]; M.rc{3} = [-0.15;0;0]; 
M.rc{4} = [-0.05;0;-0.05]; M.rc{5} = [-0.03;0;-0.5];



end

