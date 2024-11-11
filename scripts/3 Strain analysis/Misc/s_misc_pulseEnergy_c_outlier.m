Ids = ["W6930c" "W6933c"];

fP = getFilePathsFromId(Ids,"XRD_Omega",".xy");


[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

colMap = flip(cool(numel(fP)));

for i = flip(1:numel(fP))
    T = searchSamples_v2({{'Id',Ids(i)}},true);
    data = getDiffraction(fP{i});
        name = getRocking(T.Id);
    plot(ax,data(:,1),data(:,2),...
        "Color",colMap(i,:)*.8,...
        "LineWidth",1,...
        "DisplayName","FWHM = "+num2str(name*60,"%.0f")+"'");
end

legend("Position",[0.3   0.22    0.2707    0.1]);
grid on
ax.YTickLabel = {};

ylabel('counts (a.u.)')
xlabel('\omega (°)')
yscale log

exportgraphics(fH,"../Plots/Thesis/3/3_misc_pulseOmega_c_outlier.eps")