
function solutionByZordanElimination(A, b, n)
clear all;
clc;
aug = [A, b];

for i = 1:n
    
    high = abs(aug(i, i));
    temporary = i;
    for k = i+1:n
        if(abs(aug(k, i)) > high )
            high = abs(aug(k, i));
            temporary = k;
        end
    end
    
    midium(i, 1:n+1) = aug(i, 1:n+1);
    aug(i, 1:n+1) = aug(temporary, 1:n+1);
    aug(temporary, 1:n+1) = midium(i, 1:n+1);
    
    for j = 1:n
        if(i~=j)
            temporary = aug(j, i)/aug(i, i);
            aug(j, i:n+1) = aug(j, i:n+1) - temporary*aug(i, i:n+1);
        end
    end
    
end

for i = n:-1:1
    solution(i) = aug(i, n+1)/aug(i, i);
end

fprintf('Solution are: ');
solution


end