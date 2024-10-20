samTable{1} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','mbar'}},true);

samTable{2} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','°C'}},true);

% find growthrates
% init
x = cell(1,2);
y = x;

for i = 1:numel(samTable)
    x{i} = columnToNumber(samTable{i}.NameVal);
    y{i} = getGrowthRate(samTable{i}); % nm per pulse
end

% plotting section

[ax(1),fh] = makeLatexSize(.5,.8);
    hold(ax(1),"on")
    % set(get(ax(1),"YAxis"),"exponent",0)
    set(ax(1),"box","off",...
        "XScale","log",...
        "XTick",[1e-4 1e-3 1e-2],...
        "YGrid","on")
    ylabel(ax(1),"{\itg} (pm pulse^{-1})")
    xlabel(ax(1),"O_2 pressure (mbar)")

sh(1) = scatter(ax(1),x{1},y{1}*1e3,...
    "v","filled",...
    "MarkerFaceColor",[.2 .2 .8],...
    "DisplayName","O_2 pressure");

ax(2) = axes("Units","centi","Position",ax(1).Position,...
    "Color","none",...
    "YAxisLocation","right",...
    "YTickLabel",[],...
    "XAxisLocation","top");

    hold(ax(2),"on")
    formatAxes(ax(2))
    set(ax(2),"box","off")
    xlabel(ax(2),"T_{growth} (°C)")

sh(2) = scatter(ax(2),x{2},y{2}*1e3,...
    "^","filled",...
    "MarkerFaceColor",[.8 .2 .2],...
    "DisplayName","T_{growth}");

linkaxes(ax,'y');
xlim(ax(2),[720 770])

lh = legend(ax(2),flip(sh),"location","best");
    lh.Position = [0.438604539724510   0.511278989529655   0.303271032426959   0.143125674445442];
    lh.Color = "w";
    formatAxes(ax(1))
    % again because of resetting by formatAxes
    set(ax(1),"box","off",...
        "XScale","log",...
        "XTick",[1e-4 1e-3 1e-2],...
        "YGrid","on")

exportgraphics(fh,"../Plots/Thesis/1/1_both_growthrate.eps")