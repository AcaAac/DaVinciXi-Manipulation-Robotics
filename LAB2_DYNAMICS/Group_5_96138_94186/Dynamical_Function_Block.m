%% Generate Matlab and Simulink Code for DaVinci
%  Create Simulink Library file DaVinci_Lib.slx
new_system('DaVinci_LibDynamical','Library');
open_system('DaVinci_LibDynamical');

%% Dynamical Function Block

[B, phi, G] = Dynamics_DaVinci();

%Generate optimized embeded Matlab function blocks for Simulink
matlabFunctionBlock('DaVinci_LibDynamical/Dynamics_DaVinci', B, phi, G);

%% Save library in current Directory
save_system('DaVinci_LibDynamical');
close_system('DaVinci_LibDynamical');