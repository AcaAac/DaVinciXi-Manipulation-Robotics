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

syms q1 q2 q3 real
sigma = (4*pi) / 180;
gamma = (24 * pi) / 180;
b = 0.25;
e = 0.30;
Robot = [ -e * cos(sigma)  ,  q1 + pi ,  e * sin(sigma)  ,   pi/2;
          0  ,  q2 + pi + gamma ,  b  ,  0;
          0  , -q2 - gamma + sigma - pi/2  ,  e , 0;
          0  ,  (q2 - sigma),  b * sin(sigma) ,    pi/2;
          q3 + b * cos(gamma)  ,  0 , 0 , 0;];

end

