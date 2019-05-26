addpath('functions')
% constants ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gammaInner = 0;
gammaInnerDesired = 0;
gammaOutter = 0;

capOmega = 250;
capOmegaDesired = 300;

k2 = .01;
b1 = 1;
b2 = .1;

J  = diag([10 10 8]);
Iws = diag([.0042 .0021 .0021]);

mu = 7.9*1e15;

t = 0;
n = .001;
inc = deg2rad(53);
a = 7359.42;

N2 = getN2(t, inc, n);
  
N2Sharp = getN2Sharp(N2, k2, J);

B2Bar = getB2Bar(J, mu/(1e3), a);

B1Bar = getB1Bar(J, Iws);

N1 = getN1(gammaInner, gammaOutter, capOmega);

WBar = [b1 0 0; 0 b2 0; 0 0 0];

ue = [capOmega - capOmegaDesired;
      gammaInner - gammaInnerDesired;
      0];

MTQ = getMTQ(N2Sharp, B2Bar, B1Bar, N1, WBar, ue)
