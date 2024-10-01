dontAskUser = 1;
F = figure("OuterPosition",[100 100 800 500]);
L = {'-2','0','1','2'};
ax{1} = axes("OuterPosition",[0,0,.3,.9]);
ax{2} = axes("OuterPosition",[1/3,0,.3,.9]);
ax{3} = axes("OuterPosition",[2/3,0,.3,.9]);
ax{4} = ax{3};
for i = 1:length(L)
    Specs_XRD.property1 = "%%$Batch$Sub$ThetaOmega$NameVal";
    Specs_XRD.value1 = "%%$Cr2O3_energy$c-Al2O3$a$"+L{i};
    Specs_XRD.sortColumn = "d";
    Specs_XRD.sortColumnName = "dUnit";
    Specs_XRD.messung = "XRD_2ThetaOmega";
    Specs_XRD.plotstyle = "all";
    Specs_XRD.filter = '';
    Specs_XRD.broken = '0';
    set(F,'CurrentAxes',ax{i});
    plotXRD_v3
    fontsize(gca,10,"points")
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
    if i ~= 3
        xline(39.78,"DisplayName","reference (00.6)","LineWidth",1)
    end

    set(gca,"Title",[])
    leg = get(gca,"Legend");
    leg.Title.String = sprintf("thickness (energy density)\nc-oriented Cr2O3");
    leg.FontSize = 8;
    leg.Title.FontSize = 9;
    
    xlim([37 41])
    ylabel("intensity (a.u.)")
    set(gca,"YTickLabel",[])
end
%% L = -2cm
CM = {cool(3)*.9,summer(3)*.9,spring(3)*.9};
S = {0,1,2};
for i = [1,2,3]
    linePainter(Htot{i},"start",CM{i}(1,:),"end",CM{i}(2,:),"prio",1)
end
% Htot{3}.Color = [0 0 0];
% Htot{3}.LineStyle = ":";

Htot{4}.Color = [.4 .4 .4];
Htot{4}.LineStyle = ":";



grid on
linkaxes(cellfun(@(x) x,ax))
ylim([100 2e5]); % too see the legend

exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-XRD_c.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-XRD_c.pdf")
