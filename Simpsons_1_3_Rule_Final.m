syms x;
fun = @(x) sin(pi*x);
der1 = diff(fun, x);
der2 = diff(der1, x);
der3 = diff(der2, x);
der4 = diff(der3, x);
der4
fourthDer = inline(der4);
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
    elseif mod(decide, 2) == 1
        sum = sum + 4*fun(i);
        decide = decide + 1;
    else 
        sum = sum + 2*fun(i);
        decide = decide + 1;
    end
end
sum = (h/3)*sum;
fprintf('The answer is: %f\n', sum);
maxValueOfFourthDer = -9999999999999999;
for i = down:h:up
    yValueOfFourthDer = fourthDer(i);
    if maxValueOfFourthDer < yValueOfFourthDer
        maxValueOfFourthDer = yValueOfFourthDer;
    end
end
error = ((up - down)/180)*(h^4)*maxValueOfFourthDer;
fprintf('With Calculated Error: %f\n', error);
fprintf('And Error from default integration: %f\n', abs(int(fun, x, down, up) - sum));