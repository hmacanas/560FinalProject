function [xdot] = DGVSCMG(t,x,J,Iws,kp,kd)
% DECOMPOSE STATE VECTOR
mu = 7.9E12;
a = 7359.42;
inc = deg2rad(53);
n = 0.001;

% Spacecraft
we = [x(1);x(2);x(3)]; % [rad/s] angular velocity error
se = [x(4);x(5);x(6)]; % MRP Error
state = [we;se];
% CMG
Omega = x(7); % [rad/s] wheel speed
d_i   = x(8); % [rad] inner gimbal angle
d_o   = x(9); % [rad] outer gimbal angle


%% CALCULATIONS
% Calculate Uprime
uPrime = -[kd zeros(3); zeros(3) kp]*state;
% Calculate ue
ue = [Omega-300; d_i; 0];

% CALCUATE COEFFICIENT MATRICES
rho = [Omega*cos(d_i)*cos(d_o); Omega*cos(d_i)*sin(d_o); Omega*sin(d_i)];  
M = -ax(rho);

% A Matrix
H = [(1 - se'*se)*eye(3) + 2*ax(se) + 2*(se*se')];
A = J^-1*Iws*M;
A = [A zeros(3); 0.25*H zeros(3)];

% B Matrices
[B1Bar] = getB1Bar(J, Iws);
[B2Bar] = getB2Bar(J, mu, a);
Be = [B1Bar;zeros(3)];

% E Matrix

% Calculate N Matrices
[N1] = getN1(d_i, d_o, Omega);
[N2] = getN2(t, inc, n);

% Calculate N# matrices
k1 = 10;
k1Prime = 0.001;
k2 = 0.01;
[lambda1] = getLambda1(k1, k1Prime, N1);
[N1Sharp] = getN1Sharp(N1, lambda1, eye(3));
[N2Sharp] = getN2Sharp(N2, k2, eye(3));

% Calculate MTQ and UDGV
b1 = 1;
b2 = 0.1;
WBar = [b1 0 0; 0 b2 0; 0 0 0];
[MTQ] = getMTQ(N2Sharp, B2Bar, B1Bar, N1, WBar, ue);
[UDGV] = getUDGV(N1Sharp, uPrime, WBar, ue, B1Bar, B2Bar, N2, MTQ);


xdot = A*[we;se] + Be*uPrime;

xdot = [xdot;UDGV];
end