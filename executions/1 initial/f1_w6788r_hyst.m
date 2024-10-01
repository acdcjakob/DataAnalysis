
F = figure("OuterPosition",[100 100 500 500]);
%%

out{1} = rescaleTdH_resistivity("W6788r","vis",true,"filter","hystUp1","xscale","inverse");
ax(1) = gca;

out{2} = rescaleTdH_resistivity("W6788r","vis",true,"filter","hystDown1","xscale","inverse");
ax(2) = gca;

out{3} = rescaleTdH_resistivity("W6788r","vis",true,"filter","origin","xscale","inverse");

n = 1;
    yscale(ax(n),"log")
    axis(ax(n),"padded")
    grid(ax(n),"on")
    set(gca,"FontSize",12)
    ylabel(ax(n),"\rho (\Omega{m})")
    xlabel(ax(n),"T^{-1} (1000/K)")

H = [cellfun(@(x) x, out{1}(:,2)),cellfun(@(x) x, out{2}(:,2))];
HOld = cellfun(@(x) x, out{3}(:,2));
HOld(1).DisplayName = "previous meas. high I_{set}";
HOld(2).DisplayName = "previous meas. low I_{set}";

linePainter(H,"prio",1);
H(3).LineStyle = "none";
H(3).Marker = "o";
H(3).MarkerSize = 15;
H(4).LineStyle = "none";
H(4).Marker = "o";
H(4).MarkerSize = 15;

H(1).DisplayName = "cold to hot, high I_{set}";
H(2).DisplayName = "cold to hot, low I_{set}";
H(3).DisplayName = "hot to cold, high I_{set}";
H(4).DisplayName = "hot to cold, low I_{set}";

legend("Location","eastoutside","FontSize",10)
title("pure Cr2O3 on r-sapphire","FontSize",12)

% normal x axis added
drawnow
n = 1;
thisLim = get(ax(n),"XLim");
xTickNew = get(ax(n),"XTick");
xTickNewLabel = floor(1000./xTickNew);
axTop(n) = axes("Position",get(ax(n),"Position").*[1 1 1 0.01],"Color","none","YTick",[],"XAxisLocation","top");
xlim(axTop(n),get(ax(n),"XLim"))
set(axTop(n),"XTick",xTickNew);
set(axTop(n),"XTickLabel",xTickNewLabel)
% set(axTop(n),"xdir","reverse")
xlabel(axTop(n),"T (K)")

%%
exportgraphics(gcf,"../Plots/Cr2O3/1.1 Pure/1.1-hysteresis_rCut.pdf")
