function [ah,fh] = createAxes(varargin)

p = inputParser();
addOptional(p,"ratio",1,@(x) isnumeric(x))
addOptional(p,"height",500,@(x) isnumeric(x))
parse(p,varargin{:})

fh = figure("OuterPosition",[100 100 p.Results.height*p.Results.ratio p.Results.height]);
ah = axes(LineWidth=.75,...
    FontSize=12,...
    Box="on", ...
    XGrid="on",...
    YGrid="on");
end

