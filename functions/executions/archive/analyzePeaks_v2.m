addpath(genpath("_MATLAB_functions"))
addpath(genpath("data"))

if ~exist("dontAskUser")
    search = {...
        {'Batch','Cr2O3_ZnO_PowerVar1';...
            'Sub','c-Al2O3'...
            'NameUnit','mm'}...
        };
    
    messung = "XRD_Omega";
    
    phase = ["Cr2O3" "Al2O3"];
    orientation = "r";

    Y = "scherrer";
end

peakSearch = planesFromPhaseOrientation(phase,orientation);



% --- get all samples from Batch ---
allSamplesTable = findIdsFun(search);
peakData = cell(numel(allSamplesTable.Id),2);
for i_sample = 1:numel(allSamplesTable.Id)
    thisId = allSamplesTable.Id{i_sample};
    peakData{i_sample,1} = thisId;
    thisSamplePeaks = findData(thisId,messung);
        % table from HighScore
    for i_peakSearch = 1:size(peakSearch,1)
        for j_peakSearch = 1:size(peakSearch,2)
            found = false;
            for i_samplePeaks = 1:size(thisSamplePeaks,1)
    
                thisPeak = thisSamplePeaks(i_samplePeaks,{'Phase','h','k','l'});
                thisPeak = table2cell(thisPeak);
                thisPeakSearch = peakSearch{i_peakSearch,j_peakSearch};
                % look for match
                allMismatch = cellfun(@(x,y) ~(x==y),thisPeak,thisPeakSearch);
                if ~any(allMismatch)
                    peakData{i_sample,2}{i_peakSearch,j_peakSearch} = thisSamplePeaks(i_samplePeaks,:);
                    found = true;
                end
            end
            if ~found
                peakData{i_sample,2}{i_peakSearch,j_peakSearch} = createLegitTableFromHighScore("",true);
            end
        end
    end
end

H = gobjects();
for i_peakSearch = 1:size(peakSearch,1)
    for j_peakSearch = 1:size(peakSearch,2)
        x = [];
        y = [];
        for i_sample = 1:numel(allSamplesTable.Id)
            x(i_sample) = i_sample;
            if strcmp(Y,'scherrer')
                y(i_sample) = scherrer(...
                peakData{i_sample,2}{i_peakSearch,j_peakSearch}.FWHM,...
                peakData{i_sample,2}{i_peakSearch,j_peakSearch}.Pos);
            else
                y(i_sample) = peakData{i_sample,2}{i_peakSearch,j_peakSearch}.(Y);
            end
            
            
        end
        h = plot(x,y);
        H(i_peakSearch,j_peakSearch) = h;

        Label = peakSearch{i_peakSearch,j_peakSearch};
        h.DisplayName = Label{1}+" ("+Label{2}+Label{3}+Label{4}+")";
        h.Marker = "s";
        h.LineWidth = 1;
        hold on
        h.Parent.XTick = x;
        h.Parent.XTickLabel = allSamplesTable.NameVal;
    end
end
legend
linePainter(H,'priority',1);
grid
if strcmp(Y,'scherrer')
    ylabel(axesLabel("crystallite size (nm)"))
else
    ylabel(axesLabel(Y))
end
hold off
%% --- Funktionen



function output = findIdsFun(search)
    sampleTable = searchSamples_v2(search,true);
        % Ausschnitt aus Uebersicht; alle Samples des Batches
    sampleTableSorted = sortrows(sampleTable,"NameVal");
        % sortiere gemäß NameVal (fuer spaeter lesbare Legende)
    output = sampleTableSorted;
end

function output = findData(Id,messung)
    folderPath = fullfile("data",Id,messung);
    allFiles = getFileNamesFromFolder(folderPath,".TXT");
    filePath = folderPath+"\"+allFiles;
        % nx1 string array
    if isempty(allFiles), output = table(); return, end
    output = createLegitTableFromHighScore(filePath(1));
    if numel(filePath)>1
        disp("analyzePeaks_v2.m: More than one peak .TXT file for "...
            +Id+" @"+messung)
    end
end

function L = scherrer(FWHM,angle)
    lambda = 0.15406; % K-alpha1 in angstrom
    L = 0.9*lambda/(FWHM*pi/180*cos(angle/2*pi/180));
end

function peakSearch = planesFromPhaseOrientation(phase,orientation)
if strcmp(orientation,"r")
    peakSearch = cell([4, numel(phase)]);
    for i = 1:numel(phase)
        peakSearch{1,i} = {phase(i) 0 1 2};
        peakSearch{2,i} = {phase(i) 0 2 4};
        peakSearch{3,i} = {phase(i) 0 3 6};
        peakSearch{4,i} = {phase(i) 0 4 8};
    end
elseif strcmp(orientation,"a")
    peakSearch = cell([2, numel(phase)]);
    for i = 1:numel(phase)
        peakSearch{1,i} = {phase(i) 1 1 0};
        peakSearch{2,i} = {phase(i) 2 2 0};
    end
elseif strcmp(orientation,"m")
    peakSearch = cell([1, numel(phase)]);
    for i = 1:numel(phase)
        peakSearch{1,i} = {phase(i) 3 0 0};
    end
elseif strcmp(orientation,"c")
    peakSearch = cell([2, numel(phase)]);
    for i = 1:numel(phase)
        peakSearch{1,i} = {phase(i) 0 0 6};
        peakSearch{2,i} = {phase(i) 0 0 12};
    end
end
end