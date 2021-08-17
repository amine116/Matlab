
syms y(x);
eqn = diff(y, x) == 3*x + y/2;
functionalValue = @(x, y) 3*x + y/2;


xAxisValues(1)=input('Enter initial x: ');
yAxisValue(1)=input('Enter initial y: ');
calculatingValue = input('Enter calculating Value: ');
h = input('Enter step size h: ');

cond = y(xAxisValues(1)) == yAxisValue(1);

numberOfINterval = fix((calculatingValue-xAxisValues(1))/h + 1e-14);

for i=2:numberOfINterval+1
    yAxisValue(i) = yAxisValue(i-1) + h*functionalValue(xAxisValues(i-1), yAxisValue(i-1));
    xAxisValues(i) = xAxisValues(i-1) + h;
end

fprintf('Eular result at %f is: %f\n\n: ',calculatingValue,yAxisValue(i));

soltuionByDefault = dsolve(eqn, cond, 'x')
exactResultByDefault = inline(vectorize(soltuionByDefault));

plot(xAxisValues,exactResultByDefault(xAxisValues),'bo-', xAxisValues,yAxisValue,'r.-');

%hold on;

%plot(xAxisValues,yAxisValue,'r.-');

legend('Exact solution','Approximat solution');

