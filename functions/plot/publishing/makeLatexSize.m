function [ax,f] = makeLatexSize(w0,ratio,varargin)
% [ax,f] = makeLatexSize(w0,ratio) with w0 the relative length to 14.64 cm
% (textwidth of latex book class)
% [ax,f] = makeLatexSize(w0,ratio,ax) alters the input axes

p = inputParser();

    addRequired(p,"w0",@(x) isnumeric(x))
    addRequired(p,"ratio",@(x) isnumeric(x))
    addOptional(p,"ax0",gobjects(),@(x) true)

parse(p,w0,ratio,varargin{:})

% ylabel takes 0.8 cm
% yticklabels take 0.6 cm
% xlabel takes 0.9 cm
% yticklabels take 0.7 cm

% experience: need some more horizontal buffer space; e.g. 0.2
textwidth = 14.64; % in cm
w = textwidth*w0 - 0.8-0.6-0.2;
h = textwidth*w0*ratio - 0.9-0.7;



if isgraphics(p.Results.ax0)
    ax = p.Results.ax0;
    par = get(ax,"parent");
    if strcmp(par.Type,"tiledlayout")
        f = get(par,"Parent");
    else
        f = get(ax,"parent");
    end
else
    f = figure();
    ax = axes();
end

set(f,...
        "units","centimeters",...
        "Position",[2 2 w+4 h+4]);

set(ax,...
    "units","centimeters",...
    "Position",[2 2 w h])

if strcmp(ax.Type,"tiledlayout")
    return
else
    formatAxes(ax);
end

end

