cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))

F = figure("OuterPosition",[100 100 500 500]);
%%
L = ["c";"m";"r";"a"];
dontaskuser = 1;
dontAskUser = 1;
for n = 1:4
    ax(n) = subplot(2,2,n);
    Specs_XRD.property1 = "%%$Id";
    Specs_XRD.value1 = "%%$W6788"+L(n);
    Specs_XRD.sortColumn = "NameVal";
    Specs_XRD.sortColumnName = "NameUnit";
    Specs_XRD.messung = "XRD_Omega";
    Specs_XRD.plotstyle = "s";
    Specs_XRD.filter = '';
    Specs_XRD.broken = '0';

    plotXRD_v3
    title(L(n)+"-orientation")
    FWHM = getRocking("W6788"+L(n));
    legend("FWHM: "+string(FWHM)+"°","Location","southeast","FontSize", 10)
    axis tight
    linePainter(get(gca,"Children"),"single",[2,1]);
end

%%

exportgraphics(F,"../Plots/Cr2O3/1 initial/1.1_rocking_allCuts.pdf")
exportgraphics(F,"../Plots/Cr2O3/1 initial/1.1_rocking_allCuts.png","Resolution",250)