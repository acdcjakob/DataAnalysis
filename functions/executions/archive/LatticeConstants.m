LATTICE = true;

% a_Al2O3 = 4.755; % angstrom
% c_Al2O3 = 12.99; % angstrom

% a_Cr2O3 = 4.958; % angstrom
% c_Cr2O3 = 13.593; % angstrom

% results = table("Sample",{},"Plane",{},"InPlane",{},"OutOfPlane",{});
results = table('Size',[14,5],...
    'VariableTypes',["string","string","double","double","string"],...
    'VariableNames',["Sample","Plane","InPlane","OutOfPlane","Meaning"]);
resultsexport = table('Size',[14,5],...
    'VariableTypes',["string","string","string","string","string"],...
    'VariableNames',["Sample","Plane","InPlane","OutOfPlane","Meaning"]);

results.Meaning(:) = repmat(["perp to c";"parallel to c"],[7,1]);

RSM_auswertung_W6715_220;
n = 1;
results{n,1} = "W6715";
results{n,2} = "4-20";
results{n,3} = in4m20;
results{n,4} = out4m20;
RSM_auswertung_W6715_306;
n = 2;
results{n,1} = "W6715";
results{n,2} = "306";
results{n,3} = in306;
results{n,4} = out306;


RSM_auswertung_W6716_220;
n = 3;
results{n,1} = "W6716";
results{n,2} = "4-20";
results{n,3} = in4m20;
results{n,4} = out4m20;
RSM_auswertung_W6716_306;
n = 4;
results{n,1} = "W6716";
results{n,2} = "306";
results{n,3} = in306;
results{n,4} = out306;


RSM_auswertung_W6725_220;
n = 5;
results{n,1} = "W6725";
results{n,2} = "4-20";
results{n,3} = in4m20;
results{n,4} = out4m20;
RSM_auswertung_W6725_306;
n = 6;
results{n,1} = "W6725";
results{n,2} = "306";
results{n,3} = in306;
results{n,4} = out306;

RSM_auswertung_W6902m_220;
n = 7;
results{n,1} = "W6902m";
results{n,2} = "4-20";
results{n,3} = in4m20;
results{n,4} = out4m20;
RSM_auswertung_W6902m_306;
n = 8;
results{n,1} = "W6902m";
results{n,2} = "306";
results{n,3} = in306;
results{n,4} = out306;

RSM_auswertung_W6905m_220;
n = 9;
results{n,1} = "W6905m";
results{n,2} = "4-20";
results{n,3} = in4m20;
results{n,4} = out4m20;
RSM_auswertung_W6905m_306;
n = 10;
results{n,1} = "W6905m";
results{n,2} = "306";
results{n,3} = in306;
results{n,4} = out306;

RSM_auswertung_W6902a_300;
n = 11;
results{n,1} = "W6902a";
results{n,2} = "300";
results{n,3} = in300;
results{n,4} = out300;
RSM_auswertung_W6902a_226;
n = 12;
results{n,1} = "W6902a";
results{n,2} = "226";
results{n,3} = in226;
results{n,4} = out226;

RSM_auswertung_W6905a_300;
n = 13;
results{n,1} = "W6905a";
results{n,2} = "300";
results{n,3} = in300;
results{n,4} = out300;
RSM_auswertung_W6905a_226;
n = 14;
results{n,1} = "W6905a";
results{n,2} = "226";
results{n,3} = in226;
results{n,4} = out226;


results.InPlane = results.InPlane*10;
results.OutOfPlane = results.OutOfPlane*10;

for j = 1:numel(results.InPlane)
    resultsexport.InPlane(j) = num2str(results.InPlane(j),"%.3f");
    resultsexport.OutOfPlane(j) = num2str(results.OutOfPlane(j),"%.3f");
end
resultsexport.Sample = results.Sample;
resultsexport.Plane = results.Plane;
resultsexport.Meaning = results.Meaning;


%% inital batch: dependence on omega-FWHM

Samples_init = searchSamples_v2({{'Batch','Cr2O3_initial';'RSM','a'}},true);
F1 = figure("OuterPosition",[100 100 500 500]);
ax_a = axes(F1,"Position",[.15 .12 .75 .38],"Box","on");
    hold(ax_a,"on")
    legend(ax_a,"FontSize",9,"location","north")
    yline(ax_a,4.958,"--b","DisplayName","a-literature Cr2O3")
    % yline(ax_a,4.755,"--m","DisplayName","literature Al2O3")
ax_c = axes(F1,"Position",[.15 .52 .75 .4],"Box","on");
    hold(ax_c,"on")
    legend(ax_c,"FontSize",9,"location","north")
    yline(ax_c,13.593,"--b","DisplayName","c-literature Cr2O3")
    % yline(ax_c,12.99,"--m","DisplayName","literature Al2O3")
