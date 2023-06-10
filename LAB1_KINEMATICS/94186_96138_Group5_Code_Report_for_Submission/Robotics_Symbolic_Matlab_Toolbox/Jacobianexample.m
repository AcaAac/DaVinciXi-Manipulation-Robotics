%% Generate Matlab and Simulink Code for DaVinci
%  Create Simulink Library file DaVinci_Lib.slx
new_system('DaVinci_LibJ','Library');
open_system('DaVinci_LibJ');

%% Direct Kinematics and Jacobian
[T,J] = DKin_TJ( DaVinciDH() );
R=T(1:3,1:3);
p=T(1:3,4);

%Generate optimized embeded Matlab function blocks for Simulink
matlabFunctionBlock('DaVinci_LibJ/DaVinci_Direct_Kinematics',R,p,J);

%% Save library in current Directory
save_system('DaVinci_LibJ');
close_system('DaVinci_LibJ');