batches = {...
    'Cr2O3_CuO_CompVar1';
    'Cr2O3_ZnO_CompVar1';
    'Cr2O3_ZnO_CompVar2';
    'Cr2O3_ZnO_PowerVar1'};
planes = ["c" "r"];

nB = numel(batches);
nP = numel(planes);

% init
samTable = cell(nB,1);
FWHM = cell(nB,nP);
epsilon = cell(nB,nP);

for i = 1:nB
    samTable{i} = searchSamples_v2({{ ...
        'Batch',batches{i};...
        'Omega','a';...
        'ThetaOmega','a'}},true);

    for ii = 1:nP
        planeIdx = cellfun(...
            @(x) strcmp(x,planes(ii)+"-Al2O3"),samTable{i}.Sub...
        );
        
        if ~any(planeIdx) % if no sample has this plane
            continue
        end
        
        FWHM{i,ii} = getRocking(samTable{i}.Id(planeIdx));
        epsilon{i,ii} = getPeakShift(...
            samTable{i}(planeIdx,:),'table',true,'relative',true);
    end
end

%% Plotting section

th = tiledlayout(1,2,"Padding","tight","TileSpacing","loose");
[th,fh] = makeLatexSize(1,.5,th);

% init
axHand = gobjects(1,nP);
scHand = gobjects(nB,nP);
colMap = [.2 .8 .2;
    .7 .2 .7;
    .7 .2 .5;
    .5 .2 .7];
markMap = ["s";"s";"^";"o"];
batchLabel = ["CuO-doped";
    "ZnO-doped (L)";
    "ZnO-doped (H)";
    "{\itT}_{heater} var."];

for ii = 1:nP
    axHand(ii) = nexttile(th);
        formatAxes(axHand(ii));
        hold(axHand(ii),"on");
        set(axHand(ii),...
            "XGrid","on",...
            "YGrid","on");
    
    for i = 1:nB
        if isempty(FWHM{i,ii}) | isempty(epsilon{i,ii})
            continue
        end
        scHand(i,ii) = scatter(...
            epsilon{i,ii}*100,FWHM{i,ii}*60,... % percent and arcmin
            "filled",...
            "MarkerFaceColor",colMap(i,:),...
            "MarkerEdgeColor","w",...
            "Marker",markMap(i),...
            "Sizedata",36*2);
        set(scHand(i,ii),...
            "Displayname",batchLabel(i));

    end

    title("{\it"+planes{ii}+"}-plane")
end

linkaxes(axHand,'y');

set(get(th,"YLabel"),...
    "String","\omega-FWHM (' arcmin)",...
    "Fontsize",12)

set(get(th,"XLabel"),...
    "String","\epsilon (%)",...
    "Fontsize",12)

legHand = legend(axHand(1),...
    'Position',[0.6878    0.1863    0.2740    0.28]);
drawnow
formatAxes(axHand(1));

exportgraphics(fh,'../Plots/Thesis/2/2_doped_strainOmegaCorrelation.eps')