linkaxes([ax_a,ax_c],'x')

% plotData(:,1) = Samples_init.d;
for i = 1:numel(Samples_init.Id)
    plotData(i,1) = getRocking(Samples_init.Id{i});
end
% 22.0 out-of-plane
plotData(:,2) = results.OutOfPlane([1,3,5]);
% 22.0 in-plane
plotData(:,4) = results.InPlane([1,3,5]);
% 30.6 out-of-plane
plotData(:,3) = results.OutOfPlane([2,4,6]);
% 30.6 in-plane
plotData(:,5) = results.InPlane([2,4,6]);

plotData = sortrows(plotData);

plot(ax_a,plotData(:,1),plotData(:,2),"k--",MarkerFaceColor="g",HandleVisibility="off")
scatter(ax_a,plotData(:,1),plotData(:,2),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="g",DisplayName="a_o (22.0)")
plot(ax_a,plotData(:,1),plotData(:,3),"k--",MarkerFaceColor="r",HandleVisibility="off")
scatter(ax_a,plotData(:,1),plotData(:,3),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="r",DisplayName="a_o (30.6)")
plot(ax_a,plotData(:,1),plotData(:,4),"k>--",MarkerFaceColor="g",DisplayName="a_i (22.0)")
plot(ax_c,plotData(:,1),plotData(:,5),"ko--",MarkerFaceColor="r",DisplayName="c_i (30.6)")

set(ax_c,...%"box","off",...
    "XAxisLocation","top",...
    "YAxisLocation","left")
xlabel(ax_a,"\omega-FWHM (°)");
ylabel(ax_c,"lattice constant ("+char(197)+")")
% set(ax_a,"Box","off")
set(get(ax_c,"Xaxis"),"TickLabels",[])
axis(ax_a,"padded")
axis(ax_c,"padded")
grid(ax_a,"on")
grid(ax_c,"on")

sgtitle("{\itm}-oriented Cr2O3")

%% m plane
Samples_energy1 = searchSamples_v2({{'Batch','Cr2O3_energy';'RSM','a';'Sub','m-Al2O3'}},true);
F2 = figure("OuterPosition",[100 100 700 500]);
ax_a1 = axes(F2,"Position",[.1 .12 .38 .35],"Box","on");
    hold(ax_a1,"on")
    legend(ax_a1,"FontSize",9,"location","north")
    yline(ax_a1,4.958,"--b","DisplayName","a-literature Cr2O3")
    % yline(ax_a,4.755,"--m","DisplayName","literature Al2O3")
ax_a2 = axes(F2,"Position",[.6 .12 .38 .35],"Box","on");
    hold(ax_a2,"on")
    legend(ax_a2,"FontSize",9,"location","north")
    yline(ax_a2,4.958,"--b","DisplayName","a-literature Cr2O3")
ax_c1 = axes(F2,"Position",[.1 .52 .38 .35],"Box","on");
    hold(ax_c1,"on")
    legend(ax_c1,"FontSize",9,"location","north")
    yline(ax_c1,13.593,"--b","DisplayName","c-literature Cr2O3")
    % yline(ax_c,12.99,"--m","DisplayName","literature Al2O3")
ax_c2 = axes(F2,"Position",[.6 .52 .38 .35],"Box","on");
    hold(ax_c2,"on")
    legend(ax_c2,"FontSize",9,"location","north")
    yline(ax_c2,13.593,"--b","DisplayName","c-literature Cr2O3")
linkaxes([ax_a1,ax_c1],'x')

% plotData(:,1) = Samples_init.d;
for i = 1:numel(Samples_energy1.Id)
    % plotDataEnergyM(i,1) = getRocking(Samples_energy1.Id{i});
    plotDataEnergyM(i,1) = energyDensity(Samples_energy1.NameVal{i});
end
% 22.0 out-of-plane
plotDataEnergyM(:,2) = results.OutOfPlane([7,9]);
% 22.0 in-plane
plotDataEnergyM(:,4) = results.InPlane([7,9]);
% 30.6 out-of-plane
plotDataEnergyM(:,3) = results.OutOfPlane([8,10]);
% 30.6 in-plane
plotDataEnergyM(:,5) = results.InPlane([8,10]);

plotDataEnergyM = sortrows(plotDataEnergyM);

plot(ax_a1,plotDataEnergyM(:,1),plotDataEnergyM(:,2),"k--",HandleVisibility="off")
scatter(ax_a1,plotDataEnergyM(:,1),plotDataEnergyM(:,2),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="g",DisplayName="a_o (22.0)")
plot(ax_a1,plotDataEnergyM(:,1),plotDataEnergyM(:,3),"k--",HandleVisibility="off")
scatter(ax_a1,plotDataEnergyM(:,1),plotDataEnergyM(:,3),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="r",DisplayName="a_o (30.6)")
plot(ax_a1,plotDataEnergyM(:,1),plotDataEnergyM(:,4),"k>--",MarkerFaceColor="g",DisplayName="a_i (22.0)")
plot(ax_c1,plotDataEnergyM(:,1),plotDataEnergyM(:,5),"ko--",MarkerFaceColor="r",DisplayName="c_i (30.6)")

