%% TEST SCRIPT
clear all;
close all;
options = odeset('RelTol',1e-7,'AbsTol',1e-7);

%% Definition of initial state vector

% Random C0
%C0 = c_x(deg2rad(10))*c_y(deg2rad(5))*c_z(deg2rad(-10));
% C0 = [0.5 -0.8536 0.1464; 0.5 0.1464 -0.8536; 0.7071 0.5 0.5];
% q = [-0.5; 0.5; -0.5; 0.5];
% MRP = MRPfromQ(q);
% MRPs = ShadowfromMRP(MRP);

% Angular velocity error at t0
we0 = [0;0;0]; % [rad/s]
MRP0 = [0.252; 0; -0.092];
MRP0 = [0.414; 0.3; 0.2];
DVG0 = [250;0;0];

% Control Requirements
J    = diag([10 10 8]);
Iws  = diag([0.0042 0.0021 0.0021]);
ts   = 30;                      % [sec] settling time
zeta = 0.65;                    % damping coefficient
wn   = 4.4/zeta/ts;             % [rad/sec] natural frequency

% define kp and kd gains
kd = 2*zeta*wn*J;
kp = 2*J*wn^2;


%% INTEGRATION
x0 = [we0;MRP0;DVG0];
global det
det = [0;0];
[t, state] = ode45(@DGVSCMG, [0 200], x0, options, J, Iws, kp, kd);

%% PLOTTER
figure(1)
subplot(2,2,1)
plot(t,state(:,4),'linewidth',1.5)
title('MRP Error (MRP_e)');
hold on
grid on
plot(t,state(:,5),'linewidth',1.5)
plot(t,state(:,6),'linewidth',1.5);
ylabel('Magnitude');
xlabel('Time [sec]');

% subplot(2,2,2)
% plot(t,state(:,1),'linewidth',1.5)
% title('Angular Velocity Error (\omega_e)')
% hold on
% grid on
% plot(t,state(:,2),'linewidth',1.5)
% plot(t,state(:,3),'linewidth',1.5);
% xlabel('Time [sec]');
% ylabel('Angular Velocity [rad/s]');

subplot(2,2,3)
plot(t,180/pi*state(:,8),'linewidth',1.5)
hold on
grid on
plot(t,180/pi*state(:,9),'linewidth',1.5)
title('Gimbal Angles');
xlabel('Time [sec]');
legend('\delta_i','\delta_o');
ylabel('\delta_i_/_o [deg]');

%plot(t,state(:,9));

subplot(2,2,4)
plot(t,state(:,7),'linewidth',1.5)
grid on
xlabel('Time [sec]');
ylabel('\Omega [rad/s]');
title('Wheel Speed [rad/s]');

subplot(2,2,2)
plot(det(2,2:end),det(1,2:end),'linewidth',1.5)
title('determinant');
grid on
xlabel('Time [sec]');
ylabel('det(N)');

figure(2)
for i = 1:length(t)
    di = state(i,8);
    do = state(i,9);
    cyl(di,do)
    drawnow;
end
%% FUNCTIONS
function [MRP] = MRPfromQ(q)
q1 = [q(1);q(2);q(3)];
q4 = q(4);
MRP = q1/(1+sqrt(1 - q1'*q1));
end

function [MRPs] = ShadowfromMRP(MRP)
% phi = acos((trace(C)-1)/2);
% a1 = (C(2,3) - C(3,2))/2/sin(phi);
% a2 = (C(3,1) - C(1,3))/2/sin(phi);
% a3 = (C(1,2) - C(2,1))/2/sin(phi);
% 
% MRPs = tan((phi-2*pi)/4)*[a1;a2;a3];
MRPs = -MRP/(MRP'*MRP);
end

function [] = cyl(di,do)
c0 = c_y(pi/2);
% Define Cylinder
r = 0.2;
h = 0.2;
[X,Y,Z] = cylinder(r);
Z = h*Z-0.1;

% Define axes
ig0 = [0;1;0];
spin = -[1;0;0];
for i = 1:2
    for j = 1:length(X)
        vec = c_y(di)*c_z(do)*c0*[X(i,j);Y(i,j);Z(i,j)];
        X(i,j) = vec(1);
        Y(i,j) = vec(2);
        Z(i,j) = vec(3);
        ig = c_z(do)*ig0;
    end
end
spin = c_y(di)*c_z(do)*spin;
h = mesh(X,Y,Z,'facecolor',[1;0;0]);
axis([-0.5 0.5 -0.5 0.5 -0.25 0.25]);
hold on
quiver3(0,0,0,spin(1),spin(2),spin(3));
quiver3(0,0,0,ig(1),ig(2),ig(3));
quiver3(0,0,0,0,0,1);
view([-1;-1;1]);
hold off

end

