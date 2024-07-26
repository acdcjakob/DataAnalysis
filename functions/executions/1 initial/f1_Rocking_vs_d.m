figure("OuterPosition",[100 100 500 400]);

%%
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
p.SizeData = 150;
p.MarkerEdgeColor = "k";
hold on
    % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    % pFit.Color = [.5 .5 .8 .6];
grid

ylabel("\omega-scan FWHM (°)");
xlabel("thickness (nm)")

title("FWHM_{\omega} vs. d")

set(get(gca,"XAxis"),"FontSize",12)
set(get(gca,"YAxis"),"FontSize",12)
set(get(gca,"Title"),"FontSize",12)
axis padded
b = annotation("textbox");
    b.Position = [0.5132    0.1677    0.3649    0.1018];
    b.FitBoxToText = "on";
    b.BackgroundColor = "w";
    b.String = "pure Cr_2O_3 on m-sapphire";
    b.FontSize = 10;
    b.FaceAlpha = 1;

    fontsize(10,"points")
%%
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-rocking_vs_d.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-rocking_vs_d.png","Resolution",250)