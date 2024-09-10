function [ah,fh] = createAxes(varargin)

p = inputParser();
addOptional(p,"ratio",1,@(x) isnumeric(x))
addOptional(p,"length",500,@(x) isnumeric(x))
parse(p,varargin{:})

fh = figure("OuterPosition",[100 100 p.Results.length*p.Results.ratio p.Results.length]);
ah = axes(LineWidth=.75,...
    FontSize=12,...
    Box="on", ...
    XGrid="on",...
    YGrid="on");
end

