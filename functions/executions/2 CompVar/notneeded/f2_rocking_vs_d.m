F = figure("OuterPosition",[100 100 500 500]);
%%
sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch$Omega","%%$Cr2O3_CuO_CompVar1$a"),true);

sampleTable = sortrows(sampleTable,"d");

for i = 1:numel(sampleTable.Id(:))
    X(i) = sampleTable.d(i);
    Y(i) = getRocking(sampleTable.Id{i});
    Id{i} = sampleTable.Id{i};
 end

p = scatter(X,Y);
p.Marker = "s";
p.MarkerFaceColor = "k";
p.MarkerFaceAlpha = .6;
p.SizeData = 150;
p.MarkerEdgeColor = "k";
p.DisplayName = "CuO-target on c-sapphire";
hold on
    pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    pFit.Color = [0 0 0 .6];
    pFit.HandleVisibility = "off";
%%
sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch$Omega","%%$Cr2O3_ZnO_CompVar1$a"),true);

sampleTable = sortrows(sampleTable,"d");
X = [];
Y = [];
for i = 1:numel(sampleTable.Id(:))
    X(i) = sampleTable.d(i);
    Y(i) = getRocking(sampleTable.Id{i});
    Id{i} = sampleTable.Id{i};
 end

p = scatter(X,Y);
p.Marker = "s";
p.MarkerFaceColor = "r";
p.MarkerFaceAlpha = .6;
p.SizeData = 150;
p.MarkerEdgeColor = "r";
p.DisplayName = "ZnO-target on c-sapphire";
hold on
    pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    pFit.Color = [1 0 0 .6];
    pFit.HandleVisibility = "off";

    
ax = gca;
grid on
    ax.FontSize = 12;

ylabel("\omega-scan FWHM (°)");
xlabel("thickness (nm)")
legend("Location","northwest","FontSize",10)
title(" FWHM of \omega-scan vs. thickness","FontSize",10)

%%

exportgraphics(F,"../Plots/Cr2O3/2 CompVar/2-rocking_vs_d.pdf")