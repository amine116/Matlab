% Defining functions
f1 = @(x, u1, u2, u3, u4) u2;
f2 = @(x, u1, u2, u3, u4) -u2^2 - u1 + log(x);
f3 = @(x, u1, u2, u3, u4) u4;
f4 = @(x, u1, u2, u3, u4) -u3 - 2*u2*u4;

exactSolution = @(x) log(x);

% Interval & corresponding value
fprintf('Input Boundary Values\n');
left = input('X0: ');
y0 = input('Y0: ');

right = input('Xn: ');
yn = input('Yn: ');

exact(1) = exactSolution(left);

% Initial tk, step size h, and total interval n
t(1) = (yn - y0)/(right - left);
h = 0.1;
n = (right - left)/h;

% Computing numeric solution
maxIteration = 50;
for j = 2 : maxIteration
    % Initial condintions for each iteration where tk is new for each
    % iteration
    x(1) = left;
    u1(1) = y0;
    u2(1) = t(j - 1);
    u3(1) = 0;
    u4(1) = 1;
    
    fprintf('\n\niteration no:(%d)     xi                     y(xi)                    exact Solution                     |Error|\n', j);
    fprintf('---------------------------------------------------------------------------------------------------------------------------\n');
    
    for i = 2 : n + 1
        k11 = h*f1(x(i - 1), u1(i - 1), u2(i - 1), u3(i - 1), u4(i - 1));
        k12 = h*f2(x(i - 1), u1(i - 1), u2(i - 1), u3(i - 1), u4(i - 1));
        k13 = h*f3(x(i - 1), u1(i - 1), u2(i - 1), u3(i - 1), u4(i - 1));
        k14 = h*f4(x(i - 1), u1(i - 1), u2(i - 1), u3(i - 1), u4(i - 1));

        k21 = h*f1(x(i - 1) + h/2, u1(i - 1) + k11/2, u2(i - 1) + k12/2, u3(i - 1) + k13/2, u4(i - 1) + k14/2);
        k22 = h*f2(x(i - 1) + h/2, u1(i - 1) + k11/2, u2(i - 1) + k12/2, u3(i - 1) + k13/2, u4(i - 1) + k14/2);
        k23 = h*f3(x(i - 1) + h/2, u1(i - 1) + k11/2, u2(i - 1) + k12/2, u3(i - 1) + k13/2, u4(i - 1) + k14/2);
        k24 = h*f4(x(i - 1) + h/2, u1(i - 1) + k11/2, u2(i - 1) + k12/2, u3(i - 1) + k13/2, u4(i - 1) + k14/2);

        k31 = h*f1(x(i - 1) + h/2, u1(i - 1) + k21/2, u2(i - 1) + k22/2, u3(i - 1) + k23/2, u4(i - 1) + k24/2);
        k32 = h*f2(x(i - 1) + h/2, u1(i - 1) + k21/2, u2(i - 1) + k22/2, u3(i - 1) + k23/2, u4(i - 1) + k24/2);
        k33 = h*f3(x(i - 1) + h/2, u1(i - 1) + k21/2, u2(i - 1) + k22/2, u3(i - 1) + k23/2, u4(i - 1) + k24/2);
        k34 = h*f4(x(i - 1) + h/2, u1(i - 1) + k21/2, u2(i - 1) + k22/2, u3(i - 1) + k23/2, u4(i - 1) + k24/2);
        
        k41 = h*f1(x(i - 1) + h, u1(i - 1) + k31, u2(i - 1) + k32, u3(i - 1) + k33, u4(i - 1) + k34);
        k42 = h*f2(x(i - 1) + h, u1(i - 1) + k31, u2(i - 1) + k32, u3(i - 1) + k33, u4(i - 1) + k34);
        k43 = h*f3(x(i - 1) + h, u1(i - 1) + k31, u2(i - 1) + k32, u3(i - 1) + k33, u4(i - 1) + k34);
        k44 = h*f4(x(i - 1) + h, u1(i - 1) + k31, u2(i - 1) + k32, u3(i - 1) + k33, u4(i - 1) + k34);
        
        u1(i) = u1(i - 1) + (1/6)*(k11 + 2*k21 + 2*k31 + k41);
        u2(i) = u2(i - 1) + (1/6)*(k12 + 2*k22 + 2*k32 + k42);
        u3(i) = u3(i - 1) + (1/6)*(k13 + 2*k23 + 2*k33 + k43);
        u4(i) = u4(i - 1) + (1/6)*(k14 + 2*k24 + 2*k34 + k44);
        
        x(i) = x(i - 1) + h;
        exact(i) = exactSolution(x(i));
        
        
        fprintf('                   %f                 %f                      %f                       %f\n', x(i), u1(i), exact(i), abs(u1(i) - exact(i)));


    end
    t(j) = t(j - 1) - (u1(i) - yn)/u3(i);
    
end

plot(x, u1, 'r*-')
hold on
plot(x, exact, 'bo-')
legend('Approximate Solution', 'Exact Solution');