% c
filePath = getFilePathsFromId("W6788c","XRD_2ThetaOmega",".xy");
data{1} = getDiffraction(filePath{1});
% r
filePath = getFilePathsFromId("W6788r","XRD_2ThetaOmega",".xy");
data{2} = getDiffraction(filePath{1});
% m
filePath = getFilePathsFromId("W6788m","XRD_2ThetaOmega",".xy");
data{3} = getDiffraction(filePath{1});
% a
filePath = getFilePathsFromId("W6788a","XRD_2ThetaOmega",".xy");
data{4} = getDiffraction(filePath{1});

[aTemp,fTemp] = makeLatexSize(1,.5);
border = aTemp.Position; clear aTemp;
fh = figure("Units","centimeters","Position",[1 1 border(3)+4 border(4)+4]);
th = tiledlayout(fh,2,2,...
    "Units","centimeters",...
    "Position",border,...
    "Padding","tight",...
    "TileSpacing","compact");

label = ["c" "r" "m" "a"];
for i = 1:4
    data{i}((data{i}(:,2)<1),2) = nan;

    ax(i) = nexttile();
        hold(ax(i),"on")
    p(i) = plot(ax(i),data{i}(:,1),data{i}(:,2),...
        LineWidth=1,...
        DisplayName="{\it"+label(i)+"}-plane",...
        Color=[217,64,62]/255);

    l(i) = legend;
    axis(ax(i),"tight")
    set(ax(i),"Yscale","log",...
        "YTickLabelMode","auto")

    formatAxes(ax(i));
    set(ax(i),"YTick",[],"XGrid","on");
    lims(i,:) = axis;
end

ylim(ax,[min(lims(:,3)) max(lims(:,4))]);

xlabel(th,"2\theta (°)")
ylabel(th,"counts (a.u.)")

fh.Renderer = "painters";
exportgraphics(fh,"../Plots/Thesis/1/1_W6788_2theta.eps")

% zoom 
arrayfun(@(x) set(x,"Location","northwest"),l)
arrayfun(@(x) set(x,"XGrid","off"),ax)
ax(1).XLim = [35 45];
    xline(ax(1),get2Theta([0 0 6],"Al2O3","WLa1",41.6097),"--",HandleVisibility="off");
    xline(ax(1),get2Theta([0 0 6],"Al2O3","WLa2",41.6097),"--",HandleVisibility="off");
    xline(ax(1),get2Theta([0 0 6],"Al2O3","CuKb",41.6097),HandleVisibility="off");
    % xline(ax(1),get2Theta([0 0 6],"Al2O3","TaLa2",41.6097),"-.",HandleVisibility="off");
ax(2).XLim = [45 55];
    xline(ax(2),get2Theta([0 2 4],"Al2O3","WLa1",52.5013),"--",HandleVisibility="off");
    xline(ax(2),get2Theta([0 2 4],"Al2O3","WLa2",52.5013),"--",HandleVisibility="off");
    xline(ax(2),get2Theta([0 2 4],"Al2O3","CuKb",52.5013),HandleVisibility="off");
    % xline(ax(2),get2Theta([0 2 4],"Al2O3","TaLa2",52.5013),"-.",HandleVisibility="off");
ax(3).XLim = [60 70];
    xline(ax(3),get2Theta([3 0 0],"Al2O3","WLa1",68.164),"--",HandleVisibility="off");
    xline(ax(3),get2Theta([3 0 0],"Al2O3","WLa2",68.164),"--",HandleVisibility="off");
    xline(ax(3),get2Theta([3 0 0],"Al2O3","CuKb",68.164),HandleVisibility="off");
    % xline(ax(3),get2Theta([3 0 0],"Al2O3","TaLa2",68.164),"-.",HandleVisibility="off");
ax(4).XLim = [32 40];
    xline(ax(4),get2Theta([1 1 0],"Al2O3","WLa1",37.7149),"--",HandleVisibility="off");
    xline(ax(4),get2Theta([1 1 0],"Al2O3","WLa2",37.7149),"--",HandleVisibility="off");
    xline(ax(4),get2Theta([1 1 0],"Al2O3","CuKb",37.7149),HandleVisibility="off");
    % xline(ax(4),get2Theta([1 1 0],"Al2O3","TaLa2",37.7149),"-.",HandleVisibility="off");
    ax(4).Legend.Location = "southeast";


exportgraphics(fh,"../Plots/Thesis/1/1_W6788_2theta_zoom.eps")