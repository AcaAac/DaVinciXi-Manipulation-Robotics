function [T,J] = DKin(Robot)
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

for i = 1:n
    if i == 1
        % Direct kinematics for first link
        T = DHTransf(Robot(i,:));
        % For a Prismatic Joint
        % if Robot(1,1) == 0
        if isequal(Robot(i),q(i)) % For Prismatic Joint
            J(1:3,1) = [T(1:3,3);]; % Extraction of z0 for prismatic joint 
        else % For a Revolut Joint
            J(:,1) = [cross(T(1:3,3),Pe-T(1:3,4));T(1:3,3)]; 
        end
    else
        % Direct kinematics for remaining links
        T = T * DHTransf(Robot(i,:));
        if isequal(Robot(i),q(i))
            J(:,i) = [T(1:3,3);[0 0 0]'];
        else
            J(:,i) = [cross(T(1:3,3),Pe-T(1:3,4));T(1:3,3)];
        end
    end
end

% Substitution
J = subs(J,Pe,T(1:3,4));

% Simplify
T = simplify(T);
J = simplify(J);

end