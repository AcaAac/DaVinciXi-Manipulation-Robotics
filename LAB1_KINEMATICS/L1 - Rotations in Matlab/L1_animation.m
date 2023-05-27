% Setup Figure and Axes
fig1=figure;
view([35 10])
grid on
axis equal
xlim([0 1])
ylim([-1 1])
zlim([-1 1])

r2=[.5;.5;.5];  % components of r, expressed in frame 2

% draw frame 1
line([0 1],[0 0],[0 0],'Color','r','LineWidth',4);    % x1
line([0 0],[0 1],[0 0],'Color','g','LineWidth',4);    % y1
line([0 0],[0 0],[0 1],'Color','b','LineWidth',4);    % z1

% create line handles for frame 2, the vector r and the dashed lines
Lx2=line([0 1],[0 0],[0 0],'Color','r','LineWidth',4);    % x1
Ly2=line(0,0,0,'Color','g','LineWidth',4);    % y1
Lz2=line(0,0,0,'Color','b','LineWidth',4);    % z1
Lr1=line(0,0,0,'Color','k','LineWidth',4);
LdyZ=line(0,0,0,'Color','k','LineWidth',.1,'LineStyle','--');
LdyY=line(0,0,0,'Color','k','LineWidth',.1,'LineStyle','--');
LdzY=line(0,0,0,'Color','k','LineWidth',.1,'LineStyle','--');
LdzZ=line(0,0,0,'Color','k','LineWidth',.1,'LineStyle','--');

%%
phi=0;
while isvalid(fig1)         % close the figure to stop animation
    phi = phi + 1*pi/180;   % previous angle plus 1 degree
    
    x12=[1;0;0];    % components of x2, expressed in frame 1
    y12=[0;cos(phi);sin(phi)];
    z12=[0;-sin(phi);cos(phi)];
    R12=[x12, y12, z12];
    r1=R12*r2;      % components of r, expressed in frame 1
    
    % update line coordinates
    Ly2.XData=[0 y12(1)];
    Ly2.YData=[0 y12(2)];
    Ly2.ZData=[0 y12(3)];
    Lz2.XData=[0 z12(1)];
    Lz2.YData=[0 z12(2)];
    Lz2.ZData=[0 z12(3)];
    LdyZ.XData=[0 0];
    LdyZ.YData=[y12(2) y12(2)];
    LdyZ.ZData=[0 y12(3)];
    
    LdyY.XData=[0 0];
    LdyY.YData=[0 y12(2)];
    LdyY.ZData=[y12(3) y12(3)];
    
    LdzY.XData=[0 0];
    LdzY.YData=[z12(2) z12(2)];
    LdzY.ZData=[0 z12(3)];
    
    LdzZ.XData=[0 0];
    LdzZ.YData=[0 z12(2)];
    LdzZ.ZData=[z12(3) z12(3)];
    
    Lr1.XData=[0 r1(1)];
    Lr1.YData=[0 r1(2)];
    Lr1.ZData=[0 r1(3)];
    
    pause(1/60);            % 60 fps
end


