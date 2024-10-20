% get samples
samTable = searchSamples_v2({{'Batch','Cr2O3_initial'}},true);

% make unique
[~,uniqIdx] = unique(samTable.Id);
samTable = samTable(uniqIdx,:);

%% get data
% init
N = numel(samTable.Id);
strain = nan(N,1);
FWHM = nan(N,1);
for i = 1:N
    strain(i) = getPeakShift(samTable(i,:),"table",true,"relative",true);
    FWHM(i) = getRocking(samTable.Id{i});
end

%% plot
[ax,fh] = makeLatexSize(.5,1);
    hold(ax,"on")
sh = scatter(strain*100,FWHM*60,"filled");
set(sh,...
    "MarkerFaceColor","k",...
    "marker","sq",...
    "DisplayName","Cr_2O_3 deposition")
% fit
xFit = (.4:.05:1)/100;
p = polyfit(strain,FWHM,1);
yFit = polyval(p,xFit);
plot(xFit*100,yFit*60,"--k","HandleVisibility","off");

xlabel("\epsilon_{zz} (%)")
ylabel("\omega-FWHM (' arcmin)")
lh = legend("Location","northwest");
grid on
formatAxes(ax);

fh.Renderer = "painters";
exportgraphics(fh,"../Plots/Thesis/1/1_initial_strainOmegaCorrelation.eps");