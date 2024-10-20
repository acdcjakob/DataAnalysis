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
filePaths = samTable;

FWHM = cell(nB,nP);
rho = FWHM;
err_rho = FWHM;
relErr = FWHM;
for ii = 1:nP
    for i = 1:nB
        samTable{i,ii} = ...
            searchSamples_v2({{...
            'Batch',batches{i};...
            'Sub',planes{ii}+"-Al2O3";...
            'Hall','y';...
            'Omega','a'}},true);
        
        filePaths{i,ii} = getFilePathsFromId(...
            samTable{i,ii}.Id,"Hall_RT",".mat");
        
        % init
        nj = numel(samTable{i,ii}.Id);
        y = nan(nj,1);
        yErr = nan(nj,1);
        % get rho array
        for j = 1:nj
            data = getHallData(filePaths{i,ii}(j));
                yRaw = [data{1,1}.rho]...
                    * samTable{i,ii}.d(j) / 1000; % correct thickness
                yErrRaw = [data{1,1}.err_rho]...
                    * samTable{i,ii}.d(j) / 1000; % correct thickness

            [y(j),yErr(j)] = weightedMean(yRaw,yErrRaw);
        end
        
        rho{i,ii} = y;
        err_rho{i,ii} = yErr;
        FWHM{i,ii} = getRocking(samTable{i,ii}.Id)*60; % arcmin

        % delete large errors
        relErr{i,ii} = err_rho{i,ii} ./ rho{i,ii};
        rho{i,ii}(relErr{i,ii} > .5) = nan;
    end
end

%% Plotting section

th = tiledlayout(1,2,"Padding","tight","TileSpacing","loose");
[th,fh] = makeLatexSize(1,.5,th);

% init
axHand = gobjects(1,nP);
scHand = gobjects(nB,nP);
erHand = gobjects(nB,nP);
colMap = [.2 .8 .2;.7 .2 .7;.7 .2 .5];
markMap = ["s";"s";"^"];
batchLabel = ["CuO-doped";"ZnO-doped (L)";"ZnO-doped (H)"];

for ii = 1:nP
    axHand(ii) = nexttile(th);
        formatAxes(axHand(ii));
        hold(axHand(ii),"on");
        set(axHand(ii),...
            "XGrid","on",...
            "YGrid","on",...
            "YScale","log")
    
    for i = 1:nB
        if isnan(FWHM{i,ii}) | isempty(FWHM{i,ii})
            continue
        end
        scHand(i,ii) = scatter(...
            FWHM{i,ii},rho{i,ii}*100,... % Ohm cm
            "filled",...
            "MarkerFaceColor",colMap(i,:),...
            "MarkerEdgeColor","w",...
            "Marker",markMap(i),...
            "Sizedata",36*2);
        erHand(i,ii) =  errorbar(...
            FWHM{i,ii},rho{i,ii}*100,err_rho{i,ii}*100,... % Ohm cm
            ".",...
            "Color",colMap(i,:)*.5);
        set(scHand(i,ii),...
            "Displayname",batchLabel(i));
        set(erHand(i,ii),...
            "HandleVisibility","off");
        
    end

    title("{\it"+planes{ii}+"}-plane")
end

linkaxes(axHand);

set(get(th,"XLabel"),...
    "String","\omega-FWHM (' arcmin)",...
    "Fontsize",12)

set(get(th,"YLabel"),...
    "String","\rho (\Omega cm)",...
    "Fontsize",12)

legHand = legend(axHand(1));
drawnow; % some bug with legend borders
set(legHand,"Position",[0.6249    0.2189    0.2756    0.2027]);
formatAxes(axHand(1)); % rescale legend

exportgraphics(fh,"../Plots/Thesis/2/2_doped_rhoVSomega.eps")
