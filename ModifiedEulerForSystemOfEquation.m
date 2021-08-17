clear all;
clc;
f1 = @(t, y, z) -4*y + 3*z + 6;
f2 = @(t, y, z) -2.4*y + 1.6*z + 3.6;
%f1 = @(t, y, z) z
%f2 = @(t, y, z) -.5*y + 2.5*z + 10*t;

exactY = @(t) -3.375*exp(-2*t) + 1.875*exp(-0.4*t) + 1.5;
exactZ = @(t) -2.2*exp(-2*t) + 2.25*exp(-0.4*t);

t(1) = 0;
y(1) = 0;
z(1) = 0;

left = 0;
right = 1;

exactYY(1) = exactY(t(1));
exactZZ(1) = exactZ(t(1));

h = 0.1;
n = (right - left)/h;

fprintf('  ti                 y(ti)                 exactY(ti)                 z(ti)                 exactZ(ti)\n');
fprintf('------------------------------------------------------------------------------------------------------------\n');
fprintf('%f             %f               %f                %f                 %f\n', t(1), y(1), z(1), exactYY(1), exactZZ(1));
for i = 2 : n + 1
    yy = f1(t(i - 1) + h, y(i - 1) + h*f1(t(i - 1), y(i - 1), z( i - 1)), z(i - 1) + h*f1(t(i - 1), y(i - 1), z(i - 1)));
    y(i) = y(i - 1) + (h/2)*(f1(t(i - 1), y(i - 1), z(i - 1)) + yy);
    
    zz = f2(t(i - 1) + h, y(i - 1) + h*f2(t(i - 1), y(i - 1), z( i - 1)), z(i - 1) + h*f2(t(i - 1), y(i - 1), z(i - 1)));
    z(i) = z(i - 1) + (h/2)*(f2(t(i - 1), y(i - 1), z(i - 1)) + zz);
    
    
    t(i) = t(i - 1) + h;
    
    exactYY(i) = exactY(t(i));
    exactZZ(i) = exactZ(t(i));
    
    fprintf('%f             %f               %f                %f                 %f\n', t(i), y(i), z(i), exactYY(i), exactZZ(i));
    
end
plot(t, y, 'b*-')
hold on
plot(t, z, 'ro-')

hold on
plot(t, exactYY, 'b.-');

hold on
plot(t, exactZZ, 'r.-');

legend('Approximate Y', 'Approximate Z', 'Exact Y', 'Exact Z');