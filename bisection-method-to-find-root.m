
myfunction = @(x) x.^3-2.*x-5;
x_lower =2;
x_upper=3;
x_mid=(x_lower+x_upper)/2;

while  abs(myfunction(x_mid))>0.00001
    if(myfunction(x_mid )*myfunction(x_upper))<0
        x_lower=x_mid;
fprintf(' %g\n',x_lower)
    else
        x_upper=x_mid;
        fprintf(' %g\n',x_upper)
    end
    
    x_mid=(x_lower+x_upper)/2;

fprintf(' %g\n',x_mid)
end
fprintf('the root is %g\n',x_mid)