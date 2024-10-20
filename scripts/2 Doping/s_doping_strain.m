planes = ["c" "r" "m" "a"]; % columns
batches = ["Cr2O3_CuO_CompVar1";... % rows
    "Cr2O3_ZnO_CompVar1";...
    "Cr2O3_ZnO_CompVar2"];
names = ["CuO-doped";
    "ZnO-doped (L)";
    "ZnO-doped (H)"];

%% get data
% init
samTable = cell(3,4);
epsilon = cell(3,4);
g = cell(3,4);

for i = 1:3
    for ii = 1:4
        samTable{i,ii} = searchSamples_v2(...
                {{'Batch',batches(i);...
                'Sub',planes(ii)+"-Al2O3";...
                'ThetaOmega','a'}},...
            true);
        
        epsilon{i,ii} = getPeakShift(samTable{i,ii},...
            "table",true,...
            "relative",true) * 100; % percent

        g{i,ii} = growthrateFun(samTable{i,ii});
    end
end

%% Plotting
tilHand = tiledlayout(2,2,...
    "Padding","tight",...
    "TileSpacing","compact");
[tilHand,figHand] = makeLatexSize(1,.7,tilHand);

% init
axHand = gobjects(1,4);
colMap = [.2 .8 .2;
    .7 .2 .7;
    .7 .2 .5];
markMap = ["s";
    "s";
    "^"];
batchLabel = ["CuO-doped";
    "ZnO-doped (L)";
    "ZnO-doped (H)"];
for ii = 1:4
    axHand(ii) = nexttile();
        grid(axHand(ii),"on");
        formatAxes(axHand(ii));
        hold(axHand(ii),"on");
        grid(axHand(ii),"on");
        title(axHand(ii),"{\it"+planes(ii)+"}-plane")
    for i = 1:3
        scatter(axHand(ii),g{i,ii}*1000,epsilon{i,ii},... % pm / pulse
            "MarkerEdgeColor","w",...
            "MarkerFaceColor",colMap(i,:),...
            "Marker",markMap(i),...
            "SizeData",2*36,...
            "DisplayName",names(i));
        
    end
end

linkaxes(axHand)
set(tilHand.XLabel,...
    "String","{\itg} (pm pulse^{-1})",...
    "FontSize",12);
set(tilHand.YLabel,...
    "String","\epsilon_{zz} (%)",...
    "FontSize",12);

legHand = legend(axHand(2));
formatAxes(axHand(2))

exportgraphics(figHand,"../Plots/Thesis/2/2_doped_strain.eps")

