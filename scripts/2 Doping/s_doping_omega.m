% 1st column c-plane, 2nd column r-plane
% rows correspond to different targets

planes = {'c','r'};
    nP = numel(planes);
batches = {'Cr2O3_CuO_CompVar1'
    'Cr2O3_ZnO_CompVar1'
    'Cr2O3_ZnO_CompVar2'};
    nB = numel(batches);

%% get data
% init

samTable = cell(nB,nP);
g = cell(nB,nP);
FWHM = g;
for i = 1:nB
    for ii = 1:nP
        samTable{i,ii} = ...
            searchSamples_v2({{...
            'Batch',batches{i};...
            'Sub',planes{ii}+"-Al2O3";...
            'Omega','a'}},true);
        
        g{i,ii} = growthrateFun(samTable{i,ii})*1000; % pm / pulse
        FWHM{i,ii} = getRocking(samTable{i,ii}.Id)*60; % arcmin
    end
end

%% Plotting section

th = tiledlayout(1,2,"Padding","tight","TileSpacing","loose");
[th,fh] = makeLatexSize(1,.5,th);

% init
axHand = gobjects(1,nP);
scHand = gobjects(nB,nP);
colMap = [.2 .8 .2;.7 .2 .7;.7 .2 .5];
markMap = ["s";"s";"^"];
batchLabel = ["CuO-doped";"ZnO-doped (L)";"ZnO-doped (H)"];

for ii = 1:nP
    axHand(ii) = nexttile(th);
        formatAxes(axHand(ii));
        hold(axHand(ii),"on");
        set(axHand(ii),...
            "XGrid","on",...
            "YGrid","on")
    
    for i = 1:nB
        if isnan(FWHM{i,ii})
            continue
        end
        scHand(i,ii) = scatter(g{i,ii},FWHM{i,ii},...
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
linkaxes(axHand);

set(get(th,"XLabel"),...
    "String","{\itg} (pm pulse^{-1})",...a
    "Fontsize",12)

set(get(th,"YLabel"),...
    "String","\omega-FWHM (' arcmin)",...
    "Fontsize",12)

legHand = legend(axHand(1));
drawnow; % some bug with legend borders
set(legHand,"Position",[0.2632    0.1999    0.2756    0.2027]);
formatAxes(axHand(1)); % rescale legend

exportgraphics(fh,"../Plots/Thesis/2/2_doped_omega.eps")