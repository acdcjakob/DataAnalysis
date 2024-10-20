samTable = searchSamples_v2(...
    {{"Batch","Cr2O3_initial"}},...
    true);
samTable = sortrows(samTable,"Id");
[~,dplc,~] = unique(samTable.Id);
samTable = samTable(dplc,:);

x = 1:numel(samTable.Id);

y = growthrateFun(samTable)*1000; % pm/pulse

%%
[ax,fh] = makeLatexSize(.51,1*.5/.51);
    hold(ax,"on")
ph = plot(x,y,"sq--k","LineWidth",1,"MarkerFaceColor","k");
ph.DisplayName = "Cr_2O_3 deposition";
axis padded;
% set(ax1,"Position",get(ax1,"Position")+[0 0 0 -0.1])
% set(ax1,'box','off')


set(get(ax,"XLabel"),"string","process order");
set(get(ax,"YLabel"),"string","{\itg} (pm pulse^{-1})");
set(ax,"YGrid","on")

set(ax,"XTick",1:numel(samTable.Id));
set(ax,"XTickLabel",samTable.Id);


clean1 = xline(0.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean1.DisplayName = "window cleaned";
clean2 = xline(4.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean2.HandleVisibility = "off";

% drawnow
% Ly = get(gca,"YLim");
% P = patch([0.9 4.1 4.1 0.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"k");
% P.DisplayName = "oxygen pressure";
% P.FaceAlpha = .05;
% P.EdgeAlpha = 0;
% 
% P2 = patch([4.9 6.1 6.1 4.9],[Ly(1)-1 Ly(1)-1 Ly(2)+1 Ly(2)+1],"r");
% P2.DisplayName = "growth temperature";
% P2.FaceAlpha = .05;
% P2.EdgeAlpha = 0;
% 
% ylim(Ly)
% xlim([0.5 6.5])

% l = legend("Location","southoutside","NumColumns",2);
lh = legend("Location","northwest");
    formatAxes(ax);

exportgraphics(fh,"../Plots/Thesis/1/1_initial_window.eps")