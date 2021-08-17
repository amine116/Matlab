function GauseJackobiMethodToSolveSystemOfLinearEquation(system, numOfEq, numOfVar)
for i = 1:numOfEq
    solution(i) = system(i, numOfVar + 1);
end

%Reinitialize the system (dividing all element by the diagonal element)
for i = 1:numOfEq
    diagonalElement = system(i, i);
    for j = 1:(numOfVar + 1)
        system(i, j) = system(i, j)/diagonalElement;
    end 
    solution(i) = system(i, numOfVar + 1);
    constant(i) = solution(i);
end

%Start iteration up to maximumIteration
iteration = 1;
maximumIteration = 50;

while iteration <= maximumIteration
    %putting previous solutions in temporary array
    for tm = 1:numOfVar
        temporary(tm) = solution(tm);
    end
    %every iteration
    for i = 1:numOfEq
        temp = 0.0;
        for j = 1:numOfVar
            if i ~= j
                temp = temp + (system(i, j)*temporary(j));
            end
        end
        solution(i) = constant(i) - temp;
    end
    iteration = iteration + 1;
end

%Printing the solutions
fprintf('Solutions are:\n');
for i = 1:numOfVar
    fprintf('X%d = %f\n', i, solution(i));
end