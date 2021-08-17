syms x;
fun = @(x) 1/(1 + x);
der1 = diff(fun, x);
der2 = diff(der1, x);
der2
secondDer = inline(der2);
down = input('Give Lower point ');
up = input('Give Upper Point ');
n = input('Enter Total number of division of interval ');
h = (up - down)/n;
sum = 0;
for i = down:h:up
    if i == down || i == up
        sum = sum + fun(i);
    else
        sum = sum + 2*fun(i);
    end
end
sum = (h/2)*sum;
fprintf('answer is: %f\n', sum);
maxValOfSecondDer = -9999999999999999;
for i = down:h:up
    yValue = secondDer(i);
    if yValue > maxValOfSecondDer
        maxValOfSecondDer = yValue;
    end
end
error = -(1/12)*(h^3)*maxValOfSecondDer;
fprintf('\nWith Calculated Error is: %f\n', error);
fprintf('And error from default integration: %f\n', abs(int(fun, x, down, up) - sum)); 

