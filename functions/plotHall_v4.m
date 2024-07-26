% ---- add Paths ----
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis\

% ---- ask user part ----
if ~exist("dontAskUser","var")
    Specs_Hall_RT = askUserFun();
else
    disp("plotHall.m: Don't ask user for new Specs")
end

% ---- settle log-Plot ----
xLogIdx = strfind(Specs_Hall_RT.xAxis,'$log');
if xLogIdx
    Specs_Hall_RT.xAxis = Specs_Hall_RT.xAxis([1:xLogIdx-1,xLogIdx+4:end]);
    % löscht "$log" raus aber merkt sich dass es geschrieben wurde
end
yLogIdx = strfind(Specs_Hall_RT.yAxis,'$log');
if yLogIdx
    Specs_Hall_RT.yAxis = Specs_Hall_RT.yAxis([1:yLogIdx-1,yLogIdx+4:end]);
end

% ---- look out for '$Batch' ----
singVarIdx = strfind(Specs_Hall_RT.xAxis,'$Batch');
if singVarIdx
    Specs_Hall_RT.xAxis = Specs_Hall_RT.xAxis([1:singVarIdx-1,singVarIdx+6:end]);
else
    singVarIdx = 0;
end

% ---- look out for mean ----

% [TBD]

%% Get Data

plotInformation = getAllHallFromBatch(Specs_Hall_RT);
    % get cell array with
    %   {:,1} -- sample names
    %   {:,2} -- structure arrays with data (for each Iset)
    %   {:,3} -- NameVal
    %   {:,4} -- NameUnit
fprintf("plotHall_v4.m: Alle Hall-Daten wurden geholt\n");

sampleNumber = numel(plotInformation(:,1));




%% ---------------Plot one variable against external data-------------



H = plotAllSamplesOnXAxis(plotInformation,Specs_Hall_RT);
ax = gca;

%%
%---------------------------------------------------------%
%---------------------------------------------------------%
%
%                       Plot Styles
%
%---------------------------------------------------------%
%---------------------------------------------------------%
function H = plotAllSamplesOnXAxis(plotInformation,Specs_Hall_RT)

N_samples = size(plotInformation,1);

X = nan([1,N_samples]);
XT = [];
    % could be number or cell
Y = [];
Y_err = [];

