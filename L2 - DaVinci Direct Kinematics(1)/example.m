%% Generate Matlab and Simulink Code for DaVinci
%  Create Simulink Library file DaVinci_Lib.slx
new_system('DaVinci_Lib','Library');
open_system('DaVinci_Lib');

%% Direct Kinematics and Jacobian
T=DKin( DaVinciDH() );
R=T(1:3,1:3);
p=T(1:3,4);

%Generate optimized embeded Matlab function blocks for Simulink
matlabFunctionBlock('DaVinci_Lib/DaVinci_Direct_Kinematics',R,p);

%% Save library in current Directory
save_system('DaVinci_Lib');
close_system('DaVinci_Lib');
