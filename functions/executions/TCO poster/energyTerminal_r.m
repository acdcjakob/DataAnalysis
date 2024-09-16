sampleTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","r-Al2O3"}}...
    ,true);

sampleTable = sortrows(sampleTable,"NameVal");
N = numel(sampleTable.Id);
qAs = q030();
qSym = getChromiumVector([0 0 0],[0 2 4]);

for i = 1:N
    x(i) = energyDensity(-1,false,sampleTable.NameVal{i});  
    y(i) = getRSMLattice(sampleTable(i,:));
    ezz(i,1) = (y(i).d_outAs-1/qAs(2))*qAs(2);
    ezzSym(i,1) = (y(i).d_outSym-1/qSym(2))*qSym(2);
    exx(i,1) = (y(i).d_inAs-1/qAs(1))*qAs(1);
end

cs = linePainterMap([.1 .4 .1],[.4 0 .4],2);

[ax,f1] = createAxes(1,400);
    hold(ax,"on")
    
    ylabel(ax,"\epsilon (%)")
    xlabel(ax,"{\itF} (J cm^{-2})")

Sz = scatter(ax,x,ezz*100,72,"dk","filled",...
    "MarkerFaceColor",cs(1,:),...
    "DisplayName","\epsilon_{zz} (03.0)");
    ytickformat(ax,"percentage")
    ylim(ax,[-1 .4])
Pz = plot(ax,x,ezz*100,"--",Color=cs(1,:),...
    HandleVisibility="off");
SzSym = scatter(ax,x,ezzSym*100,72,"dk",...
    "MarkerFaceColor",cs(1,:).*[1.2 1.9 1.2],...
    "DisplayName","\epsilon_{zz} (02.4)",...
    "Markerfacealpha",.7);
    ytickformat(ax,"percentage")
    ylim(ax,[-1 .4])
Sx = scatter(ax,x,exx*100,72,">k","filled",...
    "MarkerFaceColor",cs(1,:),...
    "DisplayName","\epsilon_{xx} (03.0)");

    
Px = plot(ax,x,exx*100,"--",Color=cs(1,:),...
    HandleVisibility="off");

[ax2,f2] = createAxes(1,400);

    hold(ax2,"on")

    ylabel(ax2,"\theta_T (' arcmin)")
    xlabel(ax2,"{\itF} (J cm^{-2})")

SaPar = scatter(ax2,x,abs([y.tiltAngle_cPar]'*180/pi*60),72,"^","filled",...
    Markerfacecolor=cs(2,:),...
    DisplayName="m-azimuth (|| to {\itc})");

PaPar = plot(ax2,x,abs([y.tiltAngle_cPar]'*180/pi*60),...
    "--",...
    Color=cs(2,:),...
    HandleVisibility="off");

SaPerp = scatter(ax2,x,abs([y.tiltAngle_cPerp]'*180/pi*60),72,"o","filled",...
    Markerfacecolor=cs(2,:),...
    DisplayName="a-azimuth (\perp to {\itc})");



    
l = legend(ax,[SzSym Sz Sx],"Location","east");
l.Title.String = "strain from RSMs";
l.FontSize = 12;
title(ax,"(01.2) Cr2O3 on Al2O3")

l2 = legend(ax2,"location","east");
l2.Title.String = "tilt angle of film";
l2.FontSize = 12;
title(ax2,"(01.2) Cr2O3 on Al2O3")


% exportgraphics(f1,"../Plots/TCO/r_strain.pdf");
% exportgraphics(f2,"../Plots/TCO/r_tilt.pdf");



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