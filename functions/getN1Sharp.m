function [N1Sharp] = getN1Sharp(N1, lambda1, I)
    N1Sharp = N1'*inv(N1*N1'+lambda1*I);
end

