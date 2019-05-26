function [A] = ax(a)
% INPUT: Vector a in cross product a x b
% OUTPUT: Matrix a_cross, multiply by b to take cross product
A = [0   -a(3) a(2);
     a(3) 0   -a(1);
    -a(2) a(1) 0   ];
end

