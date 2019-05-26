function [MTQ] = getMTQ(N2Sharp, B2Bar, B1Bar, N1, WBar, ue)
    MTQ = -N2Sharp*inv(B2Bar)*B1Bar*N1*WBar*ue;
end

