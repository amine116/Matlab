
syms y(x);
eqn = diff(y, x) == 3*x + y/2;

functionalValue = @(x, y) 3*x + y/2;

xAxisValues(1)=input('Enter the initial x: ');
yAxisValue(1)=input('Enter the initial y: ');

cond = y(xAxisValues(1)) == yAxisValue(1);

calculatingValue=input('Enter the calculating value: ');


h=input('Enter step size h : ');

numberOfINterval=fix(abs(calculatingValue-xAxisValues(1))/h + 1e-14);


for i=2:numberOfINterval+1
  
  k1=h*functionalValue(xAxisValues(i-1), yAxisValue(i-1))
  k2=h*functionalValue(xAxisValues(i-1) + h/2, yAxisValue(i-1) + k1/2);
  k3=h*functionalValue(xAxisValues(i-1) + h/2, yAxisValue(i-1) + k2/2);
  k4=h*functionalValue(xAxisValues(i-1) + h, yAxisValue(i-1) + k3);
  
  yAxisValue(i)= yAxisValue(i-1) + (1/6)*(k1 + (2*k2 + 2*k3) + k4);

  xAxisValues(i) = xAxisValues(i-1) + h;
end

fprintf('Runge-Kutta 4 result at %f is %f\n\n',calculatingValue, yAxisValue(i))

soltuionByDefault = dsolve(eqn, cond, 'x')
exactResultByDefault = inline(vectorize(soltuionByDefault));


plot(xAxisValues,exactResultByDefault(xAxisValues),'bo-');

hold on;

plot(xAxisValues,yAxisValue,'r.-');

legend('Exact Solution','Approxi Solution');
