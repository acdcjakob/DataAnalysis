sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch","%%$Cr2O3_initial"),true);

sampleTable = sortrows(sampleTable,"d");

for i = 1:numel(sampleTable.Id(:))
    X(i) = sampleTable.d(i);
    Y(i) = getRocking(sampleTable.Id{i});
    Id{i} = sampleTable.Id{i};
 end

p = scatter(X,Y);
p.Marker = "s";
p.MarkerFaceColor = [.2 .8 .2];
p.MarkerFaceAlpha = .6;
p.SizeData = 100;
p.MarkerEdgeColor = "k";
hold on
    % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    % pFit.Color = [.5 .5 .8 .6];
grid
p.DisplayName = "initial pure Cr_2O_3 run";

ylabel("\omega-scan FWHM (°)");
xlabel("thickness (nm)")

S = scatter(searchSamples_v2({{"Id","W6788m"}},true).d,getRocking("W6788m"));
S.SizeData = 100;
S.MarkerFaceColor = [1 .3 0];
S.MarkerEdgeColor = [0 0 0];
S.MarkerFaceAlpha = .6;
S.DisplayName = "2nd run (all cuts)";

axis padded
title(" FWHM of \omega-scan vs. thickness")