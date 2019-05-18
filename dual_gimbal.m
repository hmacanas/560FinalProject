function [Udgv] = dual_gimbal(N1s,N2,up,ue,W,B1,B2,mtq)
Udgv = N1s*up - W*ue - N1s*(B1^-1)*B2*N2*mtq;
end