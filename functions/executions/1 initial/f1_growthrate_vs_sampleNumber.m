addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
load PLOTCONSTANT
F = figure("OuterPosition",[100 100 500 500]);
%%
Pure = searchSamples_v2(...
    {{"Batch","Cr2O3_initial"}},...
    true);
Pure = sortrows(Pure,"Id");
[~,dplc,~] = unique(Pure.Id,"rows");
Pure = Pure(dplc,:);

X_Pure = 1:numel(Pure.Id);

Y_Pure = growthrateFun(Pure)*1000; % pm/pulse

%%


H = plot(X_Pure,Y_Pure,"sq-");
H.DisplayName = "Pure Cr_2O_3";
ax1 = gca;
axis padded;
% set(ax1,"Position",get(ax1,"Position")+[0 0 0 -0.1])
% set(ax1,'box','off')


set(get(ax1,"XLabel"),"string","Sample Id (fabrication order)");
set(get(ax1,"YLabel"),"string","growth rate (pm/pulse)");
set(ax1,"YGrid","on")

set(ax1,"XTick",1:numel(Pure.Id));
set(ax1,"XTickLabel",Pure.Id);


clean1 = xline(0.9,"LineWidth",1.5);
clean1.DisplayName = "window cleaned";
clean2 = xline(4.9,"LineWidth",1.5);
clean2.HandleVisibility = "off";

drawnow
Ly = get(gca,"YLim");
P = patch([0.9 4.1 4.1 0.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"k");
P.DisplayName = "oxygen pressure";
P.FaceAlpha = .05;
P.EdgeAlpha = 0;

P2 = patch([4.9 6.1 6.1 4.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"r");
P2.DisplayName = "growth temperature";
P2.FaceAlpha = .05;
P2.EdgeAlpha = 0;

ylim(Ly)
xlim([0.5 6.5])

l = legend("Location","southoutside","NumColumns",2);

hold off

linePainter(H);
fontsize(10,"points")
%%
exportgraphics(F,"../Plots/Cr2O3/1 initial/1-growthrate_vs_sampleNumber.pdf")
exportgraphics(F,"../Plots/Cr2O3/1 initial/1-growthrate_vs_sampleNumber.png","Resolution",250)