function output = replaceCommaAndBracket(inputArray)
% replaceCommaAndBracket(input)
%   input = [s1,s2,s3]
%   input = {ch1,ch2,ch3}
%   - Input is a string-array or cell array of character arrays. 
%   - Commas are converted to dots
%   - Brackets are ignored, i.e.: '32,54(2)' --> '32.54' (everything after
%   "(" is deleted)

dim = size(inputArray);

if iscell(inputArray)
    inputArrayCell = inputArray;
elseif isstring(inputArray)
    for i = 1:dim(1)
        for j = 1:dim(2)
            inputArrayCell{i,j} = char(inputArray(i,j));
        end
    end
elseif isfloat(inputArray)
    output = inputArray;
    return
else
    disp('replaceCommaAndBracket.m: no known number input')
    output = nan;
    return
end


% bereite array for
output = nan(dim);
for i = 1:dim(1)
    for j = 1:dim(2)
        thisCell = inputArrayCell{i,j};
        % --- remove commas
        thisCell(strfind(thisCell,','))='.';
        % --- remove error brackets
        thisCell(strfind(thisCell,'('):end)=[];

        output(i,j) = str2double(thisCell);
    end
end


end

