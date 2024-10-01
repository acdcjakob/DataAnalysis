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

w = 35;
h = 20;
f = figure("Units","centimeters","Position",[1 1 w*0.6 h*0.6]);
t = tiledlayout(f,2,2,...
    "Units","centimeters",...
    "OuterPosition",[1 1 w/2 h/2],...
    "Padding","tight",...
    "TileSpacing","compact");

label = ["c" "r" "m" "a"];
for i = 1:4
    data{i}((data{i}(:,2)<1),2) = nan;

    ax(i) = nexttile();
    set(ax(i),...
        "LineWidth",1,...
        "box","on",...
        "Fontsize",14,...
        "TitleFontSizeMultiplier",1,...
        "TitleFontWeight","normal",...
        "LabelFontSizeMultiplier",1,...
        "YTick",[])
    hold(ax(i),"on")
    p(i) = plot(ax(i),data{i}(:,1),data{i}(:,2),...
        LineWidth=1,...
        DisplayName=label(i)+"-plane",...
        Color=[217,64,62]/255);
    l(i) = legend;
    axis(ax(i),"tight")
    set(ax(i),"Yscale","log",...
        "YTickLabelMode","auto")
end


xlabel(t,"2\theta (°)")
ylabel(t,"intensity (a.u.)")
fontsize(t,14,"points")

f.Renderer = "painters";
exportgraphics(f,"../plots/TCO/XRDs.eps")