function [B_max] = Worst_Inertia(B)

syms q1 q2 q5 real;
B_max = zeros(3,1);
q21_max = vpasolve(diff(simplify(subs(B(1,1), [q2, q5], [q2, 0.5])), q2));
% After Graphical Analysis
%q21_max = 2.7;
B_max(1,1) = double(subs(B(1,1), [q2, q5], [q21_max, 0.5]));
B_max(2,1) = double(subs(B(2,2), q5, 0.5));
B_max(3,1) = B(3,3);

end

