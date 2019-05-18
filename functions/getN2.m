function [N2] = getN2(t, inc, n)
        
    col1 = [0; 
            2*sin(inc)*sin(n*t);
            cos(inc)];
        
    col2 = [-2*sin(inc)*sin(n*t);
            0; 
            sin(inc)*cos(n*t)];
        
    col3 = [-cos(inc);
            -sin(inc)*cos(n*t);
            0];
        
    N2 = [col1 col2 col3];
end

