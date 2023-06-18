p=out.simout.Data;
figure;
x = p(:, :, 1);
y = p(:, :, 2);
z = p(:, :, 3);
plot3(x, y, z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Trajectory');
grid on;
view(45, 30); % Adjust the viewpoint as desired

