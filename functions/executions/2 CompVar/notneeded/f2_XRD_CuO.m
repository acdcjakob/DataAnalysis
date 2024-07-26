addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
figure("OuterPosition",[100 100 800 500]);
dontAskUser = 1;
%%
L = ["c";"m";"r";"a"];
Lit = [39.78;65.11;24.48;36.19];
%%
subplot(2,2,1)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$c-Al2O3$mm";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{1} = H;
    Ax(1) = gca;
    title("c-orientation")
        n = 1;
        p = xline(Lit(n),"k--","LineWidth",.8);
        p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n))+"°");

subplot(2,2,2)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$m-Al2O3$mm";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{2} = H;
    Ax(2) = gca;
    title("m-orientation")
        n = 2;
        p = xline(Lit(n),"k--","LineWidth",.8);
        p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n))+"°");

subplot(2,2,3)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$r-Al2O3$mm";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{3} = H;
    Ax(3) = gca;
    title("r-orientation")
        n = 3;
        p = xline(Lit(n),"k--","LineWidth",.8);
        p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n))+"°");

subplot(2,2,4)
Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$a-Al2O3$mm";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
    HC{4} = H;
    Ax(4) = gca;
    title("a-orientation")
        n = 4;
        p = xline(Lit(n),"k--","LineWidth",.8);
        p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n))+"°");

for n = 1:4
    linePainter(HC{n},"start",[.8 .4 .4],"end",[.4 .4 .8])
    if n>1
        for i = 1:numel(HC{n})
            HC{n}(i).HandleVisibility = "off";
        end
    end
end

% sgtitle("2\theta-\omega for CuO-doped target")

xlim(Ax(1),[38 43])
xlim(Ax(2),[60 70])
xlim(Ax(3),[23 26])
xlim(Ax(4),[33 39])

%%
delete(HC{2}(2))
    % only noise
set(gcf,"Renderer","painters")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-XRD_CuO.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-XRD_CuO.png","Resolution",250)

