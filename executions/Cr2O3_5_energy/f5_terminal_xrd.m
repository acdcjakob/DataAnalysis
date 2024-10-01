% --- specs ---
Subs = ["c";"m";"r";"a"];
    nSub = numel(Subs);
SubCoef = ["(00.6)";"(30.0)";"(02.4)";"(11.0)"];
pos = {
  [.15 .6 .28 .3]
  [.57 .6 .28 .3]
  [.15 .2 .28 .3]
  [.57 .2 .28 .3]
};
lensPos = -1;
colors = {[0 .6 .2] [.2 .1 .9]};
symbols = ["^","s"];
lit = [13.59 4.96 4.96 4.96];
% ---------

figure("OuterPosition",[100 100 500 500])
IdCell = cell(nSub,1);
lattice = cell(nSub,1);
rocking = cell(nSub,1);
X = cell(nSub,1);

for iSub = 1:nSub
   IdCell{iSub} = searchSamples_v2(...
       {{
           'Batch','Cr2O3_energy2'
           'ThetaOmega','a'
           'Omega','a'
           'Sub',Subs(iSub)+"-Al2O3"
       }},...
       true);
    lattice{iSub} = getPeakShift(IdCell{iSub},"table",true,"lattice",true);
    rocking{iSub} = getRocking(IdCell{iSub}.Id);
    for j = 1:numel(IdCell{iSub}.Id)
        X{iSub}(j) = energyDensity(-1,false,IdCell{iSub}.NameVal{j});
    end
    % --- plot part ---
    ax(iSub,1) = axes("Position",pos{iSub});
        hold(ax(iSub,1),"on")
    title(Subs(iSub))
    axis(gca,"padded")
    set(ax(iSub,1),"YColor",colors{1})
    grid(gca,"on")
    if iSub == 3 | iSub == 4
        xlabel(gca,"energy density (J/cm^2)")
    end
    if iSub == 1 | iSub == 3
        ylabel(gca,"lattice constant ("+char(197)+")");
    end
    scatter(ax(iSub,1),X{iSub},lattice{iSub},exp(IdCell{iSub}.d/100)*10,...
        MarkerFaceColor=colors{1},...
        MarkerEdgeColor=colors{1}*0.5,...
        Marker=symbols(1),...
        MarkerFaceAlpha=.5,...
        LineWidth=.8);%,...
        % SizeData=36*1.5);
    drawnow

    ax(iSub,2) = axes("Position",get(gca,"Position"),...
        YAxisLocation="right",...
        YColor=colors{2},...
        XTick=[],...
        XAxisLocation="top",...
        Color="none",...Id
        PositionConstraint="innerposition");
    hold(ax(iSub,2),"on")
    if iSub == 2 | iSub == 4
        ylabel(gca,"\omega-FWHM (°)")
    end
    scatter(ax(iSub,2),X{iSub},rocking{iSub},...
        MarkerFaceColor=colors{2},...
        MarkerEdgeColor=colors{2},...
        MarkerFaceAlpha=.2,...
        MarkerEdgeAlpha=0,...
        Marker=symbols(2),...
        SizeData=36*1.5);
    yline(ax(iSub,1),lit(iSub),"-.",...
        "LineWidth",1,"Alpha",.6,...
        "Color",colors{1}*0.7,...
        HandleVisibility="off")
end

linkaxes(ax,'x')
linkaxes(ax(2:4,1),'y')
linkaxes(ax(:,2),'y')

exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-terminal_xrd.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-terminal_xrd.png","Resolution",250)