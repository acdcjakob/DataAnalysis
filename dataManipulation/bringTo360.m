function output = bringTo360(input)
%BRINGTO360 adds +360 to all negative values of input

for i = 1:numel(input)
    if input(i) < -180
        input(i) = input(i)+360;
    elseif input(i) > 180
        input(i) = input(i)-360;
    end
end
output = input;
end

