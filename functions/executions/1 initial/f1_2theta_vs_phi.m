dontAskUser = 1;
dontaskuser = 1;

figure("OuterPosition",[100 100 500 500]);
phi = ["\phi=0°";"\phi=180°";"\phi=270°";"\phi=90°"];
%%

Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6715";
Specs_XRD.sortColumn = "d";
Specs_XRD.sortColumnName = "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "allt";
Specs_XRD.filter = '$phi';
Specs_XRD.broken = '';

plotXRD_v3
for n = 2:4
    H(n).DisplayName = phi(n);
end
H(1).DisplayName = "W6715 "+phi(1)+" (215nm)";
CS = summer(2)*.7;
linePainter(H,"start",CS(1,:),"end",CS(2,:))
hold on
% ---
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6716";
Specs_XRD.sortColumn = "d";
Specs_XRD.sortColumnName = "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "allt";
Specs_XRD.filter = '$phi';
Specs_XRD.broken = '';

plotXRD_v3
for n = 2:4
    H(n).DisplayName = phi(n);
end
H(1).DisplayName = "W6716 "+phi(1)+" (155nm)";
%%
CS = cool(2)*.8;
linePainter(H,"shiftColumn",1,"start",CS(1,:),"end",CS(2,:))
title("2\theta-\omega-scans around (30.0) for different rotations (\phi)"+...
    sprintf("\nBoth samples have inclined film"),"Interpreter","tex")
xlim([63 67])
grid(gca,"on")
fontsize(10,"points")

%%
fontsize(10,"points")
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-2theta_vs_phi.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-2theta_vs_phi.png","Resolution",300)