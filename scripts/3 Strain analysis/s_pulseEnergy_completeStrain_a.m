samTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","a-Al2O3"}}...
    ,true);

samTable = sortrows(samTable,"NameVal"); % sort dep. on pulse energy
N = numel(samTable.Id);
a_Cr2O3 = 0.4958; % nm
c_Cr2O3 = 1.3593; 

%% get data
F = nan(N,1);
% ezz  exx   eyy and errors
epsilon = {F F F;
    F F F};
for i = 1:N
    F(i) = energyDensity(-1,false,samTable.NameVal{i});  
    y(i) = getRSMLattice(samTable(i,:));
    % (d'-d)/d :
    epsilon{1,1}(i,1) = (y(i).a_out-a_Cr2O3)/a_Cr2O3;
    epsilon{2,1}(i,1) = y(i).err_a_out/a_Cr2O3;

    epsilon{1,2}(i,1) = (y(i).c_in-c_Cr2O3)/c_Cr2O3;
    epsilon{2,2}(i,1) = y(i).err_c_in / c_Cr2O3;

    epsilon{1,3}(i,1) = (y(i).a_in-a_Cr2O3)/a_Cr2O3;
    epsilon{2,3}(i,1) = y(i).err_a_in / a_Cr2O3;
end

%% Plotting section

tileH = tiledlayout(1,2,"Padding","compact","TileSpacing","tight");
[tileH,fH] = makeLatexSize(.9,.5/.9,tileH);

% 1st plot
axH(1) = nexttile();
    hold(axH(1),"on")
    formatAxes(axH(1));
    
    ylabel(axH(1),"\epsilon (%)")
    xlabel(axH(1),"{\itF} (J cm^{-2})")
    title("{\ita}-plane strain")
% init
scH = gobjects(1,numel(epsilon(1,:)));
erH = scH;
colMap = [
    .5 .9 .2; % asym z
    .7 .2 .7; % x
    .2 .2 .8]; % y
markMap = ["^" "<" ">"];
labels = [
    "\epsilon_{zz}"
    "\epsilon_{xx}"
    "\epsilon_{yy}"
    ];
for i = 1:numel(epsilon(1,:))
    scH(i) = scatter(axH(1),F,epsilon{1,i}*100,2*36,'k',... % percent
        "Marker",markMap(i),...
        "Markerfacecolor",colMap(i,:),...
        "DisplayName",labels(i));
    erH(i) = errorbar(axH(1),F,epsilon{1,i}*100,epsilon{2,i}*100,...
        ".",...
        "LineWidth",1,...
        "Color",colMap(i,:)*.7,...
        "HandleVisibility","off");
end

% 2nd plot
axH(2) = nexttile();
    hold(axH(2),"on")
    set(axH(2),"YAxisLocation","right")
    title("{\ita}-plane tilt and shear")

    formatAxes(axH(2));
    ylabel(axH(2),"\theta_T (' arcmin)")
    xlabel(axH(2),"{\itF} (J cm^{-2})")

scH2(1) = scatter(axH(2),F,abs([y.tiltAngle_cPar]'*180/pi*60)...
    ,72,"k",...
    Marker=markMap(2),...
    Markerfacecolor=colMap(2,:),...
    DisplayName="{\itx}-tilt");

scH2(2) = scatter(axH(2),F,abs([y.shearAngle_cPar]'*180/pi*60)...
    ,72,"k",...
    Marker="o",...
    Markerfacecolor=colMap(2,:),...
    DisplayName="{\itx}-shear");

scH2(3) = scatter(axH(2),F,abs([y.tiltAngle_cPerp]'*180/pi*60),...
    72,"k",...
    Marker=markMap(3),...
    Markerfacecolor=colMap(3,:),...
    DisplayName="{\ity}-tilt");
scH2(3) = scatter(axH(2),F,abs([y.shearAngle_cPerp]'*180/pi*60),...
    72,"k",...
    Marker="o",...
    Markerfacecolor=colMap(3,:),...
    DisplayName="{\ity}-shear");


legH(1) = legend(axH(1),...
    "location","east");
formatAxes(axH(1))
drawnow % sometimes bugy legend
legH(2) = legend(axH(2),"Position",...
    [0.5076    0.3287    0.1800    0.28]);
formatAxes(axH(2))

grid(axH,"on")

% save to .eps crops the right y-axis of second plot --> save to pdf
exportgraphics(fH,"../Plots/Thesis/3/3_pulseEnergy_completeStrain_a.eps")
