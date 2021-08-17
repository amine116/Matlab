clear all;
clc;
f1 = @(t, y, z) z;
f2 = @(t, y, z) 2*z - 2*y + exp(2*t)*sin(t);

% Taking inputs
fprintf('Input initial Condition on y:\n');
t(1) = input('t0: ');
y(1) = input('y0: ');
fprintf("Input condition on y'(condition on derivative)\n");
derOfX = input('t0: ');
derOfY = input('y~: ');

z(1) = derOfY;
h = 0.1;

fprintf("Input Interval\n");
left = input('left: ');
right = input('right: ');

% Calculating numeric solution
n = (right - left)/h;
for i = 2:n + 1
    t(i) = t(i - 1) + h;
    y(i) = y(i - 1) + h*f1(t(i - 1), y(i - 1), z(i - 1));
    z(i) = z(i - 1) + h*f2(t(i - 1), y(i - 1), z(i - 1));
end
plot(t, y, 'b*-')
hold on

% Calculating exact solution
syms U(x) Z(x)

%A = [0 1; -2 2];
%Y = [U; Z];
%B = [1; exp(2*t)*(sin(t))];

%odes = diff(Y) == A*Y + B;
ode1 = diff(U) == Z;
ode2 = diff(Z) == -2*U + 2*Z + exp(2*x)*sin(x);
odes = [ode1; ode2];
 
cond1 = U(0) == y(1);
cond2 = Z(0) == derOfY;
cond = [cond1; cond2];
 
[uSol(x), zSol(x)] = dsolve(odes, cond);

uSol(x) = simplify(uSol(x))
zSol(x) = simplify(zSol(x))

exactSol = inline(vectorize(uSol));

plot(t, exactSol(t), 'ro-')
legend('Approximate Solution', 'Exact Solution');

exact(1) = t(1);

for i = 2:n+1
   exact(i) = exactSol(t(i));
end

fprintf('  t(i)              y(i)              exact Solution               |Error|\n');
fprintf('---------------------------------------------------------------------------------\n');
for i = 1:n+1
    fprintf('%f          %f               %f                %f\n', t(i), y(i), exact(i), abs(y(i) - exact(i)));
end

