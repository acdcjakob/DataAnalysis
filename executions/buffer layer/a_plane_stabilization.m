fP(1)=getFilePathsFromId("W6933a",...
        "XRD_2ThetaOmega",".xy");
fP(2)=getFilePathsFromId("W6957a",...
        "XRD_2ThetaOmega",".xy");
fP(3)=getFilePathsFromId("W6959a",...
        "XRD_2ThetaOmega",".xy");

for i = 1:3
    data{i} = getDiffraction(fP{i});
    x{i} = data{i}(:,1);
    y{i} = data{i}(:,2);
end

cs = [[0 0 0; 0 0 1; 1 0 0] [1;1;1]*.8];
name = ["pure Cr_2O_3";...
    "ex-situ Ga_2O_3";...
    "in-situ Ga_2O_3"];

%% Figure

f = figure("Units","centimeters","Position",[4 4 20 15]);
% --- Zoom patches ---
lims = {[33 39] [75 82] [122 124]};
% ---
N = numel(lims);
t = tiledlayout(f,2,N,"Units","centimeters",...
    "TileSpacing","compact",...
    "Padding","tight",...
    "OuterPosition",[2 2 14.64 10]);
xlabel(t,"2\theta (°)")
ylabel(t,"intensity (a.u.)")
ax0 = nexttile(t,1,[1 N]);
for i = 1:3
    p(i) = plot(x{i},y{i},...
        "LineWidth",1, ...
        "Color",cs(i,:), ...
        "DisplayName",name(i));
    hold on;
end
le = legend;
set(gca,...
        "YScale","log",...
        "YTick",[],...
        "LineWidth",1,...
        "FontSize",12);
axis tight
grid on
sgtitle("a-plane "+char(945)+"-Ga_2O_3 on buffer layer Cr_2O_3","Fontweight","bold")
% ylim([1 80e3])
lims0 = axis(ax0);

%% smaller plots


cs2 = jet(N);
for l = 1:N
    pa(l) = patch([lims{l} flip(lims{l})],[lims0(3) lims0(3) lims0(4) lims0(4)],"k");
        pa(l).FaceAlpha = .1;
        pa(l).FaceColor = cs2(l,:);
        pa(l).HandleVisibility = "off";
end

for j = 1:N
    ax(j) = nexttile(t);
    for i = 1:3
        plot(x{i},y{i},...
            "LineWidth",1, ...
            "Color",cs(i,:), ...
            "HandleVisibility","off")
        hold on;
    end
    % legend
    set(gca,...
        "YScale","log",...
        "YTick",[],...
        "LineWidth",1,...
        "Color",[cs2(j,:) .1],...
        "FontSize",10,...
        "MinorGridLineWidth",.75,...
        "XColor",cs2(j,:)*.5);
    grid minor
    grid on
    xlim(lims{j})
    ylim(lims0(3:4))
end



xline(ax(2),get2Theta([2 2 0],"Ga2O3"),":","LineWidth",2,...
    "DisplayName","(22.0) {"+char(945)+"-Ga_2O_3}",...
    "Alpha",1,...
    "Color",[.8 .2 .2]);
xline(ax(2),get2Theta([2 2 0],"Cr2O3"),":","LineWidth",2,...
    "DisplayName","(22.0) {"+char(945)+"-Cr_2O_3}",...
    "Alpha",1,...
    "Color",[.2 .7 .2]);

le2 = legend(ax(2));
le2.FontSize = 10;
le2.Color = "w";
le2.Position = [0.52 .35 .25 .13];

le.FontSize = 10;


exportgraphics(f,"_temp/a-plane_Ga2O3.png","Resolution",400)