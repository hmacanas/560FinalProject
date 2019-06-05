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
we0 = [0.1;0.1;0.1]; % [rad/s]
MRP0 = [0.414; 0.3; 0.2];
DVG0 = [250;0;0];

% Control Requirements
J = diag([10 10 8]);
Iws = diag([0.0042 0.0021 0.0021]);
ts = 30;                      % [sec] settling time
zeta = 0.65;                  % damping coefficient
wn = 4.4/zeta/ts;             % [rad/sec] natural frequency

% define kp and kd gains
kd = 2*zeta*wn*J;
kp = 2*J*wn^2;


%% INTEGRATION
x0 = [we0;MRP0;DVG0];

[t, state] = ode45(@DGVSCMG, [0 200], x0, options, J, Iws, kp, kd);


%% SIMPLE INTEGRATION
% se = MRP0;
% H = [(1 - se'*se)*eye(3) + 2*ax(se) + 2*(se*se')];
% zeta0 = H^-1*(se);
% x0 = [we0;zeta0;DVG0];
% [t, state] = ode45(@DGVSCMG_simple, [0 300], x0, options, J, Iws, kp, kd);

%% PLOTTER
figure(1)
plot(t,state(:,4))
title('MRP_e');
hold on
grid on
plot(t,state(:,5))
plot(t,state(:,6));

figure(2)
plot(t,state(:,1))
title('W_e')
hold on
grid on
plot(t,state(:,2))
plot(t,state(:,3));

figure(3)
plot(t,state(:,8))
hold on
grid on
plot(t,state(:,9))
%plot(t,state(:,9));

figure(4)
plot(t,state(:,7))
grid on
title('Wheel Speed [rad/s]');
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