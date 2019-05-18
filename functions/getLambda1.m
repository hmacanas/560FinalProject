function [lambda1] = getLambda1(k1, k1Prime, N1)
    x = -k1Prime*abs(det(N1));
    lambda1 = k1*exp(x);
end

