sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch$NameUnit","%%$Cr2O3_initial$W"),true);

sampleTable = sortrows(sampleTable,"NameVal");
X = columnToNumber(sampleTable.NameVal);
Y = getRocking(sampleTable.Id);


% for i = 1:numel(sampleTable.Id(:))
%     X(i) = columnToNumber(sampleTable.NameVal(i));
%     Y(i) = getRocking(sampleTable.Id{i});
%     Id{i} = sampleTable.Id{i};
%  end

p = scatter(X,Y);
p.Marker = "s";
p.MarkerFaceColor = [.8 .2 .2];
p.MarkerFaceAlpha = .6;
p.SizeData = 100;
p.MarkerEdgeColor = "k";
hold on
    % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    % pFit.Color = [.5 .5 .8 .6];
grid

ylabel("\omega-scan FWHM (°)");
xlabel("psubstrate heater power (W)")

title("FWHM of \omega-scan vs. substrate heater power")