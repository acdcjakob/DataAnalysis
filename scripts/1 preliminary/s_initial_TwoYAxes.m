% get pressure samples
samTable{1} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','mbar'}},true);
N(1) = numel(samTable{1}.Id);
% get temp samples
samTable{2} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','°C'}},true);
N(2) = numel(samTable{2}.Id);

% get strains and FWHM
x = {nan(N(1),1) nan(N(2),1)}; % [mbar °C]
epsilon = {nan(N(1),1) nan(N(2),1)};
omega = {nan(N(1),1) nan(N(2),1)};
g = {nan(N(1),1) nan(N(2),1)};
for i = 1:2
    % run through Ids:
    x{i} = columnToNumber(samTable{i}.NameVal);
    omega{i} = getRocking(samTable{i}.Id);
    g{i} = getGrowthRate(samTable{i});
    for ii = 1:numel(samTable{i}.Id)
        epsilon{i}(ii) = getPeakShift(...
            samTable{i}(ii,:),"table",true,"relative",true);
    end

end

%% Plotting section

[ax(1),f(1)] = makeLatexSize(.4,.8*.5/.4);
[ax(2),f(2)] = makeLatexSize(.4,.8*.5/.4);

Xlabels = ["{\itp}(O_2) (mbar)" "{\itT} (°C)"];
YLabels = ["\epsilon_{\itzz} (%)" "\omega-FWHM (' arcmin)"];
for i = 1:2
    hold(ax(i),"on")
        xlabel(ax(i),Xlabels(i))

    % strain:
    yyaxis(ax(i),"left")
        sh(1,i) = scatter(ax(i),...
            x{i},epsilon{i}*100,"filled","SizeData",36*2);
        % strain is black:
        ax(i).YColor = "k";
        sh(1,i).MarkerFaceColor = "k";

        ylabel(ax(i),YLabels(1))

    % omega-FWHM:
    yyaxis(ax(i),"right")
        formatAxes(ax(i))
        sh(2,i) = scatter(ax(i),...
            x{i},omega{i}*60,"filled","SizeData",36*2);
        sh(2,i).Marker = ">";
        ylabel(ax(i),YLabels(2))

    grid(ax(i),"on")
end
axis(ax,"padded")
ax(1).XScale = "log";
ax(1).XTick = [1e-4 1e-3 1e-2];

exportgraphics(f(1),"../Plots/Thesis/1/1_pressure_strainOmega.pdf")
exportgraphics(f(2),"../Plots/Thesis/1/1_temperature_strainOmega.pdf")
%% Defense plot

yyaxis(ax(1),"right")
ax(1).YColor = "none";
ax(1).XColor = "k";
delete(sh(2,1))
% exportgraphics(f(1),"../Plots/Thesis/1/DEF1_pressure_strain.pdf")

yyaxis(ax(2),"right")
ax(2).YColor = "none";
ax(2).XColor = "k";
delete(sh(2,2))
% exportgraphics(f(2),"../Plots/Thesis/1/DEF1_temperature_strain.pdf")

%% growth rate section
[ax2(1),f2(1)] = makeLatexSize(.4,.8*.5/.4);
[ax2(2),f2(2)] = makeLatexSize(.4,.8*.5/.4);

Xlabels = ["{\itp}(O_2) (mbar)" "{\itT} (°C)"];
YLabels = "{\itg} (pm pulse^{-1})";
for i = 1:2
    hold(ax2(i),"on")
        xlabel(ax2(i),Xlabels(i))

    sh2(i) = scatter(ax2(i),...
        x{i},g{i}*1000,"s","filled","SizeData",36*2);
    % g is black:
    ax2(i).YColor = "k";
    sh2(i).MarkerFaceColor = "k";

    ylabel(ax2(i),YLabels(1))

    grid(ax2(i),"on")
end
axis(ax2,"padded")
ax2(1).XScale = "log";
ax2(1).XTick = [1e-4 1e-3 1e-2];

exportgraphics(f2(1),"../Plots/Thesis/1/1_pressure_growthrate.pdf")
exportgraphics(f2(2),"../Plots/Thesis/1/1_temperature_growthrate.pdf")