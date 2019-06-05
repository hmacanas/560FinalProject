function [UDGV] = getUDGV(N1Sharp, uPrime, WBar, ue, B1Bar, B2Bar, N2, MTQ)
    term1 = N1Sharp*uPrime;
    term2 = WBar*ue;
    term3 = N1Sharp*B1Bar^-1*B2Bar*N2*MTQ;
    UDGV = term1 - term2 -term3;
end

