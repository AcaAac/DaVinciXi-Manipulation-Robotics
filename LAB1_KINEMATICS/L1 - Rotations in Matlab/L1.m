% Setup Figure and Axes
figure
view([60 30])
grid on
axis equal
xlim([0 1])
ylim([-1 1])
zlim([-1 1])

% draw frame 1 (aligned with the standard basis)
line([0 1],[0 0],[0 0],'Color','r','LineWidth',4);    % x1
line([0 0],[0 1],[0 0],'Color','g','LineWidth',4);    % y1
line([0 0],[0 0],[0 1],'Color','b','LineWidth',4);    % z1

phi=15/180*pi;  % angle phi in degrees

x12=[1;0;0];                % components of x2, expressed in frame 1
y12=[0;cos(phi);sin(phi)];  % components of y2, expressed in frame 1
z12=[0;-sin(phi);cos(phi)]; % components of z2, expressed in frame 1

% draw frame 2
line([0 x12(1)],[0 x12(2)],[0 x12(3)],'Color','r','LineWidth',4);    % x2
line([0 y12(1)],[0 y12(2)],[0 y12(3)],'Color','g','LineWidth',4);    % y2
line([0 z12(1)],[0 z12(2)],[0 z12(3)],'Color','b','LineWidth',4);    % z2

% dashed lines
line([0 0],[y12(2) y12(2)],[0 y12(3)],'Color','k','LineWidth',.1,'LineStyle','--');
line([0 0],[0 y12(2)],[y12(3) y12(3)],'Color','k','LineWidth',.1,'LineStyle','--');
line([0 0],[z12(2) z12(2)],[0 z12(3)],'Color','k','LineWidth',.1,'LineStyle','--');
line([0 0],[0 z12(2)],[z12(3) z12(3)],'Color','k','LineWidth',.1,'LineStyle','--');

r2=[.5;.5;.5];          % components of r, expressed in frame 2

R12=[x12, y12, z12];    % rotation matrix, changing the coordinates from frame 2 into frame 1
r1=R12*r2;              % components of r, expressed in frame 1

% draw vector r
line([0 r1(1)],[0 r1(2)],[0 r1(3)],'Color','k','LineWidth',4);

