samTable{1,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","-2"}},true);

samTable{2,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","0"}},true);

samTable{3,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","1"}},true);

samTable{4,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","2"}},true);

N = numel(samTable);
g = cell(N,1);
err_g = cell(N,1);
F = g;
newSamTable = cell(N,1);
for i = 1:N
    % make unique
    [~,iRaw,iNew] = unique(samTable{i}.IdParent);
    newSamTable{i} = samTable{i}(iRaw,:);
    for ii = 1:numel(iRaw)
        idx = iNew==ii;
        T = samTable{i}(idx,:);

        g{i}(ii) = mean(growthrateFun(T)*1000);
        err_g{i}(ii) = std(growthrateFun(T)*1000);
        F{i}(ii) = energyDensity(newSamTable{i}.NameVal{ii});
    end
end

% 
% g = cellfun(@(x) growthrateFun(x)*1000,samTable,...
%     "UniformOutput",false);

labels = {energyDensity(-2,true);...
    energyDensity(0,true);...
    energyDensity(1,true);...
    energyDensity(2,true)};

%% Plotting section
tileH = tiledlayout(2,1,"TileSpacing","compact","Padding","tight");

[tileH,fH] = makeLatexSize(.8,.7/.8,tileH);
fH.Position = fH.Position+[0 0 2 0]; %make space for colorbar

%% Plot overview

ax(1) = nexttile();
    formatAxes(ax(1));
    hold(ax(1),"on");
% init
scH = gobjects(N,1);
erH = scH;
% init color
colMap = cool;
    colLim = [min([F{:}]) max([F{:}])];
    set(ax(1),...
        "Colormap",colMap,...
        "CLim",colLim)
    set(get(ax(1),"XAxis"),...
        "Exponent",3)
    cb = colorbar(ax(1));
        cb.FontSize = 10;
        cb.Label.FontSize = 12;
        cb.Layout.Tile = "east";

for i = 1:N
    P = columnToNumber(newSamTable{i}.Pulses);
    
    % get colIdx
    colIdx = 1+floor(255*rescale(F{i},...
        'inputmin',colLim(1),...
        'inputmax',colLim(2)));

    scH(i) = scatter(ax(1),P,g{i},...
        2*36,colMap(colIdx,:),...
        "filled",...
        "MarkerEdgeColor","k",...
        "SizeData",2*36,...
        "DisplayName",labels{i});
    erH(i) = errorbar(ax(1),P,g{i},err_g{i},...
        '.',"LineWidth",1,...
        "Color",[1 1 1]*.1);
end

%% plot zoom
ax(2) = nexttile();
    formatAxes(ax(2));
    hold(ax(2),"on");

% constraints and patch on ax1
drawnow;
pulseLim = [15e3 25e3];
ax1Lim = axis(ax(1));

p = patch(ax(1),...
    [pulseLim(1) pulseLim(2) pulseLim(2) pulseLim(1)],...
    [ax1Lim(3) ax1Lim(3) ax1Lim(4) ax1Lim(4)],"r");
    p.FaceColor = [.6 .9 .3];
    p.EdgeColor = "none";
    p.FaceAlpha = .1;
    p.HandleVisibility = "off";

    ax(2).Color = [p.FaceColor p.FaceAlpha];

scH2 = gobjects(N,1);
erH2 = scH;

for i = 1:N
    check = arrayfun( ...
        @(x) x>= pulseLim(1) & x<= pulseLim(2),...
        newSamTable{i}.Pulses);

    x = F{i}(check);
    y = g{i}(check);
    err_y = err_g{i}(check);

    % get colIdx
    colIdx = 1+floor(255*rescale(x,...
        'inputmin',colLim(1),...
        'inputmax',colLim(2)));

    scH2(i) = scatter(ax(2),x,y,...
        2*36,colMap(colIdx,:),...
        "filled",...
        "MarkerEdgeColor","k",...
        "SizeData",2*36,...
        "DisplayName",labels{i});
    erH2(i) = errorbar(ax(2),x,y,err_y,...
        '.',"LineWidth",1,...
        "Color",[1 1 1]*.1);
end

linkaxes(ax,'y');

xlabel(ax(1),"# pulses")
xlabel(ax(2),"{\itF} (J cm^{-2})");
ylabel(tileH,"{\itg} (pm pulse^{-1})")
cb.Label.String = "{\itF} (J cm^{-2})";

grid(ax,"on")

exportgraphics(fH,"../Plots/Thesis/3/3_lensPos_growthrates.pdf")
