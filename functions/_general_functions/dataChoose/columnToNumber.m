function output = columnToNumber(column)
    %columnToNumber(column) where column is something like table.C
    % converts into vertical number array
    
    if isfloat(column)
        % already number array?
        output = column;
    elseif iscell(column)
        % is it a cell array? -> chars / numbers / strings?
        output = nan(size(column));
        for i = 1:numel(column)
            if isfloat(column{i})
                output(i) = column{i};
            elseif ischar(column{i}) | isstring(column{i})
                output(i) = str2double(column{i});
            else
                disp("Dude, what is this column?")
            end
        end
    elseif isstring(column)
        % is it a string array?
        output = str2double(column);
    else
        disp("Dude, what is this column?")
    end

end