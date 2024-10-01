figure();

sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch","%%$Cr2O3_initial"),true);

sampleTable = sortrows(sampleTable,"d");

for i = 1:numel(sampleTable.Id(:))
    % X(i) = sampleTable.d(i);
    Y(i) = getPeakShift(sampleTable.Id{i});
    X(i) = getRocking(sampleTable.Id{i});
    Id{i} = sampleTable.Id{i};
 end

p = plot(X,Y);
p.LineStyle = "none";
p.LineWidth = 1.8;
p.Marker = "s";
p.Color = [.2 .8 .2];
p.MarkerSize = 10;
hold on
    pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    pFit.Color = [.2 .8 .2 .7];
    pFit.LineWidth = 1;
grid

ylabel("\Delta(30.0) (°)");
xlabel("\omega-scan FWHM (°)")
title("\Delta(30.0) vs. FWHM_\omega")

ax1 = gca;
ax1.FontSize = 10;
%%
b = annotation("textbox");
    b.Position = [0.1453    0.1256    0.3699    0.0641];
    b.FitBoxToText = "on";
    b.BackgroundColor = "w";
    b.String = "pure Cr2O3 on m-sapphire";
    b.FontSize = 10;
set(gcf,"OuterPosition",[100 100 500 500])
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_rocking.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_rocking.pdf")