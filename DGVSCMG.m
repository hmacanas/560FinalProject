function [xdot] = DGVSCMG(t,x,J,Iws)

% DECOMPOSE STATE VECTOR
% Spacecraft
we = [x(1);x(2);x(3)]; % [rad/s] angular velocity error
se = [x(4);x(5);x(6)]; % MRP Error

% CMG
Omega = x(7); % [rad/s] wheel speed
d_i   = x(8); % [rad] inner gimbal angle
d_o   = x(9); % [rad] outer gimbal angle



% CALCUATE COEFFICIENT MATRICES
rho = [Omega*cos(d_i)*cos(d_o); Omega*cos(d_i)*sin(d_o); Omega*sin(d_i)];  
M = -ax(rho);

% A Matrix
H = [(1 - se'*se)*eye(3) + 2*ax(se) + 2*(se*se')];
A = J^-1*Iws*M;
A = [A [0;0;0]; 0.25*H [0;0;0]];

% B Matrices
% Bbar1 = -J^-1*Iws;
% Bbar2 = J^-1*(mu/a^3);
% Be = [Bbar1;[0,0,0]];

% E Matrix

% Calculate Uprime


xdot = A*[we;se] + Be*uprime + E*w;
end