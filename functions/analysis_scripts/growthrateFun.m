function growthrate = growthrateFun(tableInput)
%GROWTHRATEFUN calculates growth rate
%   tableInput is table containing "d" and "Pulses".
growthrate = columnToNumber(tableInput.d) ./ columnToNumber(tableInput.Pulses);
end

