samTable = searchSamples_v2({{'Id','W6932c'},{'Id','W6931c'}},true);

fP_Omega = getFilePathsFromId(samTable.Id,'XRD_Omega','.xy');

ax = makeLatexSize(.6,1.2);
hold(ax,"on")
ax.ColorOrder = ...
    [.8 0 0;
    0 .8 0];
ax.YScale = "log";
xlabel("\omega (°)")
ylabel("intensity (a.u.)")
ax.YTickLabel = [];

E = [800 300];
for i = 1:2
    omega = getDiffraction(fP_Omega{i});
    plot(ax,omega(:,1),omega(:,2),'-',...
        "DisplayName",energyDensity(-1,1,E(i)),...
        "LineWidth",1);
    hold on
end

legend

exportgraphics(gcf,"../Plots/Thesis/3/3_misc_omegaCPlane.pdf")
grid
