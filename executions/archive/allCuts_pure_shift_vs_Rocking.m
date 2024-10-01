addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))

sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch","%%$Cr2O3_Pure"),true);

sampleTable = sortrows(sampleTable,"d");

for i = 1:numel(sampleTable.Id(:))
    Y(i) = getRocking(sampleTable.Id{i});
    Id{i} = sampleTable.Id{i};
 end

p = scatter(columnToNumber(sampleTable.d));
p.Marker = "s";
p.MarkerFaceColor = [.2 .8 .2];
p.MarkerFaceAlpha = .6;
p.SizeData = 100;
p.MarkerEdgeColor = "k";
hold on
    % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    % pFit.Color = [.5 .5 .8 .6];
grid

ylabel("\omega-scan FWHM (°)");
xlabel("thickness (nm)")

title(" FWHM of \omega-scan vs. thickness")