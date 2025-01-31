planes = ["c","r","m","a"];
nP = numel(planes);

%% get data
% init
samTable = cell(1,nP);
F = cell(1,nP);
d = F;
epsilon = F;
FWHM = F;
I = F;
for i = 1:nP
    samTable{i} = searchSamples_v2({{ ...
        'Batch','Cr2O3_energy2';...
        'Sub',planes(i)+"-Al2O3";...
        'ThetaOmega','a'}},true);
    F{i} = cellfun( ...
        @(x) energyDensity(-1,false,x),...
        samTable{i}.NameVal);
    d{i} = samTable{i}.d;
    epsilon{i} = getPeakShift(samTable{i},"table",true,"relative",true);
    FWHM{i} = getRocking(samTable{i}.Id);
    I{i} = getIntensity(samTable{i}.Id);
end

%% Plotting section

tileH = tiledlayout(2,2,"padding","tight","TileSpacing","compact");
[tileH,figH] = makeLatexSize(.85,.7,tileH); % space for colorbar

% init
axH = gobjects(4);
scH = gobjects(4);

colMap = flip(summer);
FLim = [min(vertcat(F{:})) max(vertcat(F{:}))];
dLim = [min(vertcat(d{:})) max(vertcat(d{:}))];
ILim = [min(horzcat(I{:})) max(horzcat(I{:}))];

pseudo = [3.9 2.41 3.67 3.63];

for i = 1:nP
    FIdx{i} = floor(rescale(F{i},"inputmin",FLim(1),"inputmax",FLim(2))*255)+1;
    dIdx{i} = floor(rescale(d{i},"inputmin",dLim(1),"inputmax",dLim(2))*255)+1;
    IIdx{i} = floor(rescale(I{i},"inputmin",ILim(1),"inputmax",ILim(2))*255)+1;

    axH(i) = nexttile;
        formatAxes(axH(i))
        hold(axH(i),"on")
        set(axH(i),...
            "Colormap",colMap,...
            "CLim",dLim,...
            "YGrid","on",...
            "YMinorGrid","on");

    scH(i) = scatter(F{i},FWHM{i}*60,... % arcmin
        2*36,colMap(dIdx{i},:),"filled",...
        "MarkerEdgeColor","k",...
        "marker","s",...
        "HandleVisibility","off");
    
    title(axH(i),"{\it"+planes(i)+"}-plane")
    
    % % include 0 in ylim
    % axLims = axis(axH(i));
    % ylim(axH(i),[0 axLims(4)])

end
linkaxes(axH,'x');
linkaxes(axH,'y')

xlabel(tileH,"{\itF} (J cm^{-2})")
ylabel(tileH,"\omega-FWHM (' arcmin)")

cb = colorbar(axH(1));
cb.Layout.Tile = "east";
cb.Label.String = "{\itd} (nm)";
cb.Label.FontSize = 12;

figH.Position = figH.Position+[0 0 2 0]; % make space for colorbar


% legH = legend(axH(2));
% formatAxes(axH(1));

exportgraphics(figH,"../Plots/Thesis/3/3_pulseEnergy_omega.eps")


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
    l = legend(AX(i),"position",[0.2208    0.2180    0.3132    0.2941]);

    formatAxes(AX(i))
    set(AX(i),"yscale","log",...
        "ColorOrder",winter(n)*.7)
    title(planes(i)+"-plane");
    
    xlabel("\omega-FWHM (°)")
    ylabel("counts (a.u.)")
    AX(i).YTickLabel = {};

    exportgraphics(FH(i),...
        "../Plots/Thesis/3/3_misc_pulseEnergy_omegaPattern_"+planes(i)+".eps")
end

%% MISC
% c-plane
f = figure();
cAx = copyobj(axH(1,1),f);
cCb = colorbar(cAx);
cCb.Label.String = cb.Label.String;
[cAx,f] = makeLatexSize(.35,1,cAx);
f.Position = f.Position+[0 0 2 0]; %space for colorbar
% ylim([-.2 1])

xlabel(tileH.XLabel.String)
ylabel(tileH.YLabel.String)
% ylim([.2 .52])
exportgraphics(f,"../Plots/Thesis/3/3_misc_pulseEnergy_omega_c_zoomed.eps")
