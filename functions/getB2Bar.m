function [B2Bar] = getB2Bar(J, mu, a)
    B2Bar = inv(J)*(mu/a^3);
end

