addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
load PLOTCONSTANT

Pure = searchSamples_v2(...
    {{"Batch","Cr2O3_CuO_CompVar1";"Sub","c-Al2O3"},...
    {"Id","W6773"}, ...
    {"Batch","Cr2O3_ZnO_CompVar1";"Sub","c-Al2O3"}},...
    true);
Pure = sortrows(Pure,"Id");
[~,dplc,~] = unique(Pure.Id,"rows");
Pure = Pure(dplc,:);

X_Pure = 1:numel(Pure.Id);

Y_Pure = growthrateFun(Pure)*1000; % pm/pulse

%%

figure

H = plot(X_Pure,Y_Pure,"sq-");
H.DisplayName = sprintf("Doped Cr2O3-Target");
ax1 = gca;
% set(ax1,"Position",get(ax1,"Position")+[0 0 0 -0.1])
% set(ax1,'box','off')


set(get(ax1,"XLabel"),"string","sample Id");
set(get(ax1,"YLabel"),"string","growth rate (pm/pulse)");
set(ax1,"YGrid","on")

set(ax1,"XTick",1:numel(Pure.Id));
set(ax1,"XTickLabel",Pure.Id);

clean1 = xline(.9,"Linewidth",1.5);
clean1.DisplayName = "window cleaned";
clean2 = xline(4.9,"Linewidth",1.5);
clean2.HandleVisibility = "off";
clean3 = xline(7.9,"Linewidth",1.5);
clean3.HandleVisibility = "off";
clean4 = xline(8.9,"Linewidth",1.5);
clean4.HandleVisibility = "off";

legend("Location","southoutside")
title("growth rate depending on chamber usage")
hold off

drawnow
Ly = get(gca,"YLim");
P = patch([1.9 8.1 8.1 1.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"k");
P.DisplayName = "Cr2O3:CuO";
P.FaceAlpha = .05;
P.EdgeAlpha = 0;

P2 = patch([0 1.1 1.1 0],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"g");
P2.DisplayName = "Cr2O3:ZnO";
P2.FaceAlpha = .05;
P2.EdgeAlpha = 0;

P3= patch([8.9 11.1 11.1 8.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"g");
P3.HandleVisibility = "off";
P3.FaceAlpha = .05;
P3.EdgeAlpha = 0;

ylim(Ly)
%xlim([.5 8.5])

linePainter(H);

set(gcf,"name","c-Al2O3")