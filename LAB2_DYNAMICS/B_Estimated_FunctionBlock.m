%% Generate Matlab and Simulink Code for DaVinci
%  Create Simulink Library file DaVinci_Lib.slx
new_system('B_estimatedLib','Library');
open_system('B_estimatedLib');

%% Dynamical Function Block

[B] = Estimated_B_Centralized_Calc();

%Generate optimized embeded Matlab function blocks for Simulink
matlabFunctionBlock('B_estimatedLib/Estimated_B_Centralized_Calc', B);

%% Save library in current Directory
save_system('B_estimatedLib');
close_system('B_estimatedLib');