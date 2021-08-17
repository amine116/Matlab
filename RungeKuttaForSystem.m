f1 = @(t, y, z) -4*y + 3*z + 6;
f2 = @(t, y, z) -2.4*y + 1.6*z + 3.6;

exactY = @(t) -3.375*exp(-2*t) + 1.875*exp(-0.4*t) + 1.5;
exactZ = @(t) -2.2*exp(-2*t) + 2.25*exp(-0.4*t);

t(1) = 0;
y(1) = 0;
z(1) = 0;

exactYY(1) = exactY(t(1));
exactZZ(1) = exactZ(t(1));

h = 0.1;
left = 0;
right = 1;
n = (right - left)/h;

fprintf('  ti                 y(ti)                 z(ti)\n');
fprintf('------------------------------------------------------\n');
fprintf('%f             %f               %f\n', t(1), y(1), z(1));
for i = 2 : n + 1
    
    k11 = h*f1(t(i - 1), y(i - 1), z(i - 1));
    k12 = h*f2(t(i - 1), y(i - 1), z(i - 1));
    
    k21 = h*f1(t(i - 1) + h/2, y(i - 1) + k11/2, z(i - 1) + k12/2);
    k22 = h*f2(t(i - 1) + h/2, y(i - 1) + k11/2, z(i - 1) + k12/2);
    
    k31 = h*f1(t(i - 1) + h/2, y(i - 1) + k21/2, z(i - 1) + k22/2);
    k32 = h*f2(t(i - 1) + h/2, y(i - 1) + k21/2, z(i - 1) + k22/2);
    
    k41 = h*f1(t(i - 1) + h, y(i - 1) + k31, z(i - 1) + k32);
    k42 = h*f2(t(i - 1) + h, y(i - 1) + k31, z(i - 1) + k32);
    
    y(i) = y(i - 1) + (1/6)*(k11 + 2*k21 + 2*k31 + k41);
    z(i) = z(i - 1) + (1/6)*(k12 + 2*k22 + 2*k32 + k42);
    
    t(i) = t(i - 1) + h;
    
    exactYY(i) = exactY(t(i));
    exactZZ(i) = exactZ(t(i));
    
    fprintf('%f             %f               %f\n', t(i), y(i), z(i));
    
end
plot(t, y, 'b*-')
hold on
plot(t, z, 'ro-')
hold on
plot(t, exactYY, 'ro-')
hold on 
plot(t, exactZZ, 'b*-');
legend('Y', 'Z');