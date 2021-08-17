function SolutionByLUFactorization(A, b, n)
clc;
U(1, 1 : n) = A(1, 1 : n);
L(2 : n, 1) = A(2 : n, 1)/U(1,1);

for i = 1:n
    L(i, i) = 1;
end

%constructing L and U
for i = 2:n
    
    for j = i:n
        
        temporary = 0;
        for k = 1:i-1
            temporary = temporary + L(i, k)*U(k, j);
        end
        U(i, j) = A(i, j) - temporary;
    end
    
    
    for j = i+1:n
        temporary = 0;
        for k = 1:i-1
            temporary = temporary + L(j, k) * U(k, i);
        end
        L(j, i) = (1/U(i,i )) * ( A(j, i) - temporary );
    end
    
    
end

fprintf('A is: ');
A
fprintf('L is: ');
L
fprintf('U is: ');
U

y(1) = b(1,1);
for i = 2:n
    y(i) = b(i,1);
    for j = 1: i-1
        y(i) = y(i) - L(i, j)*y(j);
    end
end

y


solution(n) = y(n)/U(n,n);

for i = n-1: -1:1
    solution(i) = y(i);
    for j = i+1 : n
        solution(i) = solution(i) - U(i, j)*solution(j);
    end
    solution(i) = solution(i)/U(i, i);
   
end



fprintf('Solutions are: ');
solution


end