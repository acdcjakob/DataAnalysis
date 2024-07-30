F = figure("OuterPosition",[100 100 500 500]);
fs = 9;

% lower axis for a-constants
ax(1) = axes(F,"OuterPosition",[0 0 1 .5]);

% upper axis for c-constants
ax(2) = axes(F,"OuterPosition",[0 .5 1 .5],...
    "XAxisLocation","top");

axisLabels = ["a","c"];
Refs = [4.96,13.59]; % lattice literature constants

for i = 1:2
    hold(ax(i),"on")
    l(i) = legend(ax(i),"FontSize",fs,"Location","northeast");
    yline(ax(i),Refs(i),"--b","DisplayName",...
        axisLabels(i)+"-literature Cr2O3")
    ylabel(ax(i),axisLabels(i)+"-constant ("+char(197)+")",...
        "FontSize",fs+3);
    xlabel(ax(1),"Laser energy density (J cm^{-2})",...
        "FontSize",fs+2)
end
l(1).Position = [0.596743273959092,0.158341013758196,0.30254516071091,0.195745702250282];

% --- data ---
samples = searchSamples_v2(...
    {{'Batch','Cr2O3_energy2';'RSM','a';'Sub','m-Al2O3'}},true);

% --- create x- and y-data ---
X = nan(numel(samples.Id),1);
Y = nan(numel(samples.Id),4);
for j = 1:numel(samples.Id)
    X(j,1) = energyDensity(-1,false,samples.NameVal{j});
    lat = getRSMLattice(samples(j,:))*10; % in angstrom
    Y(j,1) = lat(1);
    Y(j,2) = lat(2);
    Y(j,3) = lat(3);
    Y(j,4) = lat(4);
end

[~,sortIdx] = sortrows(X);

plot(ax(1),sort(X),Y(sortIdx,1),"k--",HandleVisibility="off")
scatter(ax(1),sort(X),Y(sortIdx,1),"k^",...
    MarkerFaceColor = "g",...
    MarkerFaceAlpha = .4,...
    DisplayName = "a_{out} (|| to c-axis)",...
    SizeData = fs*8)
plot(ax(2),sort(X),Y(sortIdx,2),"k--",HandleVisibility="off")
scatter(ax(2),sort(X),Y(sortIdx,2),"ko",...
    MarkerFaceColor = "g",...
    MarkerFaceAlpha = .4,...
    DisplayName = "c_{in} (|| to c-axis)",...
    SizeData = fs*8)
plot(ax(1),sort(X),Y(sortIdx,3),"k--",HandleVisibility="off")
scatter(ax(1),sort(X),Y(sortIdx,3),"k^",...
    MarkerFaceColor = "r",...
    MarkerFaceAlpha = .4,...
    DisplayName = "a_{out} (\perp to c-axis)",...
    SizeData = fs*8)
plot(ax(1),sort(X),Y(sortIdx,4),"k--",HandleVisibility="off")
scatter(ax(1),sort(X),Y(sortIdx,4),"k>",...
    MarkerFaceColor = "r",...
    MarkerFaceAlpha = .4,...
    DisplayName = "a_{in} (\perp to c-axis)",...
    SizeData = fs*8)

linkaxes(ax,'x');
grid(ax,"on")
axis(ax,"padded")

exportgraphics(F,"../Plots/Cr2O3/5 energy/5-RSM_terminal_m.pdf")
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-RSM_terminal_m.png","Resolution",250)