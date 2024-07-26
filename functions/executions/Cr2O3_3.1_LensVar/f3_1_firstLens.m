cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
figure();
set(gcf,"OuterPosition",[100 100 500 500])
%%
Specs_XRD.property1 = "%%$Id%%$Id";
Specs_XRD.value1 = "%%$W6818%%$W6819";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

% ---
plotXRD_v3;
% ---
    ax1 = gca;
    xlim(ax1,[36, 42])
    ax1.FontSize = 10;
    title(ax1,"2\theta-\omega-scan")
    H(1).DisplayName = "-2cm (default)";
%%
P = ax1.Position;
ax2 = axes("Position",[P(1)+0.1*(P(3)-P(1)) P(2)+0.5*(P(4)-P(2)) .3 .4],"Color","none");

Specs_XRD.property1 = "%%$Id%%$Id";
Specs_XRD.value1 = "%%$W6818%%$W6819";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Omega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';
% ---
plotXRD_v3;
% ---
    legend("FWHM: "+string(getRocking("W6819")),"FWHM: "+string(getRocking("W6818")), ...
        "Location","south")
    ax2.FontSize = 9;
    title(ax2,"\omega-scan")

%%
exportgraphics(gcf,"../Plots/Cr2O3/3.1 Lens variation/3.1-firstLens.png","Resolution",400)