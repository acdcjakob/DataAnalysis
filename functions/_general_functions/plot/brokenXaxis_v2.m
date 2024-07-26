function H = brokenXaxis_v2(data,cutLimits,gapdim)
% data is nx2 cell array with x and y data in each row
% cutpoints = [xlow1,xhigh1;xlow2,xhigh2,...]
% gapdim = [width,TickScale]
% TickScale = 1 -> only integer
% TickScale = 2 -> only 10,20,30 etc.
% TickScale = -2 -> 0.01, 0.03 etc.
if nargin == 1
    H = gobjects();
    for i = 1:numel(data(:,1))
        H(i) = plot(data{i,1},data{i,2});
        hold on
    end
    return
end
width = gapdim(1);
TickScale = 10^(-1*gapdim(2));

cutLow = cutLimits(:,1);
cutHigh = cutLimits(:,2);
n = size(cutLimits,1);

% prepare x-y data for all inputs
H = gobjects();
for i_data = 1:size(data,1)
    % get data and make column vector
    x = data{i_data,1};
        if isrow(x), x=x'; end
    y = data{i_data,2};
        if isrow(y), y=y'; end
    % start with very left data
    xCutTransformed = x;
    remove=zeros(numel(x),1);
    for i_cut = 1:n

        remove = remove | (x>cutLow(i_cut))&(x<cutHigh(i_cut));
        xCutTransformed(x>=cutHigh(i_cut))=...
            xCutTransformed(x>=cutHigh(i_cut))...
            -(cutHigh(i_cut)-cutLow(i_cut))...
            +width;
    end
    xCut = x;
    xCut(remove) = [];
    xCutTransformed(remove) = [];
    yCut = y;
    yCut(remove) = [];
    if isempty(xCut)
        H(i_data) = plot(NaN,NaN);
        hold on
    else
        H(i_data) = plot(xCutTransformed,yCut,'s');hold on
    end
end

% get the current xTicks
drawnow
    % this is not ideal i guess, takes longer than inserting something like
    % pause(0.0001).
Ax = gca;
grid


Ax.XTickMode = "manual";
Ax.XTickLabelMode = "manual";
xTickReal = get(Ax,"XTick");
Ax.XMinorTick = 'off';
xTickNewLabel = xTickReal;

ylimits = Ax.YLim;
Ax.YLimMode = "manual";

patchCut = 0;
height= (ylimits(2)-ylimits(1))*0.02;
for i_cut = 1:n
    % Shift all labels above cutLow+width to the left.
    % Note that this affects only the labels, so 
    % in the next iteration we can again apply this line of code
    xTickNewLabel(xTickNewLabel >= cutLow(i_cut)+width)=...
        xTickNewLabel(xTickNewLabel >= cutLow(i_cut)+width)...
        +(cutHigh(i_cut)-cutLow(i_cut))-width;

    
    xTickRealCeil = xTickReal+ceil(TickScale*xTickNewLabel)/TickScale-xTickNewLabel;
    Ax.XTick = xTickRealCeil;
    Ax.XTickLabel = ceil(TickScale*xTickNewLabel)/TickScale;


    vertexLeft = cutLow(i_cut)-patchCut;
    vertexRight = cutLow(i_cut)+width-patchCut;
    p = patch([vertexLeft,...
        vertexRight,...
        vertexRight,...
        vertexLeft],...
        [ylimits(1),...
        ylimits(1),...
        ylimits(1)+height,...
        ylimits(1)+height],...
        "w");
    p.EdgeColor = "none";
    p.Clipping = "off";
    p.HandleVisibility = "off";
    
    q = patch([vertexLeft,...
        vertexRight,...
        vertexRight,...
        vertexLeft],...
        [ylimits(1),...
        ylimits(1),...
        ylimits(2),...
        ylimits(2)],...
        "w");
    q.FaceColor = [.9 .9 .9];
    q.FaceAlpha = .5;
    q.EdgeColor = "none";
    q.HandleVisibility = "off";
    
    l1 = plot([vertexLeft-width/5,...
        vertexLeft+width/5],...
        [ylimits(1)-height,ylimits(1)+height]);
    l1.Color = "k";
    l1.LineWidth = 1.5;
    l1.Clipping = "off";
    l1.HandleVisibility = "off";

    l2 = plot([vertexRight-width/5,...
        vertexRight+width/5],...
        [ylimits(1)-height,ylimits(1)+height]);
    l2.Color = "k";
    l2.LineWidth = 1.5;
    l2.Clipping = "off";
    l2.HandleVisibility = "off";

    patchCut = patchCut + cutHigh(i_cut)-cutLow(i_cut) - width;
end



end