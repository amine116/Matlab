clear all;
clc;
% y" = y--------------(1)
% y" = (y(i - 1) - 2yi + y(i + 1))/h^2
% y' = (y(i + 1) - y(i - 1))/2h
% So, from (1) we get, y(i - 1) - (2 + h^2)yi + y(i + 1) = 0;
h = 0.4;

% boundary conditions
x0 = 0;
y0 = 0;

xn = 2;
yn = 3.627;
n = (xn - x0)/h;


% Enter a
fprintf('Enter a\n');
for i = 1:3
    a(i) = input('');
end
numOfEq = n - 1;
numOfVar = n + 1;
for i = 1:numOfEq
    c = 1;
    for j = i : i + 3
        if c > 3
            system(i, j) = 0;
        else
            system(i, j) = a(c);
            c = c + 1;
        end
    end
    
end
system
temp = system(1, 1);
system(1, 1) = 0;
system(1, numOfVar + 1) = -temp*y0;
temp = system(i, numOfVar);
system(i, numOfVar) = 0;
system(i, numOfVar + 1) = -temp*yn;
system = system(1:numOfEq, 2:numOfVar + 1)
numOfVar = numOfVar - 1;
for i = 1:numOfEq
    diagonalElement = system(i, i);
    for j = 1:(numOfVar + 1)
        system(i, j) = system(i, j)/diagonalElement;
    end 
    constant(i) = system(i, numOfVar + 1);
end

for i = 1:numOfVar 
    solution(i) = 0;
end

%Start iteration up to maximumIteration
iteration = 1;
maximumIteration = 100;

while iteration <= maximumIteration
    
    for i = 1:numOfEq
        temp = 0.0;
        for j = 1:numOfVar
            if i ~= j
                temp = temp + (system(i, j)*solution(j));
            end
        end
        solution(i) = constant(i) - temp;
    end
    iteration = iteration + 1;
end

%Printing the solutions
fprintf('Solutions are:\n');
for i = 1:numOfVar
    fprintf('X%d = %f\n', i, solution(i));
end
