samTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","r-Al2O3"}}...
    ,true);

samTable = sortrows(samTable,"NameVal"); % sort dep. on pulse energy
N = numel(samTable.Id);
qAs = q030(); % 030 is the asymmetric peak used for r-planes
qSym = getChromiumVector([0 0 0],[0 2 4]);
%% get data
F = nan(N,1);
% ezz  ezzSym   exx
epsilon = {F F F};
for i = 1:N
    F(i) = energyDensity(-1,false,samTable.NameVal{i});  
    y(i) = getRSMLattice(samTable(i,:));
    % (d'-d)/d :
    epsilon{1}(i,1) = (y(i).d_outAs-1/qAs(2)) * qAs(2);
    epsilon{2}(i,1) = (y(i).d_outSym - 1/qSym(2)) * qSym(2); 
    epsilon{3}(i,1) = (y(i).d_inAs-1/qAs(1))*qAs(1);
end

%% Plotting section

tileH = tiledlayout(1,2,"Padding","compact","TileSpacing","loose");
[tileH,fH] = makeLatexSize(.9,.5/.9,tileH); % more space for right label

% 1st plot
axH(1) = nexttile();
    hold(axH(1),"on")
    formatAxes(axH(1));
    
    ylabel(axH(1),"\epsilon (%)")
    xlabel(axH(1),"{\itF} (J cm^{-2})")
    title("{\itr}-plane strain")
% init
scH = gobjects(1,numel(epsilon));
colMap = [
    .5 .9 .2; % asym z
    1 .8 .1; % sym z
    .7 .2 .7; % x
    .2 .2 .8]; % y
markMap = ["^" "s" "<" ">"];
labels = [
    "\epsilon_{zz} (03.0)"
    "\epsilon_{zz} (02.4)"
    "\epsilon_{xx} (03.0)"
    ];
for i = 1:numel(epsilon)
    scH(i) = scatter(axH(1),F,epsilon{i}*100,2*36,'k',... % percent
        "Marker",markMap(i),...
        "Markerfacecolor",colMap(i,:),...
        "DisplayName",labels(i));
end

% 2nd plot
axH(2) = nexttile();
    hold(axH(2),"on")
    title("{\itr}-plane tilt")
    axis padded; % prevent clipping when using yyaxis

    yyaxis(axH(2),"left")
    formatAxes(axH(2));
    ylabel(axH(2),"\theta_T (' arcmin)")
    xlabel(axH(2),"{\itF} (J cm^{-2})")
    set(axH(2),"YColor",colMap(3,:)*.8)

    yyaxis(axH(2),"right")
    formatAxes(axH(2));
    ylabel(axH(2),"\theta_T (' arcmin)")
    set(axH(2),"YColor",colMap(4,:))

yyaxis(axH(2),"left")
scH2(1) = scatter(axH(2),F,abs([y.tiltAngle_cPar]'*180/pi*60)...
    ,72,"k",...
    Marker=markMap(3),...
    Markerfacecolor=colMap(3,:),...
    DisplayName="|| to {\itc}");
% highlight
plot(axH(2),F,abs([y.tiltAngle_cPar]'*180/pi*60),"k--","linewidth",1,...
    "handlevis","off")

yyaxis(axH(2),"right")
scH2(3) = scatter(axH(2),F,abs([y.tiltAngle_cPerp]'*180/pi*60),...
    72,"k",...
    Marker=markMap(4),...
    Markerfacecolor=colMap(4,:),...
    DisplayName="\perp to {\itc}");


legH(1) = legend(axH(1),...
    "Position",[0.12    0.1882    0.21    0.2618]);
legH(2) = legend(axH(2),"Location","east");

grid(axH,"on")
yyaxis(axH(2),"right")
ylim(axH(2),[0 1])
yyaxis(axH(2),"left")
axis(axH(2),"padded")

exportgraphics(fH,"../Plots/Thesis/3/3_pulseEnergy_completeStrain_r.eps")

function q = q030()
a_Cr2O3 = 4.958; % angstrom
c_Cr2O3 = 13.593; % angstrom
a = a_Cr2O3;
c = c_Cr2O3;
h = 0; k = 1 ; l = 2;
alpha = acos(l/sqrt(4/3*c^2/a^2*(h^2+k^2+h*k)+l^2));
q = getChromiumVector([0 3 0],[0 3 0]).* ...
        [cos(alpha);sin(alpha)];
end