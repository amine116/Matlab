clear all;
clc;
% Suppose the differential equation is:
% y" = p(x)y' + q(x)y + r(x)

p = @(x) 0;
q = @(x) -(pi*pi);
r = @(x) 0;

% Input Exact Solution
exactSol = @(x) cos(pi*x);

% Input the value of h
h = 0.01;
% boundary conditions
x0 = input('X0: ');
y0 = input('Y0: ');

xn = input('Xn: ');
yn = input('Yn: ');
n = ((xn - x0)/h) - 1

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
% Print the system
fprintf('The Tridiagonal System is:\n');
for i = 1:n
   fprintf('%f %f %f %f\n', a(i), b(i), c(i), d(i)); 
end
fprintf('\n\n');
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

fprintf('Solutions are:\n');
for i = 1 : n + 2
    fprintf('y(%f) = %f\n', xx(i), yy(i));
end

% Finding numeric values from exact Solution
for i = 1 : n + 2
   exact(i) = exactSol(xx(i));
end
plot(xx, yy, 'b*-')
hold on
plot(xx, exact, 'r.-')
legend('Approximate', 'Exact');