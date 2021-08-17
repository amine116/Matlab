function GauseElimination(A, b, n)

aug = [A ,b];

%making upper trianguler with pivoting

for i = 1 : n-1
    
    %pivoting
    high = abs(aug(i, i));
    temporary = i;
    for k = i+1 : n
        if(abs(aug(k, i))>= high)
            high = abs(aug(k, i));
            temporary = k;
        end
    end
    
    temp(i, 1 : n+1) = aug(i, 1 : n+1);
    aug(i, 1 : n+1)= aug(temporary, 1 : n+1);
    aug(temporary, 1 : n+1)=temp(i, 1 : n+1);
    %end pivoting
    
    
    %making upper trrianguler
    for j = i+1 : n    
        temporary = aug(j,i)/aug(i,i);
        aug(j, i : n+1) = aug(j, i : n+1)- temporary*aug(i, i : n+1)
    end
    
end


%back substituting
solution(n) = aug(n, n+1)/aug(n, n);
for i = n-1 :-1 : 1
    temporary=aug(i, n+1);
    for j = n : -1 : i+1
        temporary = temporary - aug(i, j)*solution(j);
    end
    solution(i) = temporary/aug(i,i);
end


fprintf('Solution are: ');
solution

end