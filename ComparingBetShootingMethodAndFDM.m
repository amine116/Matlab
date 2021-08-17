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
hold on

fprintf('\n\n');

% Finite Difference method

% Suppose the differential equation is:
% y" = p(x)y' + q(x)y + r(x)

p = @(x) 0;
q = @(x) -(pi*pi);
r = @(x) 0;

% Input Exact Solution
exactSol = @(x) cos(pi*x);

% boundary conditions
x0 = a;

xn = b;

n = n - 1;

% Initializing x values
for i = 1:n
    x(i) = x0 + i*h;
end

% Input the System
for i = 1:n
    if i == 1
        a(i) = 0;
        c(i) = 1 - (h/2)*p(x(i));
        d(i) = (h^2)*r(x(i)) - (1 + (h/2)*p(x(i)))*y0;
    else
        a(i) = 1 + (h/2)*p(x(i));
        if i == n
            d(i) = (h^2)*r(x(i)) - (1 - (h/2)*p(x(i)))*yn;
            c(i) = 0;
        else
            d(i) = (h^2)*r(x(i));
            c(i) = 1 - (h/2)*p(x(i));
        end
    end
    b(i) = -(2 + (h^2)*q(x(i)));
end

% start solution
% finding c' = cc, d' = dd
for i = 1:n
    if i == 1
       cc(i) = c(i)/b(i);
       dd(i) = d(i)/b(i);
    else
       cc(i) = c(i)/(b(i) - a(i)*cc(i - 1));
       dd(i) = (d(i) - a(i)*dd(i - 1))/(b(i) - a(i)*cc(i - 1));
    end
end

%initializing the solution y
for i = 1:n
   y(i) = 0; 
end

% Solving the tridiagonal system
j = n - 1;
y(n) = dd(n);
for i = 1:n - 1
    y(j) = dd(j) - cc(j)*y(j + 1);
    j = j - 1;
end

% Builiding an output
xx(1) = x0;
yy(1) = y0;
for i = 2:n+1
    xx(i) = x(i - 1);
    yy(i) = y(i - 1);
end
xx(i + 1) = xn;
yy(i + 1) = yn;

fprintf('Solutions from finite difference methods are:\n');
fprintf('Results from linear shooting method:\n\n');
fprintf('   Xi_____________________________Yi\n');
fprintf('__________________________________________\n');
for i = 1 : n + 2
    fprintf('%f________________________%f\n', xx(i), yy(i));
end

% Finding numeric values from exact Solution
for i = 1 : n + 2
   exact(i) = exactSol(xx(i));
end

plot(xx, yy, 'b*-')
hold on
plot(xx, exact, 'r.-')
legend('Shooting', 'FDM', 'Exact');