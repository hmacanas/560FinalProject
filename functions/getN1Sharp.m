function [N1Sharp] = getN1Sharp(N1, lambda1, I)
    N1Sharp = inv(N1'*(N1*N1'+lambda1*I));
end

