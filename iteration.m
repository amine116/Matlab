fun = @(x) 1/sqrt(x + 1);
root = 0;
prevRoot = input('enter initial value: ');
for i = 1:1:100
    root = fun(prevRoot);
    if abs(fun(root) - fun(prevRoot)) <= 0.0001
        break;
    else
        prevRoot = root;
    end
end
fprintf('ans = %f\n iteration: %d\n', root, i);