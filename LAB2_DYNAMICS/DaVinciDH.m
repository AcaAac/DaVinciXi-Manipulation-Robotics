function Robot = DaVinciDH()
%   Returns D-H table of parameters for Robotic Arm
%   Robot=[d v a alpha offset;
%          d v a alpha offset;
%          . . .   .   offset;
%          d v a alpha offset];
%   Use symbolic variables for each joint coordinate of the robot: in the d
%   column for a prismatic joint and in the v column for a rotational
%   joint. Name the variables from q1 to qn. In the last column, insert the
%   coordinate offset for the manipulator Home position.
syms q1 q2 q5 real
sigma = (4*pi) / 180;
gamma = (24 * pi) / 180;
b = 0.25;
e = 0.30;
Robot = [-e * cos(sigma),  q1 , e * sin(sigma) , pi/2 , pi;
          0             ,  q2 , b              , 0    , pi + gamma;
          0             , -q2 , e              , 0    , -gamma + sigma - pi/2;
          0             ,  q2 , b * sin(gamma) , pi/2 , -sigma;
          q5            ,  0  , 0              , 0    , b * cos(gamma)];
% Robot = subs(Robot, q3, -q2);
% Robot = subs(Robot, q4, q2);
end

