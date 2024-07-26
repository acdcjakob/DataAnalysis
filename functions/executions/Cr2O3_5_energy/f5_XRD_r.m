dontAskUser = 1;
F = figure("OuterPosition",[100 100 600 500]);
L = {'-2','0','1','2'};
for i = 1:length(L)
    Specs_XRD.property1 = "%%$Batch$Sub$ThetaOmega$NameVal";
    Specs_XRD.value1 = "%%$Cr2O3_energy$r-Al2O3$a$"+L{i};
    Specs_XRD.sortColumn = "d";
    Specs_XRD.sortColumnName = "dUnit";
    Specs_XRD.messung = "XRD_2ThetaOmega";
    Specs_XRD.plotstyle = "all";
    Specs_XRD.filter = '';
    Specs_XRD.broken = '0';

    plotXRD_v3
    Htot{i} = H;
    for j = 1:numel(H)
        this = searchSamples_v2(searchSamplesPrompt(Specs_XRD.property1,Specs_XRD.value1),true);
        this = sortrows(this,"d");
        idx = strfind(H(j).DisplayName,'(');
        if j == 1
            H(j).DisplayName = H(j).DisplayName(1:idx)+energyDensity(L{i},true)+")";
        else
            H(j).DisplayName = H(j).DisplayName(1:idx-1);
        end
    end
    hold on

end
%% L = -2cm
CM = {cool(3)*.9,summer(3)*.9,spring(3)*.9};
S = {0,1,2};
for i = [1,2,3]
    linePainter(Htot{i},"start",CM{i}(1,:),"end",CM{i}(2,:),"shiftColumn",S{i},"width",1.8)
end
% Htot{3}.Color = [0 0 0];
% Htot{3}.LineStyle = ":";

Htot{4}.Color = [.4 .4 .4];
Htot{4}.LineStyle = ":";




grid on
set(gca,"Title",[])
L = get(gca,"Legend");
    L.Title.String = sprintf("thickness (energy density)\nr-oriented Cr2O3");
    L.Location = "eastoutside";

xlim([49 51])
xline(50.2,"DisplayName","reference (02.4)")
exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-XRD_r.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-XRD_r.pdf")
