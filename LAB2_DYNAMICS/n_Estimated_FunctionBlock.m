%% Generate Matlab and Simulink Code for DaVinci
%  Create Simulink Library file DaVinci_Lib.slx
new_system('n_estimatedLib','Library');
open_system('n_estimatedLib');

%% Dynamical Function Block

[n] = Estimated_n_Centralized_Calc();

%Generate optimized embeded Matlab function blocks for Simulink
matlabFunctionBlock('n_estimatedLib/Estimated_B_Centralized_Calc', n);

%% Save library in current Directory
save_system('n_estimatedLib');
close_system('n_estimatedLib');