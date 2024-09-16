sampleTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","m-Al2O3"}}...
    ,true);

sampleTable = sortrows(sampleTable,"NameVal");
N = numel(sampleTable.Id);
a_Cr2O3 = 0.4958; % nm
c_Cr2O3 = 1.3593; 

for i = 1:N
    x(i) = energyDensity(-1,false,sampleTable.NameVal{i});
    y(i) = getRSMLattice(sampleTable(i,:));
    ezz(i,1) = (y(i).a_out-a_Cr2O3)/a_Cr2O3;
    exx(i,1) = (y(i).c_in-c_Cr2O3)/c_Cr2O3;
    eyy(i,1) = (y(i).a_in-a_Cr2O3)/a_Cr2O3;
end

cs = [.1 .4 .1;...
    .4 0 .4;...
    .7 .2 .4];

[ax,f1] = createAxes(1,400);
    hold(ax,"on")
    
    ylabel(ax,"\epsilon (%)")
    xlabel(ax,"{\itF} (J cm^{-2})")
    set(ax,"YLimMode","manual")
    ylim(ax,[-1.5 1])

Sz = scatter(ax,x,ezz*100,72,"dk","filled",...
    "MarkerFaceColor",cs(1,:),...
    "DisplayName","\epsilon_{zz} (30.6)/(30.0)");
    ytickformat(ax,"percentage")
Pz = plot(ax,x,ezz*100,"--",Color=cs(1,:),...
    HandleVisibility="off");

Sx = scatter(ax,x,exx*100,72,">k","filled",...
    "MarkerFaceColor",cs(1,:),...
    "DisplayName","\epsilon_{xx} (30.6)");
Px = plot(ax,x,exx*100,"--",Color=cs(1,:),...
    HandleVisibility="off");

Sy = scatter(ax,x,eyy*100,72,"<k","filled",...
    "Markerfacecolor",cs(1,:),...
    "displayname","\epsilon_{yy} (4-2.0)");
Px = plot(ax,x,eyy*100,"--",Color=cs(1,:),...
    HandleVisibility="off");

l = legend(ax,[Sz Sx Sy],"Location","southwest");
l.Title.String = "strain from RSMs";
l.FontSize = 12;
title(ax,"(30.0) Cr2O3 on Al2O3")

%%
[ax2,f2] = createAxes(1,500);
    % set(ax2,"Position",get(ax2,"Position").*[1 1.2 .9 1],...
    set(ax2,...
        "box","off",...
        "YColor",cs(2,:))

    hold(ax2,"on")
    xlim(ax2,[0.5 3])
    ylim(ax2,[0 40])

    ylabel(ax2,"\theta_T (' arcmin)")
    xlabel(ax2,"{\itF} (J cm^{-2})")

    l2 = legend(ax2,"location","northeast");
    l2.Title.String = "tilt angle of film";
    l2.FontSize = 12;
    title(ax2,"(30.0) Cr2O3 on Al2O3")
    
    drawnow 

ax2b = axes("Position",get(ax2,"Position"),...
    Color="none",...
    XTick=[],...
    XAxisLocation="top",...
    YAxisLocation="right",...
    LineWidth=.75,...
    FontSize=12,...
    YColor=cs(3,:));
    
    ylabel(ax2b,"\Psi_S ('' arcsec)")
    hold(ax2b,"on")
    xlim(ax2b,[0.5 3])
    ylim(ax2b,[0 200])



l2b = legend(ax2b,"location","east");
l2b.Title.String = "shear angle of film";
l2b.FontSize = 12;
l2b.Color="w";
title(ax2,"(30.0) Cr2O3 on Al2O3")

SaPar = scatter(ax2,x,abs([y.tiltAngle_cPar]'*180/pi*60),72,"^","filled",...
    Markerfacecolor=cs(2,:),...
    DisplayName="|| to {\itc}",...
    MarkerFaceAlpha=.9);
PaPar = plot(ax2,x,abs([y.tiltAngle_cPar]'*180/pi*60),...
    Color=cs(2,:),...
    Linestyle="--",...
    HandleVisibility="off");
SaPerp = scatter(ax2,x,abs([y.tiltAngle_cPerp]'*180/pi*60),72,"o","filled",...
    Markerfacecolor=cs(2,:),...
    DisplayName="\perp to {\itc}",...
    MarkerFaceAlpha=.9);

SsPar = scatter(ax2b,x,abs([y.shearAngle_cPar]'*180/pi*3600),72,"^","filled",...
    Markerfacecolor=cs(3,:),...
    DisplayName="|| to {\itc}",...
    MarkerFaceAlpha=.9);
PsPar = plot(ax2b,x,abs([y.shearAngle_cPar]'*180/pi*3600),...
    Color=cs(3,:),...
    Linestyle="--",...
    HandleVisibility="off");
SsPerp = scatter(ax2b,x,abs([y.shearAngle_cPerp]'*180/pi*3600),72,"o","filled",...
    Markerfacecolor=cs(3,:),...
    DisplayName="\perp to {\itc}",...
    MarkerFaceAlpha=.9);



  



% exportgraphics(f1,"../Plots/TCO/m_strain.pdf");
% exportgraphics(f2,"../Plots/TCO/m_tilt+shear.pdf");

% delete(l2)
% delete(l2b),
makePosterSize(ax2,7,7)
makePosterSize(ax2b,7,7)
l2.Location="northwest";
linkaxes([ax2 ax2b],'x');
xlim(ax2,[0.5 2]);

f2.Renderer="painters";
exportgraphics(f2,"../Plots/TCO/m_tilt+shear.eps");


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