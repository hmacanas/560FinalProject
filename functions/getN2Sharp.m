function [N2Sharp] = getN2Sharp(N2, k2, I)
    N2Sharp = N2'*inv((N2*N2'+k2*I));
end