for idx_sample = 1:N_samples
    thisSampleTable = plotInformation{idx_sample,1};


    if numel(plotInformation{idx_sample,2}(:,1)) > 1
        disp("WARNING plotHall_v4.m: Es gibt mehrere Mess-Files zur Probe "+plotInformation{idx_sample,3})
        % ! nur das erste file wird hier genommen
    end
    
    % most of the time there are measurements for different Iset -> define
    % the Y-matrix as follows:
    % Y = 
    % (sample1-I1 sample2-I1 ...
    % (sample1-I2 sample2-I2 ...
    % (    :
    % (    :
    

    % ---------------
    %   getting data
    % ---------------
    if strcmp(Specs_Hall_RT.mean,'1')
    % mean of different Iset
        thisAverage = averageDifferentCurrentSet(plotInformation{idx_sample,2}{1,2});
        if isempty(thisAverage.(Specs_Hall_RT.yAxis))
            Y(idx_sample) = nan;
        else
            Y(idx_sample) = thisAverage.(Specs_Hall_RT.yAxis);
        end
        
        if isempty(thisAverage.("err_"+Specs_Hall_RT.yAxis))
            Y_err(idx_sample) = nan;
        else
            Y_err(idx_sample) = thisAverage.("err_"+Specs_Hall_RT.yAxis);
        end
    else
    % each Iset seperately
        for j_I = 1:numel(plotInformation{idx_sample,2}{1,2}(:,1)) % number of Iset
            thisDataIset = plotInformation{idx_sample,2}{1,2}(j_I);
                % containing results for one measurement
            
            thisAverage = averageDifferentCurrentSet(thisDataIset);
            if isempty(thisAverage.(Specs_Hall_RT.yAxis))
                Y(j_I,idx_sample) = nan;
            else
                Y(j_I,idx_sample) = thisAverage.(Specs_Hall_RT.yAxis);
            end

            if isempty(thisAverage.("err_"+Specs_Hall_RT.yAxis))
               Y_err(j_I,idx_sample) = nan;
            else
                Y_err(j_I,idx_sample) = thisAverage.("err_"+Specs_Hall_RT.yAxis);
            end
        end
    end
    
    
    % ------------
    %    setting X-data
    % ------------
    if strcmp(Specs_Hall_RT.xAxis,'d')
        x = columnToNumber(thisSampleTable.d);
        xLab = "d (nm)";
        xT = x;
        xTauto = true;
    elseif strcmp(Specs_Hall_RT.xAxis,'NameVal')
        x = columnToNumber(thisSampleTable.NameVal);
        xLab = thisSampleTable.NameUnit{1};
        xT = x;
        xTauto = true;
    elseif strcmp(Specs_Hall_RT.xAxis,'peakShiftRel')
        x = getPeakShift(thisSampleTable.Id{:},"Relative",true)*100;
        xLab = "[shift of 2\theta-\omega-peak] / [literature peak position] (%)";
        xT = x;
        xTauto =true;
    elseif strcmp(Specs_Hall_RT.xAxis,'Rocking')
        x = getRocking(thisSampleTable.Id{:});
        xLab = "\omega-FWHM (°)";
        xT = x;
        xTauto =true;
    else
        x = idx_sample;
        xLab = Specs_Hall_RT.xAxis;
        xT = string(thisSampleTable.(Specs_Hall_RT.xAxis){:});
        xTauto = false;
    end
    
    X(idx_sample) = x;
    XT{idx_sample} = xT;


    % -----------
    % thickness normalization
    % -----------
    if strcmp(Specs_Hall_RT.yAxis,"rho")|strcmp(Specs_Hall_RT.yAxis,"RH")
        % \rho and R_H scale linearly with d
        if isempty(thisSampleTable.d)
            disp("ACHTUNG plotHall_v4.m: keine Dicke vorhanden zur Normierung: "+plotInformation{idx_sample,3})
        else
            Y(:,idx_sample) = Y(:,idx_sample) * columnToNumber(thisSampleTable.d)/1000;
            Y_err(:,idx_sample) = Y_err(:,idx_sample) * columnToNumber(thisSampleTable.d)/1000;
        end
    elseif strcmp(Specs_Hall_RT.yAxis,"n")
        % n scales inversely with n
        if isempty(thisSampleTable.d)
            disp("ACHTUNG plotHall_v4.m: keine Dicke vorhanden zur Normierung: "+plotInformation{idx_sample,3})
        else
            Y(:,idx_sample) = Y(:,idx_sample) * 1000/columnToNumber(thisSampleTable.d);
            Y_err(:,idx_sample) = Y_err(:,idx_sample) *1000/columnToNumber(thisSampleTable.d);
        end
    end

    if strcmp(Specs_Hall_RT.yAxis,"rho")
        yLab = axesLabel("rho");
    elseif strcmp(Specs_Hall_RT.yAxis,"RH")
        yLab = axesLabel("RH");
    elseif strcmp(Specs_Hall_RT.yAxis,"n")
        yLab = axesLabel("n");
    elseif strcmp(Specs_Hall_RT.yAxis,"mu")
        yLab = axesLabel("mu");
    end
end


H = gobjects();
ax = gca;
for j_I = 1:size(Y,1)
    plotData = [transpose(X), transpose(Y(j_I,:)), transpose(Y_err(j_I,:))];
    plotData = sortrows(plotData);
    h = errorbar(plotData(:,1),plotData(:,2),plotData(:,3));
    h.Marker = "square";
    h.DisplayName = strcat(num2str(plotInformation{1,2}{1,2}{j_I}.Iset(2)),'\times I_{max}');
    hold on
    H(j_I,1) = h;
end
ax.XLabel.String = xLab;
if ~xTauto
    ax.XTickLabel = XT;
end
ax.YLabel.String = yLab;
end

%---------------------------------------------------------%
%---------------------------------------------------------%
%
%                       Funktionen
%
%---------------------------------------------------------%
%---------------------------------------------------------%

function Specs_Hall_RT = askUserFun()
    load("lastHall_RT_v4.mat")
        % laedt Specs_Hall_RT
    promptNames = fieldnames(Specs_Hall_RT);
        % alle Specs als moeglicher input
        promptNames{5} = sprintf([promptNames{5},'\n(Write $log for log plot)\n(Write $Batch for sorting NameVal)']);
        promptNames{6} = sprintf([promptNames{6},'\n(Write $log for log plot)']);
    promptDefault = cellfun(@char,struct2cell(Specs_Hall_RT),"UniformOutput",false);
        % Default values aus geladenem Specs_Hall_RT
    
        % cellfun creates nx1 array from the cell array struct2cell(..).
        % Because char() gives character arrays of different size, they cannot
        % be aligned vertically, that is why UniformOutput is put to false s.t.
        % the output is not an array but a cell array, so there can be
        % different character array entries of different size
    
    answer = inputdlg(promptNames,'Hall User Input',1,promptDefault);
        % ask for user input
        if isempty(answer), return, end
    Specs_Hall_RT = cell2struct(answer,fieldnames(Specs_Hall_RT),1);
        % Set the Specs with new user input
    
    save("./_temp/lastHall_RT_v4.mat","Specs_Hall_RT")
        % save the user input for next time
end


%----------------------------------------------------------%
%   run findIds
%   apllication of filter
%   run cropping of original .mat file
%   return cell array with all information
%----------------------------------------------------------%
function output = getAllHallFromBatch(Specs_Hall_RT)
    
    sampleTable = findIdsFun(Specs_Hall_RT);
    fprintf('plotHall_v4.m: Go through samples and get Hall files\n')
    sampleNumber = numel(sampleTable.Id);
    sampleIds = sampleTable.Id;
        % cell array
    
    plotInformation = cell(sampleNumber,3);
        % 1. Spalte Sample Tabelle
        % 2. Spalte cell array mit EinzelMessungen
        % 3. Spalte mit sample namen (das ist nur dafür da im matlab viewer
        % gleich die namen zu sehen)
    plotInformation(:,3) = sampleTable.Id;
    
    for idx_sample = 1:sampleNumber
        plotInformation{idx_sample,1} = sampleTable(idx_sample,:);
        % iteriere durch samples A, B, C usw.
        thisSampleMessFiles = getFileNamesFromFolder(...
            fullfile(...
                "data",...
                sampleIds{idx_sample},...
                Specs_Hall_RT.Messung...
            ), ...
        '.mat');
        thisSampleMessFiles = filterFileName(filterFileNamePrompt(Specs_Hall_RT.filter),thisSampleMessFiles,true);
        plotInformation{idx_sample,2} = cell(numel(thisSampleMessFiles),2);
        for idx_Messung = 1:numel(thisSampleMessFiles)
            
            plotInformation{idx_sample,2}{idx_Messung,1} = thisSampleMessFiles(idx_Messung);
            
            % iteriere durch Messungen A1, A2, A3 usw.
            thisMessungPath = fullfile( ...
                "data",...
                sampleIds{idx_sample},...
                Specs_Hall_RT.Messung,...
                thisSampleMessFiles(idx_Messung)...
            );
            outputFile = load(thisMessungPath);
            %
            % here the i-th sample with its j-th .mat-file is opened
            %
            allHallResults = getHallResultsFun(outputFile);
            plotInformation{idx_sample,2}{idx_Messung,2} = allHallResults;
        end
    end

    % delete all samples without any measurement

    for idx_sample = sampleNumber+1-(1:sampleNumber)
        if isempty(plotInformation{idx_sample,2})
            plotInformation(idx_sample,:) = [];
        end
    end

    output = plotInformation;
end

%-------------------------------%
%        construct data         %
%-------------------------------%
function output = getHallResultsFun(outputFile)
    % Idea: each measurement has a B=0 and a B=/=0 part, which are
    % disjunct. So let's mearch them to get all electronic information into
    % one object.
    fileContent = outputFile.results{1,1}.data;
    N = size(fileContent,1);
    TeilMessungen = cell(N,1);
    for j = 1:N
        thisTeilMessung.rho = fileContent(j,1).rho;
        thisTeilMessung.err_rho = fileContent(j,1).err_rho;
        thisTeilMessung.Iset = fileContent(j,1).Iset;

        thisTeilMessung.RH = fileContent(j,2).RH;
        thisTeilMessung.err_RH = fileContent(j,2).err_RH;
        thisTeilMessung.n = fileContent(j,2).n;
        thisTeilMessung.err_n = fileContent(j,2).err_n;
        thisTeilMessung.mu = fileContent(j,2).mu;
        thisTeilMessung.err_mu = fileContent(j,2).err_mu;
        
        thisTeilMessung.Imax = fileContent(j,1).I_max;
        thisTeilMessung.Iset = fileContent(j,1).Iset;
        TeilMessungen{j} = thisTeilMessung;
    end
    output = TeilMessungen;

end


%---------------------%
%    sample table     %
%---------------------%
function output = findIdsFun(Specs_Hall_RT)
% output as cell array
    sampleTable = searchSamples_v2(...
        searchSamplesPrompt(Specs_Hall_RT.property1,Specs_Hall_RT.value1),...
        true...
        );
    % sampleTableSorted = sortrows(sampleTable,Specs_Hall_RT.xAxis);
        % sortiere gemäß NameVal (fuer spaeter lesbare Legende)
    sampleTableSorted = sampleTable;
    output = sampleTableSorted;
end

%---------------------------%
%  average different I_set  %
%---------------------------%
function output = averageDifferentCurrentSet(inputCell,varargin)
% input is nx1 cell with each entry representing an I_set structure

inputStruct = cellfun(@(x) x,inputCell);
% the input is a nx1 cell array but we want it to be a nx1 structure
% array.

output = struct();

[output.rho,output.err_rho] = ...
    weightedMean([inputStruct.rho],[inputStruct.err_rho]);

[output.RH,output.err_RH] = ...
    weightedMean([inputStruct.RH],[inputStruct.err_RH]);

[output.n,output.err_n] = ...
    weightedMean([inputStruct.n],[inputStruct.err_n]);

[output.mu,output.err_mu] = ...
    weightedMean([inputStruct.mu],[inputStruct.err_mu]);

for i = 1:numel(inputCell)
    output.Iset(i) = inputStruct(i).Iset(2);
end

output.Imax = inputStruct.Imax;


end

function output = averageSingleCurrentSet(inputStruct)
% input is 1x1 structure

output = struct([]);

[output.err_RH,output.err_rho] = ...
    weightedMean(inputStruct.rho,inputStruct.err_rho);

[output.RH,output.err_RH] = ...
    weightedMean(inputStruct.RH,inputStruct.err_RH);

[output.n,output.err_n] = ...
    weightedMean(inputStruct.n,inputStruct.err_n);

[output.mu,output.err_mu] = ...
    weightedMean(inputStruct.mu,inputStruct.err_n);

output.Iset = inputStruct.Iset;
output.Imax = inputStruct.Imax;

end


