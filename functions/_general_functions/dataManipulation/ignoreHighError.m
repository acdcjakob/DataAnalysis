function output = ignoreHighError(input,varargin)
% ignoreHighError(input)
%   input: 2xn array with data and error
%
% ignoreHighError(___,"tolerance",value)
% defines the threshold of error to data ratio; default: 1

p = inputParser;

addRequired(p,"input",@(x) isnumeric(x))
addOptional(p,"tolerance",1,@(x) isnumeric(x))

parse(p,input,varargin{:})

% 2xn array with data and its errors
    if isempty(input)
        output = [NaN;NaN];
        return
    end
    for idx = 1:numel(input(1,:))
        if abs(input(2,idx)/input(1,idx)) >= p.Results.tolerance
            disp("ignoreHighError.m: "+num2str(input(1,idx))+" +- "+num2str(input(2,idx))+" entfernt")
            input(1,idx) = NaN;
            input(2,idx) = NaN;
        end
    end
    output = input;
end