function H = brokenXaxis(data,cutLimits,gapdim)
% data is nx2 cell array with x and y data in each row
% cutpoints = [xlow1,xhigh1;xlow2,xhigh2,...]
% gapdim = [width,height]
width = gapdim(1);
height = gapdim(2);

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
    remove=[];
    for i_cut = 1:n
        % -- sonderfälle --
        leftCut = any( x<=cutLow(i_cut) );
        rightCut = any( x>=cutHigh(i_cut) );
        middleCut = any( x>cutLow(i_cut)&x<cutHigh(i_cut));
        % 2. cut liegt links im rand
        if ~leftCut && rightCut && middleCut
            lowIdx(i_cut) = NaN;
            highIdx(i_cut) = find(x>=cutHigh(i_cut),1,'first');
            remove = [remove,1:highIdx(i_cut)-1];
            cutRange(i_data,i_cut) = x(highIdx(i_cut))-x(1);
            xCutTransformed(highIdx(i_cut):end)=...
                xCutTransformed(highIdx(i_cut):end)...
                -cutRange(i_data,i_cut);
        end
        % 3. cut liegt rechts im rand
        if leftCut && ~rightCut && middleCut
            highIdx(i_cut) = NaN;
            lowIdx(i_cut) = find(x<=cutLow(i_cut),1,'last');
            cutRange(i_data,i_cut) = x(end)-x(lowIdx(i_cut));
            remove = [remove,lowIdx(i_cut)+1:numel(x)];
        end
        % 4. cut liegt mittig
        if leftCut && rightCut && middleCut
            lowIdx(i_cut) = find(x<=cutLow(i_cut),1,'last');
            highIdx(i_cut) = find(x>=cutHigh(i_cut),1,'first');
            remove = [remove,lowIdx(i_cut)+1:highIdx(i_cut)-1];
            cutRange(i_data,i_cut) =...
                (x(highIdx(i_cut))-x(lowIdx(i_cut)))+width;
            xCutTransformed(highIdx(i_cut):end)=...
                xCutTransformed(highIdx(i_cut):end)...
                - cutRange(i_data,i_cut);
            % lowXTransformed(i_cut)=xCutTransformed(highIdx(i_cut))-width;
            % highXTransformed(i_cut)=xCutTransformed(highIdx(i_cut));
        end

        
    end

    % xCutTransformed(remove) = [];
    % y(remove) = [];
    % x(remove) = [];
    % 
    % % --- plot part ---
    % h = plot(xCutTransformed,y,'o--');
    % H(i_data) = h;
    % hold on;
end

% get the current xTicks
Ax = gca;
Ax.XTickMode = "manual";
Ax.XTickLabelMode = "manual";
xTickOld = get(Ax,"XTick");
grid minor
xTickNew = xTickOld;
for i = 1:n
    xTickNew(xTickOld>=highXTransformed(i))=...
        xTickNew(xTickOld>=highXTransformed(i))...
        +cutHigh(i)-cutLow(i)-width;
    Ax.XTickLabel = xTickNew;
end
xTickOld = xTickOld + ceil(xTickNew)-xTickNew;
Ax.XTick = xTickOld;
Ax.XTickLabel = ceil(xTickNew);
for i =1:n
    % --- axis style part ---
    limits = get(gca,"YLim");
    set(gca,"YLimMode","manual");
    yLimLow = limits(1); clear limits;    
    verticesX = [lowXTransformed(i),...
        highXTransformed(i),...
        highXTransformed(i),...
        lowXTransformed(i)];
    verticesY = [yLimLow-height*0.1,...
        yLimLow-height*0.1,...
        yLimLow+height*0.5,...
        yLimLow+height*0.5];

    p = patch(verticesX,verticesY,"w","clipping","off","edgecolor","none");
    p.HandleVisibility = "off";
    l1 = line([lowXTransformed(i)-0.1*width lowXTransformed(i)+0.1*width],...
        [yLimLow-height yLimLow+height],...
        'clipping','off');
    l1.Color = "k";
    l1.LineWidth = 1;
    l1.HandleVisibility = "off";
    l2 = line([highXTransformed(i)-0.1*width highXTransformed(i)+0.1*width],...
        [yLimLow-height yLimLow+height],...
        'clipping','off');
    l2.Color = "k";
    l2.LineWidth = 1;
    l2.HandleVisibility = "off";

    % Ax.XTick = xTickNew;
    % Ax.XTickLabel = ceil(xTickNewLabel);

    % grid
end
hold off
end