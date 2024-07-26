function output = createXTick(A)
% A is a cell array of mostly numbers (ideally) and some non-numbers which
% will be translated into numbers
% is the NameVal Column of the Probenspreadsheet
output = [];

Aconv = str2double(A);

NumberIdx = ~isnan(Aconv);
    % gives true for every content that is a number
if sum(NumberIdx) < 2
    disp("WARNING createXTick.m: There should be at least 2 numbers for x-Axis")
    Span = 1;
else
    Span = max(Aconv(NumberIdx))-min(Aconv(NumberIdx));
end

k = 1;
    for i = 1:numel(A)
        if ~isnan(Aconv(i))
            % cell is number
            output(i,1) = Aconv(i);
        else
            % cell is not a number
            output(i,1) = max(Aconv(NumberIdx)) + (0.6+0.4*k)*Span;
            k = k+1;
                % this is arbitrary
        end
    end
    
end