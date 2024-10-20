samTable{1} = searchSamples_v2(...
    {{"Batch","Cr2O3_CuO_CompVar1";...
    "Sub","c-Al2O3"}},...
    true);

samTable{2} = searchSamples_v2(...
    {{"Batch","Cr2O3_ZnO_CompVar1"; ...
    "NameUnit","mm";...
    "Sub","c-Al2O3"}},...
    true); % don't include the uniformly ablated sample

for i = 1:2
    samTable{i} = sortrows(samTable{i},"Id");
    % [~,dplc,~] = unique(samTable.Id);
    % samTable = samTable(dplc,:);

    x{i} = 1:numel(samTable{i}.Id);
    y{i} = growthrateFun(samTable{i})*1000; % pm/pulse
end

%% plotting section
th = tiledlayout(1,2,...
    "Padding","tight",...
    "TileSpacing","compact");
[~,fh] = makeLatexSize(1,.5,th);

for i = 1:2
    ax(i) = nexttile(th);
    hold(ax(i),"on")
    ph(i) = plot(x{i},y{i},"sq--k","LineWidth",1,"MarkerFaceColor","k",...
        "HandleVisibility","off");
    formatAxes(ax(i));
    set(ax(i),...
        "YGrid","on")
end

% Window cleaning
clean(1) = xline(ax(1),0.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean(1).HandleVisibility = "off";
clean(2) = xline(ax(1),3.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean(2).HandleVisibility = "off";
clean(3) = xline(ax(1),6.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean(3).HandleVisibility = "off";

clean(4) = xline(ax(2),0.9,"LineWidth",1.5,"color",[.1 .1 .5]);
clean(4).DisplayName = "window cleaned";

% Labeling
ax(1).XTick = 1:7;
ax(2).XTick = 1:3;
ax(1).Title.String = "CuO-doped target";
ax(2).Title.String = "ZnO-doped target (L)";
th.XLabel.String = "process";
th.XLabel.FontSize = 12;
th.YLabel.String = "{\itg} (pm pulse^{-1})";
th.YLabel.FontSize = 12;

lh = legend(ax(2));
formatAxes(ax(2));

exportgraphics(fh,"../Plots/Thesis/2/2_doped0.01_window.eps");