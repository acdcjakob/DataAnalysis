figure();
SIZE = 500;
set(gcf,"OuterPosition",[100 100 100+SIZE 100+SIZE])
%%

n = 1;
ax(n) = subplot(2,2,n);
out{n} = rescaleTdH_resistivity("W6788c","vis",true,"filter","origin","xscale","inverse");
title(ax(n),"c-plane")
out{n}{1,2}.DisplayName = "high I_{set}";
out{n}{2,2}.DisplayName = "low I_{set}";
l = legend("Location","northwest");
    l.FontSize = 10;

n = 2;
ax(n) = subplot(2,2,n);
out{n} = rescaleTdH_resistivity("W6788m","vis",true,"xscale","inverse");
title(ax(n),"m-plane")

n = 3;
ax(n) = subplot(2,2,n);
out{n} = rescaleTdH_resistivity("W6788r","vis",true,"filter","origin","xscale","inverse");
title(ax(n),"r-plane")

n = 4;
ax(n) = subplot(2,2,n);
out{n} = rescaleTdH_resistivity("W6788a","vis",true,"filter","origin","xscale","inverse");
title(ax(n),"a-plane")

for n = 1:4
    yscale(ax(n),"log")
    ylabel(ax(n),"\rho (\Omega{m})")
    xlabel(ax(n),"T^{-1} (1000/K)")
    axis(ax(n),"padded")
    grid(ax(n),"on")
    set(ax(n),"box","off")
    ax(n).FontSize = 12;
    set(get(ax(n),"Title"),"FontSize",12)
    ax(n).GridLineWidth = .1;
        drawnow

    H = cellfun(@(x) x, out{n}(:,2));
    linePainter(H,"prio",0);
    
end
linkaxes(ax,'y')
for n = 1:4
    % normal temperature
        thisLim = get(ax(n),"XLim");
        xTickNew = get(ax(n),"XTick");
        xTickNewLabel = floor(1000./xTickNew);
        axTop(n) = axes("Position",get(ax(n),"Position").*[1 1 1 0.01],"Color","none","YTick",[],"XAxisLocation","top");
        xlim(axTop(n),get(ax(n),"XLim"))
        set(axTop(n),"XTick",xTickNew);
        set(axTop(n),"XTickLabel",xTickNewLabel)
        xlabel(axTop(n),"T (K)")
        % axTop(n).FontSize = 0.7*get(ax(n),"FontSize");
        drawnow
end



%%
% exportgraphics(gcf,"../Plots/Cr2O3/2.1 Pure/1.1-temperatureDependentHall.png","Resolution",400)
exportgraphics(gcf,"../Plots/Cr2O3/1.1 Pure/1.1-temperatureDependentHall.pdf")