set(ax_c1,...%,"box","off",...
    "XAxisLocation","top",...
    "YAxisLocation","left")
% xlabel(ax_a1,"\omega-FWHM (°)");
xlabel(ax_a1,"energy density (J/cm^2)");
ylabel(ax_c1,"lattice constant ("+char(197)+")")
% set(ax_a1,"Box","off")
set(get(ax_c1,"Xaxis"),"TickLabels",[])
axis(ax_a1,"padded")
axis(ax_c1,"padded")
grid(ax_a1,"on")
grid(ax_c1,"on")

%% a-plane
linkaxes([ax_a2,ax_c2],'x')
Samples_energy2 = searchSamples_v2({{'Batch','Cr2O3_energy';'RSM','a';'Sub','a-Al2O3'}},true);

% plotData(:,1) = Samples_init.d;
for i = 1:numel(Samples_energy2.Id)
    % plotDataEnergyA(i,1) = getRocking(Samples_energy2.Id{i});
    plotDataEnergyA(i,1) = energyDensity(Samples_energy2.NameVal{i});
end
% 30.0 out-of-plane
plotDataEnergyA(:,2) = results.OutOfPlane([11,13]);
% 30.0 in-plane
plotDataEnergyA(:,4) = results.InPlane([11,13]);
% 22.6 out-of-plane
plotDataEnergyA(:,3) = results.OutOfPlane([12,14]);
% 22.6 in-plane
plotDataEnergyA(:,5) = results.InPlane([12,14]);

plotDataEnergyA = sortrows(plotDataEnergyA);


plot(ax_a2,plotDataEnergyA(:,1),plotDataEnergyA(:,2),"k--",HandleVisibility="off")
scatter(ax_a2,plotDataEnergyA(:,1),plotDataEnergyA(:,2),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="g",DisplayName="a_o (30.0)")
plot(ax_a2,plotDataEnergyA(:,1),plotDataEnergyA(:,3),"k--",HandleVisibility="off")
scatter(ax_a2,plotDataEnergyA(:,1),plotDataEnergyA(:,3),"k^",MarkerFaceAlpha=.4,MarkerFaceColor="r",DisplayName="a_o (22.6)")
plot(ax_a2,plotDataEnergyA(:,1),plotDataEnergyA(:,4),"k>--",MarkerFaceColor="g",DisplayName="a_i (30.0)")
plot(ax_c2,plotDataEnergyA(:,1),plotDataEnergyA(:,5),"ko--",MarkerFaceColor="r",DisplayName="c_i (22.6)")

set(ax_c2,...%,"box","off",...
    "XAxisLocation","top",...
    "YAxisLocation","left")
% xlabel(ax_a2,"\omega-FWHM (°)");
xlabel(ax_a2,"energy density (J/cm^2)");
ylabel(ax_c2,"lattice constant ("+char(197)+")")
% set(ax_a2,"Box","off")
set(get(ax_c2,"Xaxis"),"TickLabels",[])
axis(ax_a2,"padded")
axis(ax_c2,"padded")
grid(ax_a2,"on")
grid(ax_c2,"on")





Tm = sgtitle("{\itm}-oriented Cr2O3");
Ta = copyobj(Tm,F2);
Tm.HorizontalAlignment = "left";
Ta.HorizontalAlignment = "right";
Ta.String = "{\ita}-oriented Cr2O3";


%%
set(get(ax_c,"YAxis"),"FontSize",12)
set(get(ax_a,"YAxis"),"FontSize",12)
set(get(ax_a,"XAxis"),"FontSize",11)

set(get(ax_c1,"YAxis"),"FontSize",12)
set(get(ax_a1,"YAxis"),"FontSize",12)
set(get(ax_a1,"XAxis"),"FontSize",11)

set(get(ax_c2,"YAxis"),"FontSize",12)
set(get(ax_a2,"YAxis"),"FontSize",12)
set(get(ax_a2,"XAxis"),"FontSize",11)

exportgraphics(F1,"../Plots/Cr2O3/1 initial/1-RSM_latticeData.pdf")
exportgraphics(F1,"../Plots/Cr2O3/1 initial/1-RSM_latticeData.png","Resolution",250)

exportgraphics(F2,"../Plots/Cr2O3/5 energy/5-RSM_latticeData.pdf")
exportgraphics(F2,"../Plots/Cr2O3/5 energy/5-RSM_latticeData.png","Resolution",250)

