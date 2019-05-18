function [N2Sharp] = getN2Sharp(N2, k2, I)
    N2Sharp = inv(N2'*(N2*N2'+k2*I));
end

