f = @(x, y) y - x*x + 1;

x(1) = 0;
y(1) = 0.5;
h = 0.1;
xn = 2;

n = (xn - x(1))/h;
fprintf('  xi                 y(xi)\n');
fprintf('-----------------------------------\n');
fprintf('%f             %f\n', x(1), y(1));
for i = 2 : n + 1
    y(i) = y(i - 1) + (h/2)*(f(x(i - 1), y(i - 1)) + f(x(i - 1) + h, y(i - 1) + h*f(x(i - 1), y(i - 1))));
    x(i) = x(i - 1) + h;
    fprintf('%f             %f\n', x(i), y(i));
end
plot(x, y, 'r*-');
