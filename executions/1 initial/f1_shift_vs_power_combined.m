dontAskUser = 1;
dontaskuser = 1;
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))
figure();

%%

Specs_XRD.property1 = "%%$Batch$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_initial$°C";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "shuf";
Specs_XRD.filter = '$-72d';
Specs_XRD.broken = '0';

plotXRD_v3


linePainter(H,"Start",[.2 .6 .6],"End",[.6 .2 .2])
    soll = xline(65.11);
    soll.Color = "k";
    soll.LineStyle = "--";
    soll.LineWidth = 1.8;
    soll.DisplayName = "65.11° (literature)";

ax1 = gca;
ax1.FontSize = 10;
l = legend;
l.FontSize = 8;
%%

ax2 = axes("OuterPosition",[0 .7 .5 .3]);

% -- specs
prompt = {"%%$Batch$NameUnit" , "%%$Cr2O3_initial$°C"};
x_ax = "NameVal";
peakPlanes = "m";
% ---
correlation_peakshift
    xlabel("growth temperature (°C)")
    ylabel("\Delta(30.0) (°)")
    ax2.FontSize = 10;
    axis(ax2,"padded")
    ax2.Color = [.9 .9 .9];
    grid

    % p = get(gca,"Children");
    % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    % pFit.Color = [.7 .2 .2 .6];

    H.MarkerFaceColor = [.5 .2 .2];
    H.MarkerEdgeColor = "k";

%%
b = annotation("textbox");
    b.Position = [.52 .2 0 0];
    b.FitBoxToText = "on";
    b.BackgroundColor = "w";
    b.String = "pure Cr2O3 on m-sapphire";
    b.FontSize = 10;
set(gcf,"OuterPosition",[100 100 500 500])
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_power_combined.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_power_combined.pdf")

