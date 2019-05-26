function [B1Bar] = getB1Bar(J, Iws)
    B1Bar = -inv(J)*Iws;
end

