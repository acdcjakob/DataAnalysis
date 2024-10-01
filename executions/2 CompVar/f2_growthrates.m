batches = "Cr2O3_"+ ...
        ["CuO_CompVar1", "ZnO_CompVar1", "ZnO_CompVar2", "ZnO_PowerVar1"];
titles = ["0.01%-CuO","0.01%-ZnO","1%-ZnO","0.01%-ZnO Temp. Var."];
colors = spring(4);

F = figure("OuterPosition",[100 100 400 700]);

Ids = cell(numel(batches),1);
X = cell(numel(batches),1);
Y = cell(numel(batches),1);

Tiles = tiledlayout(F,numel(batches),1);
ax = gobjects(numel(batches),1);
scPlot = gobjects(numel(batches),1);
linePlot = gobjects(numel(batches),1);

for i = 1:numel(batches)
    Ids{i} = searchSamples_v2(...
            {{'Batch',batches(i)}},...
        true);
    Y{i} = growthrateFun(Ids{i})*1000; % pm pulse^{-1}
    X{i} = columnToNumber(Ids{i}.Number);

    ax(i) = nexttile(Tiles);
    scPlot(i) = scatter(ax(i),X{i},Y{i});
        scPlot(i).MarkerEdgeColor = "k";
        scPlot(i).MarkerFaceColor = colors(i,:);
        scPlot(i).MarkerFaceAlpha = .5;
        scPlot(i).SizeData = 60;
        grid(ax(i),"on")
        title(ax(i),titles(i),"fontsize",8)
        set(ax(i),"XTick",min(X{i}):max(X{i}))
        axis padded
end
linkaxes(ax);
xlabel(Tiles,"#process")
ylabel(Tiles,"growthrate (pm pulse^{-1})")

% process replica
p1 = patch(ax(3),[0.8 1.2 1.2 0.8],[2 2 6 6],'k');
    p1.FaceColor = "none";
    p1.LineWidth = 2;
    p1.EdgeAlpha = .5;
    p1.HandleVisibility = "off";
p2 = patch(ax(3),[4.8 6.2 6.2 4.8],[2 2 6 6],'k');
    p2.FaceColor = "none";
    p2.LineWidth = 2;
    p2.EdgeAlpha = .5;
    p2.DisplayName = "Replica";
    
legend(ax(3),"Position",[0.3535    0.3487    0.2206    0.0272])
    scPlot(3).HandleVisibility = "off";

% cleaning ax1
w1 = xline(ax(1),3.8,"LineWidth",2,"Alpha",.5);
    w1.DisplayName = "window cleaned";
w2 = xline(ax(1),6.8,"LineWidth",2,"Alpha",.5);
    w2.HandleVisibility = "off";

legend(ax(1),"location","south");
    scPlot(1).HandleVisibility = "off";

% cleaning ax2
w3 = xline(ax(2),0.8,"LineWidth",2,"Alpha",.5);
    w3.DisplayName = "window cleaned";
legend(ax(2),"location","south");
    scPlot(2).HandleVisibility = "off";

% cleaning ax4
w4 = xline(ax(4),3.8,"LineWidth",2,"Alpha",.5);
    w4.DisplayName = "window cleaned";
legend(ax(4),"location","north");
    scPlot(4).HandleVisibility = "off";
%%
exportgraphics(F,"../Plots/Cr2O3/2 Doping/2-growthrates_vs_process.pdf")
exportgraphics(F,"../Plots/Cr2O3/2 Doping/2-growthrates_vs_process.png","Resolution",250)