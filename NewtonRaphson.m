clear all;
clc;
syms x;
givenFun = @(x) x*x*x - 2*x - 5;
derivOfFun = diff(givenFun, x);
derivOfFun = inline(derivOfFun);

previousRoot = input('Enter the initial point: ');
root = 0;
for i = 1:1:100
    if derivOfFun(previousRoot) == 0
        fprintf('Root can not be found because derivative is zero at x = %f\n:', previousRoot);
        break
    else
        root = previousRoot - (givenFun(previousRoot)/derivOfFun(previousRoot));
    end
    if abs(givenFun(previousRoot) - givenFun(root)) <= 0.00001
        break;
    else
        previousRoot = root;
    end
end
if i > 100
        fprintf('root can not be find in %d iteration', i);
    else
        fprintf('root is: %f\nFound by iteration %d\n', root, i);
end
    