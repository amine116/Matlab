
function GauseSeidel(A, b, n)
aug=[A, b];

h = 0.1e-5;
isConsistance = 0;
ref = zeros(1:n);
initialMatrix = zeros(1:n);

while (isConsistance == 0)
    
    for i=1:n
        solution(i) = aug(i, n+1);
        for j=1:n
            if(i~=j)
                solution(i) = solution(i)-( aug(i,j)*initialMatrix(j) );
            end
        end
        
        solution(i) = solution(i)/aug(i, i);
        
        if(abs(solution(i)-initialMatrix(i)) < h)
            ref(i)=1;
        end
        
        initialMatrix(i) = solution(i);
        fprintf('%f       ', solution(i));
    end
    
    initialMatrix=solution;
    fprintf('\n');
    if(ref(1:n) ==1)
        isConsistance = 1;
    else
        isConsistance = 0;
    end
    
    
end

fprintf('Solution are: ');
solution

end