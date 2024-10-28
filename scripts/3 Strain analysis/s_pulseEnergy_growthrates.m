samTable = searchSamples_v2({{ ...
    'Batch','Cr2O3_energy2'}},true);

[~,iRaw,iNew] = unique(samTable.IdParent);
newSamTable = samTable(iRaw,:);

for i = 1:numel(iRaw)
        idx = iNew==i;
        T = samTable(idx,:);

        g(i) = mean(growthrateFun(T)*1000);
        err_g(i) = std(growthrateFun(T)*1000);
        F(i) = energyDensity(-1,false,newSamTable.NameVal{i});
end

% Plot

[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

scatter(F,g,2*36,...
    "MarkerFaceColor",[1 1 1]*.8,...
    "MarkerEdgeColor","k")

errorbar(F,g,err_g,".k","LineWidth",1)

xlabel("{\itF} (J cm^{-2})")
ylabel("{\itg} (pm pulse^{-1})")

grid on

exportgraphics(fH,"../Plots/Thesis/3/3_pulseEnergy_growthrates.eps")