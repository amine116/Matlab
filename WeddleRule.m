syms x;
givenFun = @(x) 1/(1 + x);
der1 = diff(givenFun, x);
der2 = diff(der1, x);
der3 = diff(der2, x);
der4 = diff(der3, x);
der5 = diff(der4, x);
der6 = diff(der5, x);
der6
sixthOrderDer = inline(der6);
down = input('Enter the lower limit: ');
up = input('Enter the upper limit: ');
n = input('Enter number of interval: ');
sum = 0;
h = (up - down)/n;
decide = 1;
for i = down:h:up
    
    y = givenFun(i);
    
    if decide == 1
        sum = sum + y;
        decide = 2;
    elseif decide == 2
         sum = sum + 5*y;
         decide = 3;
    elseif decide == 3
         sum = sum + y;
         decide = 4;
    elseif decide == 4
        sum = sum + 6*y;
        decide = 1;
    end
end
sum = ((3*h)/10)*sum;
fprintf('\nWeddle solution is: %f\n', sum);
maxValue = -999999999999999;
for i = down:h:up
    yValue = sixthOrderDer(i);
    if yValue > maxValue
        maxValue = yValue;
    end
end
error = -(h^7/140)*maxValue;
fprintf('Error by calculation is: %f\n', error);
fprintf('Error by default integration: %f\n', abs(int(fun, x, down, up) - sum));
