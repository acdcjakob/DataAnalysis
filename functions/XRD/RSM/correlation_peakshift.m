cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));

%%
if ~exist("dontaskuser")
    IdCell = getIdsFun;
    answer = inputdlg({"x-axis"});
    x_ax = answer{:};
else
    IdCell = getIdsFunAuto(prompt);
end

H = gobjects();
for idx_Batch = 1:numel(IdCell)
    peakPhases = {"Cr2O3","Al2O3"};
    if ~exist("dontaskuser")
        peakPlanes = inputdlg("orientation",string(idx_Batch));
        peakPlanes = peakPlanes{:};
    end
    
    peakTables = digFiles(IdCell{1,idx_Batch}.Id);
    IdCell{2,idx_Batch} = peakTables;
    
    n = size(IdCell{1,idx_Batch},1);
    Y = nan(n,1);
    X = nan(n,1);
    for idx_Sample = 1:n
        thisId = IdCell{1,idx_Batch}.Id{idx_Sample};
        thisPeakTable = peakTables{idx_Sample};
        disp(thisId);
        if isempty(thisPeakTable)
            continue
        else
            % --- logic part ---
            
            % peakPlanes = " ";
            Y(idx_Sample) = peakPositionNormed(thisPeakTable,peakPhases,peakPlanes);
            
            % --- thickness ---
            if strcmp(x_ax,"d")
                X(idx_Sample) = double(IdCell{1,idx_Batch}.d(idx_Sample));
            end

            % --- growth rate ---
            if strcmp(x_ax,"growthRate")
                X(idx_Sample) = double(IdCell{1,idx_Batch}.d(idx_Sample)) ...
                /double(IdCell{1,idx_Batch}.Pulses(idx_Sample));
            end
            
            % --- NameVal ---
            if strcmp(x_ax,"NameVal")
                X(idx_Sample) = double(string(IdCell{1,idx_Batch}.NameVal{idx_Sample}));
            end
    	    
            % --- FWHM Rocking ---
            if strcmp(x_ax,"Rocking")
                X(idx_Sample) = getRocking(thisId);
            end

            % --- Id ---
            if strcmp(x_ax,"Id")
                X(idx_Sample) = idx_Sample;
                XLabelCell{idx_Sample} = thisId;
            end
        end
    end
    H(idx_Batch) = scatter(gca,X,Y);
    hold on

    if strcmp(x_ax,"Id")
        set(gca,"XTick",1:numel(XLabelCell));
        set(gca,"XTickLabel",XLabelCell);
    end
    
end

%% FUNKTIONEN

function IdCell = getIdsFun()
    load correlation_peakshift_temp.mat
    prompt = inputdlg({"Prompt category","Prompt value"},...
        "User Input",... % window title
        1,... % field size
        default);
    if ~isempty(prompt)
        default = prompt;
    end
    save("./_temp/correlation_peakshift_temp.mat" , "default")
    prompt = transpose(cellfun(@(x) string(x),prompt));
    batches = searchSamplesPrompt(prompt(1),prompt(2));
    batchCount = size(batches,2);
    


    IdCell = cell(1,batchCount);
    for i = 1:batchCount
        IdCell{i} = searchSamples_v2(batches(i),true);
    end

end


function IdCell = getIdsFunAuto(prompt)
    prompt = transpose(cellfun(@(x) string(x),prompt));
    batches = searchSamplesPrompt(prompt(1),prompt(2));
    batchCount = size(batches,2);
    


    IdCell = cell(1,batchCount);
    for i = 1:batchCount
        IdCell{i} = searchSamples_v2(batches(i),true);
    end
end


function output = digFiles(IdCell)
    n = numel(IdCell);
    output = cell(n,1);
    for idx_Sample = 1:n
        Id = IdCell{idx_Sample};
        folderPath = fullfile("data",Id,"XRD_2ThetaOmega");
        fileName = getFileNamesFromFolder(folderPath,".TXT");
        filePath = fullfile(folderPath,fileName);
        if isempty(fileName)
            output{idx_Sample} = table();
            continue
        end

        output{idx_Sample} = createLegitTableFromHighScore(fileName(1));
    end
end
