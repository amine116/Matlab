syms x;
fun = @(x) 1/(1 + x);

der1 = diff(fun, x);
der2 = diff(der1, x);
der3 = diff(der2, x);
der4 = diff(der3, x);
der4
fourthOrderDer = inline(der4);

down = input('Enter Lower limit ');
up = input('Enter upper  limit ');
n = input('Enter number of division of interval ');
h = (up - down)/n;

sum = 0;
decide = 0;
for i = down:h:up
    if i == down || i == up
        sum = sum + fun(i);
        decide = decide + 1;
    elseif decide == 1
        sum = sum + 3*fun(i);
        decide = decide + 1;
    elseif decide == 2
        sum = sum + 3*fun(i);
        decide = decide + 1;
    elseif decide == 3
        sum = sum + 2*fun(i);
        decide = 1;
    end
end
sum = (3*h/8)*sum;
fprintf('The result is: %f\n', sum);
maxValueOfDer = -99999999999999999;
for i = down:h:up
    yValue = fourthOrderDer(i);
    if maxValueOfDer < yValue
        maxValueOfDer = yValue;
    end
end
error = -(3/80)*(h^5)*maxValueOfDer;
fprintf('Error by calculation is: %f\n', error);
fprintf('Error by default integration: %f\n', abs(int(fun, x, down, up) - sum));
        