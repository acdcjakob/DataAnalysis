function [] = linePainter(H,varargin)
% linePainter(H) takes array of Lines and paints the lines
% linePainter(___,"singleColor",[i j]) takes row i and column j from color
% constant as color (then H must be single handle)
% linePainter(___,"StartColor",[a b c])
% linePainter(___,"EndColor",[i j k])
% linePainter(___,"Priority",number)
% linePainter(___,"Width",number)
if iscell(H)
    H =cellfun(@(x) x, H);
    disp("linePainter.m: Cell array wurde zu array geformt")
end

% --- parse the input
p = inputParser;
singleColor_default = [];
startColor_default = [1 0 0];
endColor_default = [0 0 0];
priority_default = 1;
width_default = 1;

%addRequired(p,'H',@(x) ~any(~ishandle(x),'all'))
addRequired(p,'H',@(x) isobject(x));
addParameter(p,'singleColor',singleColor_default,@(x) isfloat(x))
addParameter(p,'startColor',startColor_default,@(x) isfloat(x)|isstring(x)|ischar(x))
addParameter(p,'endColor',endColor_default,@(x) isfloat(x)|isstring(x)|ischar(x))
addParameter(p,'priority',priority_default,@(x) isnumeric(x))
addParameter(p,'MarkerSize',10,@(x) true)
addParameter(p,'width',width_default,@(x) isnumeric(x))
addParameter(p,'shiftColumn',0,@(x) true)

parse(p,H,varargin{:});

% convert hex to rgb
if ischar(p.Results.startColor) | isstring(p.Results.startColor)
    p.Results.startColor = hex2rgb(p.Results.startColor);
end
if ischar(p.Results.endColor) | isstring(p.Results.endColor)
    p.Results.endColor = hex2rgb(p.Results.endColor);
end

% --- functional part ---
load("PLOTCONSTANT.mat",...
    "LINECOLOR",...
    "LINESTYLE");
dim = size(H);

% shift column
H = [gobjects(dim(1),p.Results.shiftColumn) H];
dim = size(H);

for i = 1:dim(1)
    for j = 1:dim(2)
        if ~isgraphics(H(i,j))
            continue
        end
        h = H(i,j);

        if ~any(contains(p.UsingDefaults,'singleColor'))
            i = p.Results.singleColor(1);
            j = p.Results.singleColor(2);
            if isgraphics(h,"scatter")
                h.MarkerEdgeColor = LINECOLOR(overLoadIndex(i,LINECOLOR(:,1)),...
                    overLoadIndex(j,LINECOLOR(1,:)));
            else
                h.Color = LINECOLOR(overLoadIndex(i,LINECOLOR(:,1)),...
                    overLoadIndex(j,LINECOLOR(1,:)));
            end
        elseif ~any(contains(p.UsingDefaults,'startColor'))
            startColor = p.Results.startColor;
            endColor = p.Results.endColor;
            stepColor = (endColor-startColor)/(dim(1)-1);
            if isgraphics(h,"scatter")
                h.MarkerEdgeColor = startColor+(i-1)*stepColor;
            else
                h.Color = startColor+(i-1)*stepColor;

            end
        else
            if isgraphics(h,"scatter")
                h.MarkerEdgeColor = LINECOLOR(overLoadIndex(i,LINECOLOR(:,1)),...
                overLoadIndex(j,LINECOLOR(1,:)));
            else
                h.Color = LINECOLOR(overLoadIndex(i,LINECOLOR(:,1)),...
                overLoadIndex(j,LINECOLOR(1,:)));
            end
        end
        h.LineWidth = p.Results.width;
        if isgraphics(h,"scatter")
            %%%
        else
            h.LineStyle = LINESTYLE(overLoadIndex(i,LINESTYLE(:,1)),...
                overLoadIndex(j,LINESTYLE(1,:)));
        end

        if isgraphics(h,"scatter")
            h.SizeData = p.Results.MarkerSize;
        else
            h.MarkerSize = p.Results.MarkerSize;
        end
        
        if j == p.Results.priority
            h.LineWidth = h.LineWidth * 1.75;
        end
    end
end

    
end

function iNew = overLoadIndex(i,object)
n = numel(object);

iNew = mod(i,n);
if iNew == 0
    iNew = n;
end

end