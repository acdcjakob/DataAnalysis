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
        'Batch','Cr2O3_energy2';...
        'Sub',planes(i)+"-Al2O3";...
        'ThetaOmega','a'}},true);
    F{i} = cellfun( ...
        @(x) energyDensity(-1,false,x),...
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

colMap = flip(summer);
FLim = [min(vertcat(F{:})) max(vertcat(F{:}))];
dLim = [min(vertcat(d{:})) max(vertcat(d{:}))];

pseudo = [3.9 2.41 3.67 3.63];

for i = 1:nP
    FIdx{i} = floor(rescale(F{i},"inputmin",FLim(1),"inputmax",FLim(2))*255)+1;
    dIdx{i} = floor(rescale(d{i},"inputmin",dLim(1),"inputmax",dLim(2))*255)+1;

    axH(i) = nexttile;
        formatAxes(axH(i))
        hold(axH(i),"on")
        set(axH(i),...
            "Colormap",colMap,...
            "CLim",dLim,...
            "YGrid","on",...
            "YMinorGrid","on");

    scH(i) = scatter(F{i},epsilon{i}*100,... % percent
        2*36,colMap(dIdx{i},:),"filled",...
        "MarkerEdgeColor","k",...
        "marker","s",...
        "HandleVisibility","off");
    
    title(axH(i),"{\it"+planes(i)+"}-plane")

    % add pseudomophic
    % yline(axH(i),pseudo(i),"r--","LineWidth",1,"DisplayName","pseudomorphic")
    
    % include 0 in ylim
    axLims = axis(axH(i));
    ylim(axH(i),[0 axLims(4)])

end
linkaxes(axH,'x');
% linkaxes(axH,'y')

xlabel(tileH,"{\itF} (J cm^{-2})")
ylabel(tileH,"\epsilon_{zz} (%)")

cb = colorbar(axH(1));
cb.Layout.Tile = "east";
cb.Label.String = "{\itd} (nm)";
cb.Label.FontSize = 12;

figH.Position = figH.Position+[0 0 2 0]; % make space for colorbar


% legH = legend(axH(2));
% formatAxes(axH(1));

exportgraphics(figH,"../Plots/Thesis/3/3_pulseEnergy_strain.eps")
