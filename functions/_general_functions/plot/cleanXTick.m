function output = cleanXTick(A)
% A is a number array
% we need this function because Matlab is angry if XTick containts
% not-increasing or repeated numbers...
% the first column are the not-doubled x-values and the second column is
% the initial index for accessing the NameVal variable

if numel(A) < 2
    output = A;
    return
end

if isrow(A)
    A = transpose(A);
end
% ----- sort values ------
Asort = [A,transpose(1:numel(A))];
% 1st column values, 2nd column indices

Asort = sortrows(Asort);

% ----- delete repeating values -----
k = 1;
output(k,:) = [Asort(k,1),Asort(k,2)];
k = k+1;
    for i = 2:numel(A)
        if abs(Asort(i,1)-Asort(i-1,1))>1e-20
            % this weird statement is necessary due to stuff happening with
            % float numbers
            output(k,1) = Asort(i,1);
            output(k,2) = Asort(i,2);
            k = k+1;
        end
    end

end
