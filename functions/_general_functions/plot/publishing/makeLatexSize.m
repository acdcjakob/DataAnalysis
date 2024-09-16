function [ax,f] = makeLatexSize(w0,ratio,varargin)
%MAKELATEXSIZE Summary of this function goes here
%   Detailed explanation goes here

p = inputParser();

    addRequired(p,"w0",@(x) isnumeric(x))
    addRequired(p,"ratio",@(x) isnumeric(x))
    addOptional(p,"ax0",gobjects(),@(x) true)

parse(p,w0,ratio,varargin{:})


textwidth = 14.64; % in cm
w = textwidth*w0;
h = textwidth*w0*ratio;



if isgraphics(p.Results.ax0)
    ax = p.Results.ax0;
    f = get(p.Results.ax0,"parent");
else
    f = figure();
    ax = axes();
end

set(f,...
        "units","centimeters",...
        "Position",[2 2 w+4 h+4]);

set(ax,...
    "units","centimeters",...
    "OuterPosition",[2 2 w h])

formatAxes(ax);

end

