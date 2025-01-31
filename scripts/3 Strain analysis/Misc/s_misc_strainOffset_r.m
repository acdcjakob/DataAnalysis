samTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","r-Al2O3"}}...
    ,true);

samTable = sortrows(samTable,"NameVal"); % sort dep. on pulse energy
N = numel(samTable.Id);

% get RSM and 2theta data
F = nan(N,1);
eRSM = nan(N,1);
eTheta = nan(N,1);

qSym = getChromiumVector([0 0 0],[0 2 4]);
for i = 1:N
    F(i) = energyDensity(-1,false,samTable.NameVal{i});
    y = getRSMLattice(samTable(i,:));

    eRSM(i) = (y.d_outSym - 1/qSym(2)) * qSym(2);
    eTheta(i) = getPeakShift(samTable(i,:),"table",true,"relative",true);
end

% scatter plot
tH = tiledlayout(2,2,"TileSpacing","compact","Padding","tight");
[tH,fH] = makeLatexSize(.9,.5/.9,tH);
axSc = nexttile(tH,2,[2,1]);
    formatAxes(axSc);
    hold(axSc,"on")
scatter(F,eRSM*100,"^b","filled","sizedata",2*36,...
    "displayname","(02.4) RSM","Markeredgecolor","k")
hold on
scatter(F,eTheta*100,"^r","filled","sizedata",2*36,...
    "displayname","(02.4) 2\theta-\omega pattern","Markeredgecolor","k")
ylabel("\epsilon_{zz} (%)")
xlabel("{\itF} (J cm^{-2})")
set(axSc,"YAxisLocation","right")

axRSM = nexttile(tH,3);
    [sub,film] = getRSMData("W6933r","cPar0");
    
    lit = getSapphireVector([0 0 0],[0 2 4]);
    [subCorX,subCorY,~,M] = correctReciprocalData(...
        film(1),film(2),lit,sub);
    formatAxes(axRSM);
    hold(axRSM,"on");
    plotRSM("W6933r","300",3,2,M)
    axis(axRSM,[-.05 .05 5.4 5.8]);
    ylabel("{\itq}_\perp")
    xlabel("{\itq}_{||}")
        set(axRSM,"XTick",[-0.04:0.02:0.04]);
    hold(axRSM,"on")
    scatter(axRSM,subCorX,subCorY,"dk","filled")

axTheta = nexttile(tH,1);
    formatAxes(axTheta);
    hold(axTheta,"on");
    XRD = getDiffraction(getFileNamesFromFolder( ...
        "data/W6933r/XRD_2ThetaOmega",".xy"...
        ));
    plot(axTheta,XRD(:,1),XRD(:,2),"r","LineWidth",1,...
        "HandleVisibility","off");
    set(axTheta,"yscale","log")
    axis(axTheta,[49 54 10 1e5]);
    ylabel("counts (a.u.)")
    xlabel("2\theta (°)")
    scatter(axTheta,50.0295,1702,"dk","filled","displayname","(02.4)")
    set(axTheta,"YTickLabel",{},"XAxisLocation","top")

grid([axRSM,axTheta,axSc],"on")

legSc = legend(axSc);
legTh = legend(axTheta,"location","northwest");

% exportgraphics(fH,"../Plots/Thesis/3/3_misc_pulse_r_discrepancy.png","Resolution",800)
