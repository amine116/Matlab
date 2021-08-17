clear all;
clc;

% Functions
f1 = @(x, y, z) z;
f2 = @(x, y, z) -(pi*pi)*y; 

% Conditions
a = input('X0: ');
y0 = input('Y0: ');
b = input('Xn: ');
yn = input('Yn: ');
h = 0.01;
n = (b - a)/h;

x(1) = a;
for i = 2:n
   x(i) = x(i - 1) + h;
end

% Linear shooting method
M = [0 0 0];

M(1) = input('M1: ');
M(2) = input('M2: ');

B = [0 0];

for i = 1:2
    y(1) = y0;
    z(1) = M(i);
    
    for j = 1:n
       
        k11 = h*f1(x(j), y(j), z(j));
        k12 = h*f2(x(j), y(j), z(j));
        
        k21 = h*f1(x(j) + h/2, y(j) + k11/2, z(j) + k12/2);
        k22 = h*f2(x(j) + h/2, y(j) + k11/2, z(j) + k12/2);
        
        k31 = h*f1(x(j) + h/2, y(j) + k21/2, z(j) + k22/2);
        k32 = h*f2(x(j) + h/2, y(j) + k21/2, z(j) + k22/2);
        
        k41 = h*f1(x(j) + h, y(j) + k31, z(j) + k32);
        k42 = h*f2(x(j) + h, y(j) + k31, z(j) + k32);
        
        y(j + 1) = y(j) + (1/6)*(k11 + 2*(k21 + k31) + k41);
        z(j + 1) = z(j) + (1/6)*(k12 + 2*(k22 + k32) + k42);
        
    end
    
    B(i) = y(n + 1);
    
end


M(3) = M(2) - ((B(2) - yn)/(B(2) - B(1)))*(M(2) - M(1));
M

y(1) = y0;
z(1) = M(3);
    
for j = 1:n
       
    k11 = h*f1(x(j), y(j), z(j));
    k12 = h*f2(x(j), y(j), z(j));
        
    k21 = h*f1(x(j) + h/2, y(j) + k11/2, z(j) + k12/2);
    k22 = h*f2(x(j) + h/2, y(j) + k11/2, z(j) + k12/2);
        
    k31 = h*f1(x(j) + h/2, y(j) + k21/2, z(j) + k22/2);
    k32 = h*f2(x(j) + h/2, y(j) + k21/2, z(j) + k22/2);
        
    k41 = h*f1(x(j) + h, y(j) + k31, z(j) + k32);
    k42 = h*f2(x(j) + h, y(j) + k31, z(j) + k32);
        
    y(j + 1) = y(j) + (1/6)*(k11 + 2*(k21 + k31) + k41);
    z(j + 1) = z(j) + (1/6)*(k12 + 2*(k22 + k32) + k42);
        
end
x(n + 1) = x(n) + h;
fprintf('Results from linear shooting method:\n\n');
fprintf('   Xi_____________________________Yi\n');
fprintf('__________________________________________\n');
for i = 1 : n + 1
    fprintf('%f________________________%f\n', x(i), y(i));
end

plot(x, y, 'go-')