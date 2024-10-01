dontAskUser = 1;
dontaskuser = 1;
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))
figure("OuterPosition",[100 100 500 500]);

%%

Specs_XRD.property1 = "%%$Batch";
Specs_XRD.value1 = "%%$Cr2O3_initial";
Specs_XRD.sortColumn = "d";
Specs_XRD.sortColumnName = "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "shuf";
Specs_XRD.filter = '$-72d';
Specs_XRD.broken = '0';

plotXRD_v3


linePainter(H,"Start",[.2 .8 .2],"End",[.8 .2 .8])
    peak = getPeakReference();
    soll = xline(peak(2));
    soll.Color = "k";
    soll.LineStyle = "--";
    soll.LineWidth = 1.8;
    soll.DisplayName = num2str(peak(2))+"° (literature)";

ax1 = gca;
    ax1.FontSize = 10;
    l = legend;
    l.FontSize = 8;
%%

ax2 = axes("OuterPosition",[0 .7 .5 .3]);

% -- specs
prompt = {"%%$Batch" , "%%$Cr2O3_initial"};
x_ax = "d";
peakPlanes = "m";
% ---
correlation_peakshift
    xlabel("thickness (nm)")
    ylabel("\Delta(30.0) (°)")
    axis(ax2,"padded")
    ax2.FontSize = 10;
    ax2.Color = [.9 .9 .9];
    grid
    
    p = get(gca,"Children");
    pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
    pFit.Color = [.1 .7 .1 .6];

    H.MarkerFaceColor = [.2 .6 .2];
    H.MarkerEdgeColor = "k";

%%
b = annotation("textbox");
    b.Position = [.52 .2 0 0];
    b.FitBoxToText = "on";
    b.BackgroundColor = "w";
    b.String = "pure Cr2O3 on m-sapphire";
    b.FontSize = 10;
    b.FaceAlpha = 1;
% exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_d_combined.png","Resolution",400)
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-shift_vs_d_combined.pdf")

