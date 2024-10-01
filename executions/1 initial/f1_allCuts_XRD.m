cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))

figure("OuterPosition",[100 100 500 500])
%%
L = ["c";"m";"r";"a"];
Lit = [39.78;65.11;24.48;36.19];
dontaskuser = 1;
dontAskUser = 1;
for n = 1:4
    ax(n) = subplot(2,2,n);
    Specs_XRD.property1 = "%%$Id";
    Specs_XRD.value1 = "%%$W6788"+L(n);
    Specs_XRD.sortColumn = "NameVal";
    Specs_XRD.sortColumnName = "NameUnit";
    Specs_XRD.messung = "XRD_2ThetaOmega";
    Specs_XRD.plotstyle = "s";
    Specs_XRD.filter = '';
    Specs_XRD.broken = '0';

    plotXRD_v3
    H.HandleVisibility = "off";
    hold on
    set(gca,"FontSize",10)
    title(L(n)+"-orientation","FontSize",10)

        p = xline(Lit(n),"k--","LineWidth",.8);
        p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n)));
    legend
    set(gca,"GridLineWidth",.3)
    l = legend;
    l.FontSize = 9;

end
xlim(ax(1),[37 43]);
xlim(ax(2),[63 70]);
xlim(ax(3),[22 27]);
xlim(ax(4),[35 39]);

% sgtitle("Pure Cr_2O_3 on all cuts (2\theta-\omega-scans)")

%%
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-xrd_allCuts.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-xrd_allCuts.pdf")