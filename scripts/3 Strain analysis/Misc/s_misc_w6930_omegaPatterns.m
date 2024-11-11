Ids = ["W6930c" "W6930r" "W6930m" "W6930a"];
planes = ["c" "m" "r" "a"];
fP = getFilePathsFromId(Ids,"XRD_Omega",".xy");


[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

colMap = flip(jet(numel(fP)));

for i = flip(1:numel(fP))
    T = searchSamples_v2({{'Id',Ids(i)}},true);
    data = getDiffraction(fP{i});
    plot(ax,data(:,1),data(:,2),...
        "Color",colMap(i,:)*.8,...
        "LineWidth",1,...
        "DisplayName",planes(i)+"-plane");
end

l = legend("Position",[0.4884    0.5662    0.2816    0.2111]);
grid on
ax.YTickLabel = {};

ylabel('counts (a.u.)')
xlabel('\omega (°)')
yscale log

exportgraphics(fH,"../Plots/Thesis/3/3_misc_w6930_omega.eps")