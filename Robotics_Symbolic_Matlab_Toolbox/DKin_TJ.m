function [T,J] = DKin_TJ(Robot)
% DKin Homogeneous Transformation Matrix for Robot Direct Kinematics and
% T=[R p; 0 1]

n = size(Robot,1);      %get number of robot joints
q = symvar(Robot);      %get names of robot coordinates

% Concatenate memory to create jacobian matrix, 6 lines and n number of
% joints
J = sym(zeros(6,n));

% Create symbolic coordinates of the
syms pex pey pez real
Pe = [pex pey pez]';

% Direct kinematics for first link
T = DHTransf(Robot(1,:));

if Robot(1,1) == 0 % For a Revolut Joint
    J(:,1) = [cross(T(1:3,3),Pe-T(1:3,4));T(1:3,3)];
else % For a Prismatic Joint
    J(1:3,1) = [T(1:3,3);];
end

% For the other Joints
for i=2:n
    % % Direct kinematics for remaining links
    % T = T * DHTransf(Robot(i,:));
    if isequal(Robot(i),q(i))
        J(:,i) = [T(1:3,3);[0 0 0]'];
        % Direct kinematics for first link
        T = T*DHTransf(Robot(i,:));
    else
        J(:,i) = [cross(T(1:3,3),Pe-T(1:3,4));T(1:3,3)];
        % Direct kinematics for first link
        T = T*DHTransf(Robot(i,:));
    end
end

% Substitution
J = subs(J,Pe,T(1:3,4));

% Simplify
T = simplify(T);
J = simplify(J);

end