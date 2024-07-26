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

Ax.XMinorTick = 'on';
Ax.XTickMode = "manual";
Ax.XTickLabelMode = "manual";
xTickRealMajor = get(Ax,"XTick");
xTickRealMinor = Ax.XRuler.MinorTickValues;
xTickReal = [xTickRealMinor xTickRealMajor];
%xTickReal = xTickRealMinor;
xTickReal = sort(xTickReal);
Ax.XMinorTick = 'off';
xTickNewLabel = xTickReal;

ylimits = Ax.YLim;
Ax.YLimMode = "manual";

patchCut = 0;
%minorTickCut = 0;
height= (ylimits(2)-ylimits(1))*0.01;
for i_cut = 1:n
    % Shift all labels above cutLow+width to the left.
    % Note that this affects only the labels, so 
    % in the next iteration we can again apply this line of code
    xTickNewLabel(xTickNewLabel >= cutLow(i_cut)+width)=...
        xTickNewLabel(xTickNewLabel >= cutLow(i_cut)+width)...
        +(cutHigh(i_cut)-cutLow(i_cut))-width;

    % to avoid that in a small band no tickLabels are visible,
    % we force the first minorTick above cutLow+width to appear as a
    % major tick.
    % minorTickCut = minorTickCut+(cutHigh(i_cut)-cutLow(i_cut))-width;
    % first find this tick
    % firstMinor = xTickRealMinor(find(xTickRealMinor>=cutHigh(i_cut)-minorTickCut,1,'first'));
    % check if there is a major tick before
    % firstMajor = xTickReal(find((xTickReal>=cutHigh(i_cut)-minorTickCut),1,'first'));
    % if firstMinor<firstMajor
    %     % now give this minor tick some appearance
    %     xTickReal = [xTickReal firstMinor];
    %     xTickReal = sort(xTickReal);
    % 
    %     % and give him it's correct value
    %     % but here we have to care to sum up all shifts from before
    %     % this is similiar to patchcut
    % 
    %     firstMinorLabel = firstMinor+minorTickCut;
    %     xTickNewLabel = [xTickNewLabel firstMinorLabel];
    %     xTickNewLabel = sort(xTickNewLabel);
    % end

    % xTickRealCeil = xTickReal+ceil(TickScale*xTickNewLabel)/TickScale-xTickNewLabel;
    % Ax.XTick = xTickRealCeil;
    % Ax.XTickLabel = ceil(TickScale*xTickNewLabel)/TickScale;
    Ax.XTick = xTickReal;
    Ax.XTickLabel = xTickNewLabel;

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
% ceil correct
xTickNewLabelCeil = ceil(xTickNewLabel);
xTickRealCeil = xTickReal+xTickNewLabelCeil-xTickNewLabel;
duplicates = find(~diff(xTickNewLabelCeil));
xTickNewLabelCeil(duplicates)=[];
xTickRealCeil(duplicates)=[];

Ax.XTick = xTickRealCeil;
Ax.XTickLabel = xTickNewLabelCeil;
% change font size of labels
% ERROR potential: oben wurden manche ticks rausgelöscht falls sie beim
% ceiling gedoppelt wurden (0.5 und 1 werden beide zu 1 und das mag XTicks
% gar nicht). Aber hier unten werden jetzt die originalen major ticks
% durchgegangen, aber es kann ja sein dass einer dieser major ticks oben
% gelöscht wurde. out of arrray indexing erors scheinen hier realistisch.
% Deswegen kommentiere ich das mal raus und machs so dass einfach alle 10er
% ticks als groß markiert werden ¯\_(ツ)_/¯
%
% majorTickIndices = find(ismember(xTickReal,xTickRealMajor));
% xTickLabelCurrent = cellstr(get(Ax,'XTickLabel'));
% xTickLabelCell = cell(size(xTickLabelCurrent));
% for i = 1:numel(xTickLabelCurrent)
%     if any(i==majorTickIndices)
%         xTickLabelCell{i} =...
%             sprintf('\\fontsize{%d}%s', 9, xTickLabelCurrent{i});
%     else
%         xTickLabelCell{i} =...
%             sprintf('\\fontsize{%d}%s', 6, xTickLabelCurrent{i});
%     end
% end
% Ax.XTickLabel = xTickLabelCell;

xTickLabelCurrent = cellstr(get(Ax,'XTickLabel'));
xTickNewLabelCurrentNum = str2num(get(Ax,'XTickLabel'));
xTickLabelCell = cell(size(xTickLabelCurrent));
for i = 1:numel(xTickLabelCurrent)
    if mod(xTickNewLabelCurrentNum(i),5*10^gapdim(2))==0
        xTickLabelCell{i} =...
            sprintf('\\fontsize{%d}%s', 9, xTickLabelCurrent{i});
    else
        xTickLabelCell{i} =...
            sprintf('\\fontsize{%d}%s', 6, xTickLabelCurrent{i});
    end
end
Ax.XTickLabel = xTickLabelCell;

end