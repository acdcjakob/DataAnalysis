planes = ["c","r","m","a"];
nP = numel(planes);

%% get data
% init
samTable = cell(1,nP);
F = cell(1,nP);
d = F;
epsilon = F;
FWHM = F;
for i = 1:nP
    samTable{i} = searchSamples_v2({{ ...
        'Batch','Cr2O3_energy';...
        'Sub',planes(i)+"-Al2O3";...
        'ThetaOmega','a'}},true);
    F{i} = cellfun( ...
        @(x) energyDensity(x),...
        samTable{i}.NameVal);
    d{i} = samTable{i}.d;
    epsilon{i} = getPeakShift(samTable{i},"table",true,"relative",true);
    FWHM{i} = getRocking(samTable{i}.Id);
end

%% Plotting section

tileH = tiledlayout(2,2,"padding","tight","TileSpacing","compact");
[tileH,figH] = makeLatexSize(.85,.7,tileH); % space for colorbar

% init
axH = gobjects(4);
scH = gobjects(4);

colMap = jet;
FLim = [min(vertcat(F{:})) max(vertcat(F{:}))];
dLim = [min(vertcat(d{:})) max(vertcat(d{:}))];


for i = 1:nP
    FIdx{i} = floor(rescale(F{i},"inputmin",FLim(1),"inputmax",FLim(2))*255)+1;
    dIdx{i} = floor(rescale(d{i},"inputmin",dLim(1),"inputmax",dLim(2))*255)+1;

    axH(i) = nexttile;
        formatAxes(axH(i))
        hold(axH(i),"on")
        set(axH(i),...
            "Colormap",colMap,...
            "CLim",FLim,...
            "YGrid","on",...
            "YMinorGrid","on");

    scH(i) = scatter(d{i},FWHM{i}*60,... % arcmin
        2*36,colMap(FIdx{i},:),"filled",...
        "MarkerEdgeColor","w",...
        "marker","s",...
        "HandleVisibility","off");
    
    title(axH(i),"{\it"+planes(i)+"}-plane")
end
linkaxes(axH,'x');
linkaxes(axH(1:4),'y')

xlabel(tileH,"{\itd} (nm)")
ylabel(tileH,"\omega-FWHM (' arcmin)")

cb = colorbar(axH(1));
cb.Layout.Tile = "east";
cb.Label.String = "{\itF} (J cm^{-2})";
cb.Label.FontSize = 12;

figH.Position = figH.Position+[0 0 2 0]; % make space for colorbar

exportgraphics(figH,"../Plots/Thesis/3/3_lensPos_omega.eps")


%% Misc


for i = 1:4
    [AX(i),FH(i)] = makeLatexSize(.5,1);
    hold(AX(i),"on")
    T = samTable{i};
    [T,sortIdx] = sortrows(T,'NameVal');
    n = numel(T.Id);
    for ii = 1:n
        FP(ii) = getFilePathsFromId(T.Id{ii},"XRD_Omega",".xy");
        DAT{ii} = getDiffraction(FP{ii});
        plot(AX(i),DAT{ii}(:,1),DAT{ii}(:,2),...
            "DisplayName",num2str(F{i}(sortIdx(ii)),"%.2f")+" J/cm^2",...
            "LineWidth",1)
    end
    % l = legend(AX(i),"position",[0.2208    0.2180    0.3132    0.2941]);

    formatAxes(AX(i))
    set(AX(i),"yscale","log",...
        "ColorOrder",winter(n)*.7)
    title(planes(i)+"-plane");y
    
    xlabel("\omega-FWHM (°)")
    ylabel("counts (a.u.)")
    AX(i).YTickLabel = {};

    exportgraphics(FH(i),...
        "../Plots/Thesis/3/3_misc_lensPos_omegaPattern_"+planes(i)+".eps")
end

%% MISC
% c-plane zoom
f = figure();
cAx = copyobj(axH(1),f);
cCb = colorbar(cAx);
cCb.Label.String = cb.Label.String;
[cAx,f] = makeLatexSize(.35,1,cAx);
f.Position = f.Position+[0 0 2 0]; %space for colorbar
% ylim([0 4])

xlabel(tileH.XLabel.String)
ylabel(tileH.YLabel.String)

exportgraphics(f,"../Plots/Thesis/3/3_misc_lensPos_omega_c_zoomed.eps")