clear all;
clc;
% rU(i - 1, j + 1) + (2 + 2r)U(i, j + 1) - rU(i + 1, j + 1) = rU(i - 1, j)
% + (2 - 2r)U(i, j) + rU(i + 1, j)
k = 1/16;
h = 1/4;
r = k/h^2;

x0 = 0;
xn = 1;
n = (xn - x0)/h;



