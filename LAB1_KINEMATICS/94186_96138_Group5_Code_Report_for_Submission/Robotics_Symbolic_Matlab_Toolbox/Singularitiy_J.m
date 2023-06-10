determinant = det(J);
determinant = simplify(determinant);
[q_solution] = solve(determinant, 0);
q_solution;