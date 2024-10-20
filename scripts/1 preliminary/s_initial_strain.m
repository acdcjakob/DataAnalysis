samTable{1} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','mbar'}},true);

samTable{2} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','°C'}},true);

% find strains
% init
x = {nan(numel(samTable{1}.Id,1)) nan(numel(samTable{2}.Id),1)};
y = x;

for i = 1:numel(samTable)
    for ii = 1:numel(samTable{i}.Id)
        x{i}(ii) = columnToNumber(samTable{i}.NameVal{ii});
        y{i}(ii) = getPeakShift(samTable{i}(ii,:),...
            "tableinput",true,"relative",true);
    end
end

% plotting section

[ax(1),fh] = makeLatexSize(.5,.8);
    hold(ax(1),"on")
    % set(get(ax(1),"YAxis"),"exponent",0)
    set(ax(1),"box","off",...
        "XScale","log",...
        "XTick",[1e-4 1e-3 1e-2],...
        "YGrid","on")
    ylabel(ax(1),"\epsilon_{zz} (%)")
    xlabel(ax(1),"O_2 pressure (mbar)")

sh(1) = scatter(ax(1),x{1},y{1}*100,...
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

sh(2) = scatter(ax(2),x{2},y{2}*100,...
    "^","filled",...
    "MarkerFaceColor",[.8 .2 .2],...
    "DisplayName","T_{growth}");

linkaxes(ax,'y');
xlim(ax(2),[720 770])


legend(ax(1),flip(sh),"location","west")

exportgraphics(fh,"../Plots/Thesis/1/1_both_strain.eps")