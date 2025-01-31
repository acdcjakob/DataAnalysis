samTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","m-Al2O3"}}...
    ,true);

samTable = sortrows(samTable,"NameVal"); % sort dep. on pulse energy
N = numel(samTable.Id);
a_Cr2O3 = 0.4958; % nm
c_Cr2O3 = 1.3593; 

%% get data
F = nan(N,1);
% ezz  exx   eyy and errors
epsilon = {F F F;F F F};
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

tileH = tiledlayout(1,2,"Padding","compact","TileSpacing","loose");
[tileH,fH] = makeLatexSize(.9,.5/.9,tileH);

% 1st plot
axH(1) = nexttile();
    hold(axH(1),"on")
    formatAxes(axH(1));
    
    ylabel(axH(1),"\epsilon (%)")
    xlabel(axH(1),"{\itF} (J cm^{-2})")
    title("{\itm}-plane strain")
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
    title("{\itm}-plane tilt and shear")
    axis padded; % prevent clipping of datapoints when using yyaxis

    yyaxis(axH(2),"left")
    formatAxes(axH(2));
    ylabel(axH(2),"\theta_T (' arcmin)")
    xlabel(axH(2),"{\itF} (J cm^{-2})")
    set(axH(2),"YColor",colMap(2,:)*.8)

    yyaxis(axH(2),"right")
    formatAxes(axH(2));
    ylabel(axH(2),"\Psi_S (' arcmin)")
    set(axH(2),"YColor",colMap(2,:).*[.7 1 .5])

yyaxis(axH(2),"left")
scH2(1) = scatter(axH(2),F,abs([y.tiltAngle_cPar]'*180/pi*60)...
    ,72,"k",...
    Marker=markMap(2),...
    Markerfacecolor=colMap(2,:),...
    DisplayName="{\itx}-tilt \theta_T");
% highlight
plot(axH(2),F,abs([y.tiltAngle_cPar]'*180/pi*60),"k--","linewidth",1,...
    "handlevis","off")
% scH2(2) = scatter(axH(2),F,abs([y.shearAngle_cPar]'*180/pi*60)...
%     ,72,"k",...
%     Marker="o",...
%     Markerfacecolor=colMap(2,:),...
%     DisplayName="{\itx}-shear");

yyaxis(axH(2),"right")
% y-tilt:
% scH2(3) = scatter(axH(2),F,abs([y.tiltAngle_cPerp]'*180/pi*60),...
%     72,"k",...
%     Marker=markMap(3),...
%     Markerfacecolor=colMap(3,:),...
%     DisplayName="{\ity}-tilt");
% y-shear:
% scH2(3) = scatter(axH(2),F,abs([y.shearAngle_cPerp]'*180/pi*60),...
%     72,"k",...
%     Marker="o",...
%     Markerfacecolor=colMap(3,:),...
%     DisplayName="{\ity}-shear");
scH2(2) = scatter(axH(2),F,abs([y.shearAngle_cPar]'*180/pi*60)...
    ,72,"k",...
    Marker="o",...
    Markerfacecolor=colMap(2,:).*[.7 1 .5],...
    DisplayName="{\itx}-shear \Psi_S");


legH(1) = legend(axH(1),...
    "Position",[0.12    0.2276    0.12    0.2417]);
formatAxes(axH(1))
legH(2) = legend(axH(2),"Position",...
    [0.7   0.3    0.22    0.18]);
formatAxes(axH(2))

grid(axH,"on")


% exportgraphics(fH,"../Plots/Thesis/3/3_pulseEnergy_completeStrain_m.eps")

%% calculated epsilon_z
[axCal,fCal] = makeLatexSize(.5,1.2);
hold(axCal,"on")

% plot(F,epsilon{1,1},"s-k");

ezz = epsilon{1,1};
exx = epsilon{1,2};
eyy = epsilon{1,3};

C11 = 3.74;
C12 = 1.48;
C13 = 1.75;
C33 = 3.62;
C44 = 1.59;
C14 = -0.19;

ezzCAL = -1*(C13*C44.*exx+(C12*C44+C14^2).*eyy)/(C11*C44-C14^2);

plot(F,exx*100,"s-","Color",[0 .8 0],"LineWidth",1,...
    "DisplayName","\epsilon_{x}")
hold on
plot(F,eyy*100,"s-","Color",[.8 0 0],"LineWidth",1,...
    "DisplayName","\epsilon_{y}")
plot(F,ezz*100,"s-k","LineWidth",1,...
    "DisplayName","\epsilon_{z}")
plot(F,ezzCAL*100,"o--k","LineWidth",1,...
    "DisplayName","\epsilon_{z} calc.")

xlabel("{\itF} (J cm^{-2})")
ylabel("\epsilon (%)")

grid
legend("Location","southwest")

exportgraphics(gcf,"../Plots/Thesis/3/3_misc_pulseEnergy_mRSMcalculated.pdf")
