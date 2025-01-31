Ids = ["W6907a"];
fP = getFilePathsFromId(Ids,"XRD_Omega",".xy");


[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

% colMap = flip(cool(numel(fP)));
colMap = [0 0 0];
for i = flip(1:numel(fP))
    T = searchSamples_v2({{'Id',Ids(i)}},true);
    data = getDiffraction(fP{i});
    plot(ax,data(:,1),data(:,2),...
        "Color",colMap(i,:)*.8,...
        "LineWidth",1,...
        "DisplayName",num2str(T.d,"%.0f")+" nm");
end

% legend("Position",[0.2163    0.5704    0.2707    0.2111]);
leglab = "{\ita}-plane"+newline+...
    energyDensity(T.NameVal{:},true);
legend(leglab,"location","southwest")

grid on
ax.YTickLabel = {};

ylabel('counts (a.u.)')
xlabel('\omega (°)')
% yscale log

exportgraphics(fH,"../Plots/Thesis/3/3_misc_lens_a_weirdOmega.eps")

%%
Ids = ["W6908a" "W6907a" "W6903a" "W6910a"];
fP = getFilePathsFromId(Ids,"XRD_Omega",".xy");


[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

colMap = flip(cool(numel(fP)));
% colMap = [0 0 0];
for i = flip(1:numel(fP))
    T = searchSamples_v2({{'Id',Ids(i)}},true);
    data = getDiffraction(fP{i});
    plot(ax,data(:,1),data(:,2),...
        "Color",colMap(i,:)*.8,...
        "LineWidth",1,...
        "DisplayName",num2str(T.d,"%.0f")+" nm");
end

% legend("Position",[0.2163    0.5704    0.2707    0.2111]);
legend("location","northoutside","NumColumns",2)

grid on
ax.YTickLabel = {};

ylabel('counts (a.u.)')
xlabel('\omega (°)')
yscale log

exportgraphics(fH,"../Plots/Thesis/3/3_misc_lens_a_weirdOmega_thickness.eps")