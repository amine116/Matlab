givenFun = @(x) x*x*x - 2*x - 5;
a = input('enter a: ');
b = input('enter b: ');
x = 0;
for i = 1:1:100
    x = a - (givenFun(a)*(b - a))/((givenFun(b) - givenFun(a)));
    if givenFun(x) > 0.00001
        b = x;
    else
        a = x;
    end
    if abs(givenFun(x)) <= 0.00001
        break;
    end
end
fprintf('ans = %f\niteration is %d\n', x, i);