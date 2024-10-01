addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis

dontAskUser = 1;
%%
subplot(2,2,1)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$c-Al2O3$mm";
Specs_XRD.sortColumn= "d";
Specs_XRD.sortColumnName= "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{1} = H;
    Ax(1) = gca;
    title("c-orientation")

subplot(2,2,2)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$m-Al2O3$mm";
Specs_XRD.sortColumn= "d";
Specs_XRD.sortColumnName= "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{2} = H;
    Ax(2) = gca;
    title("m-orientation")

subplot(2,2,3)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$r-Al2O3$mm";
Specs_XRD.sortColumn= "d";
Specs_XRD.sortColumnName= "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{3} = H;
    Ax(3) = gca;
    title("r-orientation")

subplot(2,2,4)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$a-Al2O3$mm";
Specs_XRD.sortColumn= "d";
Specs_XRD.sortColumnName= "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{4} = H;
    Ax(4) = gca;
    title("a-orientation")

for n = 1:4
    linePainter(HC{n},"start",[.8 .4 .4],"end",[.4 .4 .8])
    legend(Ax(n),"off")
end
    legend(Ax(1),"show")
    legend(Ax(1),"Position",[0.296098426065085,0.696196103918816,0.216785717282977,0.209761909394037])
    % sgtitle("2\theta-\omega for CuO-doped target")

xlim(Ax(1),[38 43])
xlim(Ax(2),[60 70])
xlim(Ax(3),[23 26])
xlim(Ax(4),[33 39])

%%
set(gcf,"renderer","Painters")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-XRD_CuO_sorted.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-XRD_CuO_sorted.png","Resolution",250)