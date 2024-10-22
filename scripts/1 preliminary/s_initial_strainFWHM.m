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
    g(i) = growthrateFun(samTable(i,:))*1000; % pm / pulse
end

%% plot
[ax,fh] = makeLatexSize(.5,1);
    hold(ax,"on")
% prepare color thing
colMap = copper;
colIdx = floor(rescale(g)*255)+1;
sh = scatter(strain*100,FWHM*60,2*36,...
    colMap(colIdx,:),...
    "filled");
set(sh,...
    "MarkerEdgeColor","w",...
    "marker","sq",...
    "DisplayName","Cr_2O_3 deposition")
set(ax,"Colormap",colMap)
cb = colorbar();
cb.Label.String = "{\itg} (pm pulse^{-1})";
cb.Label.FontSize = 12;
clim(ax,[min(g) max(g)])
% fit
xFit = (.4:.05:1)/100;
p = polyfit(strain,FWHM,1);
yFit = polyval(p,xFit);
plot(xFit*100,yFit*60,"--k","HandleVisibility","off");

xlabel("\epsilon_{zz} (%)")
ylabel("\omega-FWHM (' arcmin)")
% lh = legend("Location","northwest");
grid on
formatAxes(ax);

fh.Renderer = "painters";
exportgraphics(fh,"../Plots/Thesis/1/1_initial_strainOmegaCorrelation.eps");