function Robot = RobotX()
%   Returns D-H table of parameters for Robotic Arm
%   Robot=[d v a alpha offset;
%          d v a alpha offset;
%          . . .   .   offset;
%          d v a alpha offset];
%   Use symbolic variables for each joint coordinate of the robot: in the d
%   column for a prismatic joint and in the v column for a rotational
%   joint. Name the variables from q1 to qn. In the last column, insert the
%   coordinate offset for the manipulator Home position.

syms q1 q2 q3 real
Robot = [ 0    q1   0      pi/2   0;
          0    q2  .5      pi/2   pi/2;
          q3   0    0      0     .5];
% first row is in respect to first reference frame, second row second
% reference frame etc etc
% last column is paramters for refrence for first joint, second joint,
% third joint, ie 0 is for first joint, pi/2 is for second joint, 0.5 is
% for third joint
% q1 = v1,  q2 = v2, q3 = d3
% go until q6 which means 6 DoF

end