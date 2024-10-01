F = figure("OuterPosition",[100 100 500 500],"Name","rate vs pulse number");

samples{1,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","-2"}},true);

samples{2,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","0"}},true);

samples{3,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","1"}},true);

samples{4,1} = searchSamples_v2(...
    {{"Batch","Cr2O3_energy";"NameVal","2"}},true);

rate = cellfun(@(x) growthrateFun(x)*1000,samples,"UniformOutput",false);

% labels = {"-2 cm (default)";"0 cm";"1 cm";"2 cm"};
labels = {energyDensity(-2,true);...
    energyDensity(0,true);...
    energyDensity(1,true);...
    energyDensity(2,true)};

ax1 = axes(F,"OuterPosition",[0 .5 1 .5]);

for n = 1:4
    S(n,1) = scatter(ax1,columnToNumber(samples{n}.Pulses),rate{n},"DisplayName",labels{n});
    S(n).MarkerFaceColor = [.9 .9 .9];
    S(n).SizeData = 70;
    hold on
end
n=3;
S(n).LineWidth = S(n).LineWidth*2;
n=4;
S(n).LineWidth = S(n).LineWidth*2;

hold off

xlabel("number of pulses")
    set(get(gca,"XAxis"),"Exponent",3);
ylabel("growthrate (pm/pulse)")
L = legend;
    % L.Title.String = "Lens position";
    L.Title.String = "energy density";
grid on
linePainter(S,"markersize",50,"width",.8)


% t = annotation("textarrow");
%     t.Position = [0.6883,0.200563288718929,-0.1506,-0.0419];
%     t.String = "?";
%     t.FontWeight = "bold";
%     t.HorizontalAlignment = "left";

% t2 = annotation("arrow");
%     t2.Position = [0.658788505747128,.5+0.387905353728487,0,-0.1136];
% 
% t3 = annotation("textbox");
%     t3.Rotation = 0;
%     t3.BackgroundColor = "w";
%     t3.String = "spot size";
%     t3.EdgeColor = [.75 .75 .75];
%     t3.Position = [0.50728341543514,.5+0.258459655831739,0.1356,0.0641];

Lim1 = axis(ax1);
set(ax1,"YLimMode","manual")
p = patch([15e3 25e3 25e3 15e3],[Lim1(3)-1 Lim1(3)-1 Lim1(4)+1 Lim1(4)+1],"r");
    p.FaceColor = [.6 .3 .9];
    p.EdgeColor = "none";
    p.FaceAlpha = .1;
    p.HandleVisibility = "off";
% %%
% batchNumber = searchSamples_v2(...
%     {{"Batch","Cr2O3_energy";"Sub","c-Al2O3"}},true);
% 
% rateBatch = growthrateFun(batchNumber);
% figure
% plot(rateBatch*1000); % pm
% seq = gca;
%     seq.XTick = 1:numel(batchNumber(:,1));
%     seq.XTickLabel = batchNumber.Id;
%     seq.YLabel.String = "growth rate (pm/pulse)";
% hold on
% yyaxis right
% 
% plot(columnToNumber(batchNumber.NameVal),"s","LineStyle","none","MarkerSize",15)
% set(gca,"YTick",[-2 0 1 2])
% set(gca,"YColor","b")
%%
ax2 = axes(F,"OuterPosition",[0 0 1 .5]);
    ax2.Color = [p.FaceColor p.FaceAlpha];

samples2{1,1} = searchSamples_v2(...
    {{"IdParent","W6905"}},true);

samples2{2,1} = searchSamples_v2(...
    {{"IdParent","W6902"}},true);

samples2{3,1} = searchSamples_v2(...
    {{"IdParent","W6907"}},true);

samples2{4,1} = searchSamples_v2(...
    {{"IdParent","W6908"}},true);

rate2 = cellfun(@(x) mean(growthrateFun(x)*1000),samples2);
rateError2 = cellfun(@(x) std(growthrateFun(x)*1000),samples2);

% lensposition = [-2 0 1 2];
density = [energyDensity(-2);...
    energyDensity(0);...
    energyDensity(1);...
    energyDensity(2)];

hold on
% E = errorbar(ax2,lensposition,rate2,rateError2);
E = errorbar(ax2,density,rate2,rateError2);
    ax2.YLim = Lim1(3:4);
        linkaxes([ax1,ax2],"y");
        axis padded
    % ax2.XTick = lensposition;
        % xlabel("lens position (cm)")
        xlabel("energy density (J/cm^2)")
        ax2.YLabel.String = ax1.YLabel.String;
    grid on
    E.LineWidth = 1;
    E.Color = "k";

ax1.Box = "on";
ax2.Box = "on";

%%
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-growthrates.pdf")
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-growthrates.png","Resolution",400)