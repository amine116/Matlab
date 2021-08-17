function GauseJackobi(A, b, n)
aug = [A, b];

h = 0.1e-5;

for i = 1: n
    temporary = 0;
    for j=1:n
        if i~=j
            temporary = temporary + abs(aug(i,j));
        end
    end
    if abs(aug(i,i)) < temporary
        fprintf('The solution will not converge/ not diagonally dominent')
        return
    end
end

isConsistance = 0;
compareMatrix = zeros(1:n);
initialMatrix = zeros(1:n);



while(isConsistance == 0)
    
    for i = 1:n
        solution(i) = aug(i, n+1);
        
        for j = 1:n
            if(i~=j)
                solution(i) = solution(i) - (aug(i,j)*initialMatrix(j));
            end
        end
   
        solution(i ) = solution(i)/aug(i,i);
        if(abs(solution(i) - initialMatrix(i)) < h)
            compareMatrix(i) = 1;
        end
        
        fprintf('%f       ', solution(i));
    end
    
    initialMatrix = solution;
    
    fprintf('\n');
    
    if(compareMatrix(1:n) ==1)
        isConsistance = 1;
    else
        isConsistance = 0;
    end
    
end

fprintf('Solution are: ');
solution

end