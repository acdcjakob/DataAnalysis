% New Features:
% broken x-axis implementation
%%
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))

% ------ Ask for specs ------

if ~exist('dontAskUser','var')
    load("_temp\lastXRD.mat")

    promptNames = fieldnames(Specs_XRD);
    promptDefault = cellfun(@char,struct2cell(Specs_XRD),"UniformOutput",false);
    answer = inputdlg(promptNames,'XRD User Input',1,promptDefault);
    if isempty(answer), return, end
    Specs_XRD = cell2struct(answer,fieldnames(Specs_XRD),1);

    save("_temp\lastXRD.mat","Specs_XRD")
    clear answer promptDefault promptNames
end


if isempty(Specs_XRD.plotstyle)
    disp("plotXRD_v2.m: no plotstyle given")
    return
elseif contains('alltogether',lower(Specs_XRD.plotstyle))
    [H,data] = plotAllTogetherFun(Specs_XRD);
elseif contains('shuffle',lower(Specs_XRD.plotstyle))
    [H,data] = plotShuffle(Specs_XRD);
end

%%

%------------------------------------%
%           plot Styles              %
%------------------------------------%
function [H,data] = plotAllTogetherFun(Specs_XRD)
    data = getAllDataFromBatch(Specs_XRD);
    showFiles(data)
    data = nameFilter(data,Specs_XRD);
    if isempty(data)
        msgbox("There is no data! :-(");
        H = [];
        return
    end
    H = gobjects(); H_idx = 1;
    for i = 1:numel(data(:,1))
        for i2 = 1:numel(data{i,2}(:,1))
            h = plot(data{i,2}{i2,2}{1},data{i,2}{i2,2}{2});
            % h.DisplayName = data{i,1}.Id{:}+" "+...
            %     string(data{i,1}.(Specs_XRD.sortColumn))+...
            %     string(data{i,1}.(Specs_XRD.sortColumnName));
            if strcmp(Specs_XRD.sortColumn,"NameVal")
                h.DisplayName = ...
                    string(data{i,1}.(Specs_XRD.sortColumn))+" "+...
                    string(data{i,1}.(Specs_XRD.sortColumnName));
            else
                h.DisplayName = ...
                    string(data{i,1}.(Specs_XRD.sortColumn))+" "+...
                    string(data{i,1}.(Specs_XRD.sortColumnName))+ ...
                    " ("+string(data{i,1}.NameVal{:})+string(data{i,1}.NameUnit{:})...
                    +")";
            end
            if i2>1
                h.DisplayName = h.DisplayName+" #"+num2str(i2);
            end
            h.LineWidth = 1.4;
            H(H_idx,1) = h;
            H_idx = H_idx+1;
            hold on
        end
    end
    Ax = h.Parent;
    Ax.YScale = "log";
    Ax.Title.String = Specs_XRD.value1;
        Ax.Title.Interpreter = "none";
    Ax.YLabel.String = "counts";
    if strcmp(Specs_XRD.messung,"XRD_2ThetaOmega")
        Ax.XLabel.String = "2\theta (°)";
    elseif strcmp(Specs_XRD.messung,"XRD_Omega")
        Ax.XLabel.String = "\omega (°)";
    elseif strcmp(Specs_XRD.messung,"XRD_Phi")
        Ax.XLabel.String = "\phi (°)";
    end
    linePainter(H);
    legend
    grid
    hold off
end

% SCHAFFEL

function [H_sort,data] = plotShuffle(Specs_XRD)

    data = getAllDataFromBatch(Specs_XRD);
    showFiles(data);
    data = nameFilter(data,Specs_XRD);
    H = gobjects();
    if isempty(data)
        msgbox("There is no data! :-(")
        H_sort = [];
        return
    end

    H_idx = 1;
    for i = 1:numel(data(:,1))
        for i2 = 1:numel(data{i,2}(:,1))
            xDeg = data{i,2}{i2,2}{1};
            yInt = data{i,2}{i2,2}{2};
            % prepare log
            thr = 1;
            yInt(yInt<thr)=thr;
            yIntLog = log(yInt);
            
            if H_idx>1
               factor = 6;
               yMitte = 1/factor*((factor-1)*min(inputData{H_idx-1,2})+max(inputData{H_idx-1,2}));
               % factor determines the distance
               yIntLog = yIntLog - min(yIntLog) + yMitte;
            end
            inputData{H_idx,1}=xDeg;
            inputData{H_idx,2}=yIntLog;
    
    
            H(H_idx) = plot(xDeg,yIntLog,'-');
            H_sort_idx(H_idx,:) = [i,i2];
            H_idx = H_idx+1;
            hold on
            grid minor
            
            % immer plotten als orientierung für broken x-axis
        end
    end

    % --- broken Axis ---
    if strcmp(Specs_XRD.broken,"1")
        filename = "temp"+date+".mat";
        if ~exist(filename)
            cuts = input("Gib [l1 r1;l2 r2; ...] ein\n");
        elseif exist(filename)
            load(filename,"cuts");
        end
        cla
        % clear die nicht-broken x-axis plots
        H = brokenXaxis_v3(inputData,...
            cuts,...
            [.5,0]);
    end
    % sort H
    H_sort = gobjects();
    for i = 1:size(H_sort_idx,1)
        H_sort(H_sort_idx(i,1),H_sort_idx(i,2))=H(i);
    end

    % -------------------
    

    for i = 1:numel(data(:,1))
        for i2 = 1:numel(data{i,2}(:,1))
            h = H_sort(i,i2);
            % h.Color = [h.Color 0.8];
            % (make transparent)
            % h.DisplayName = data{i,1}.Id{:}+" "+...
            %     string(data{i,1}.(Specs_XRD.sortColumn))+...
            %     string(data{i,1}.(Specs_XRD.sortColumnName));
            if strcmp(Specs_XRD.sortColumn,"NameVal")
                h.DisplayName = ...
                    string(data{i,1}.(Specs_XRD.sortColumn))+" "+...
                    string(data{i,1}.(Specs_XRD.sortColumnName));
            else
                h.DisplayName = ...
                    string(data{i,1}.(Specs_XRD.sortColumn))+" "+...
                    string(data{i,1}.(Specs_XRD.sortColumnName))+ ...
                    " ("+string(data{i,1}.NameVal{:})+string(data{i,1}.NameUnit{:})...
                    +")";
            end
            if i2>1
                h.DisplayName = h.DisplayName+" #"+num2str(i2);
            end
            h.Marker = "none";
            h.LineStyle = "-";
            h.LineWidth = 1;
            linePainter(h,"singleColor",[i,i2]);
            

            if ~strcmp(Specs_XRD.broken,"1")
                h.Parent.XGrid = "on";
            end
            

        end
    end
    Ax = gca;
    Ax.YTick = [];
    Ax.YLabel.String = "counts (a.u.)";
    if strcmp(Specs_XRD.messung,"XRD_2ThetaOmega")
        Ax.XLabel.String = "2\theta (°)";
    elseif strcmp(Specs_XRD.messung,"XRD_Omega")
        Ax.XLabel.String = "\omega (°)";
    elseif strcmp(Specs_XRD.messung,"XRD_Phi")
        Ax.XLabel.String = "\phi (°)";
    end
    legend(Ax)
    %legend("Location","southoutside","NumColumns",2)
    hold off

end



%-------------------------------------%
%              Functions              %
%-------------------------------------%


%----------%
% find Ids %
%----------%
function output = findIdsFun(Specs_XRD)
    % % give a TABLE with all files matching property1 and property2
    % % 
    % if isempty(Specs_XRD.property2)
    %     Specs_XRD.property2 = Specs_XRD.property1;
    %     Specs_XRD.value2 = Specs_XRD.value1;
    % end
    % 
    % sampleTable = searchSamples(Specs_XRD.property1,Specs_XRD.value1,...
    %     true,...
    %     "searchDeeper",...
    %     {Specs_XRD.property2,Specs_XRD.value2}...
    %     );
    %     % Ausschnitt aus Uebersicht; alle Samples des Batches
    % sampleTableSorted = sortrows(sampleTable,"NameVal");
    %     % sortiere gemäß NameVal (fuer spaeter lesbare Legende)
    % output = sampleTableSorted;

    sampleTable = searchSamples_v2(searchSamplesPrompt(...
        Specs_XRD.property1,Specs_XRD.value1),true);
    
    output = sortrows(sampleTable,Specs_XRD.sortColumn);

end


function DataRaw = getDataXRD(FilePfad)
%   XRD_2ThetaOmega(FilePfad) plottet Intensity vs. 2Theta.

fid = fopen(FilePfad);
NumCol = 2;
DataRaw = textscan(fid,repmat('%f',[1,NumCol]),...
    'delimiter','\t');
end




%------------------------%
%     get all data       %
%------------------------%
function output = getAllDataFromBatch(Specs_XRD)
% Data Structure:
% output:
% |sample1tabelle|thisData|
% |sample2tabelle|thisData|
% ...
%
% thisData:
% |"meas1ddmmyy.xy"|1x2 cell Data|
% |"meas2ddmmyy.xy"|1x2 cell Data|
% ...
%
% access one data array:
% output{n,2}{m,2}{1}
%

allSamplesTable = findIdsFun(Specs_XRD);
output = cell([]);
% 1st column: part of the table with all Information
for idx_sample = 1:numel(allSamplesTable.Id)
    output{idx_sample,1} = allSamplesTable(idx_sample,:);
    thisSample = allSamplesTable.Id{idx_sample};
    thisSamplePath = fullfile("data",thisSample,Specs_XRD.messung);
    thisSampleMeasurements = getFileNamesFromFolder(thisSamplePath,".xy");
        disp("plotXRD.m: zu "+thisSample+" gibt es "+num2str(numel(thisSampleMeasurements))+" durchgeführte Messung(en)")
    
    thisData = cell([]);
    for idx_meas = 1:numel(thisSampleMeasurements)
        thisData{idx_meas,1} = thisSampleMeasurements(idx_meas);
        thisPath = fullfile("data",thisSample,Specs_XRD.messung,thisSampleMeasurements(idx_meas));
        thisData{idx_meas,2} = getDataXRD(thisPath);
    end
    output{idx_sample,2} = thisData;
end
end




%--------------%
%  namefilter  %
%--------------%
function output = nameFilter(completeData,Specs_XRD)
% filter is char '$filter1$filter2'
    % remove all samples with no meas. in first place
    completeData = deleteEmptySample(completeData);

    % find filter
    dollarIdx = strfind(Specs_XRD.filter,'$');
    keyNames = cell(numel(dollarIdx),1);
    if isempty(dollarIdx)
        disp("plotXRD.m: kein Filter angegeben")
        output = completeData;
        return
    elseif numel(dollarIdx) > 1
        for i = 1:numel(dollarIdx)-1
            keyNames{i} = Specs_XRD.filter(dollarIdx(i)+1:dollarIdx(i+1)-1);
        end
    end
    keyNames{numel(dollarIdx)} = Specs_XRD.filter(dollarIdx(end)+1:end);
    
    
    % remove all files without keyNames
    for idx_sample = 1:numel(completeData(:,1))
        keepIdx = [];
        for idx_key = 1:numel(keyNames)
            measNames = completeData{idx_sample,2}(:,1);
            thisKeyName = keyNames{idx_key};
            for idx_meas = 1:numel(measNames)
                thisFileName = completeData{idx_sample,2}{idx_meas,1};
                if contains(thisFileName,thisKeyName)
                    keepIdx = [keepIdx,idx_meas;];
                    disp("plotXRD.m: "+thisFileName+" enthält "+thisKeyName+" und wird behalten.")
                end
            end
        end
        sort(unique(keepIdx));
            % delete duplicates for multiple correct keywords
        completeData{idx_sample,2} = completeData{idx_sample,2}(keepIdx,:);
    end
    
    % again delete empty
    output = deleteEmptySample(completeData);
    
end

%----------------%
%  delete empty  %
%----------------%
function output = deleteEmptySample(completeData)
    % remove all samples with no meas. left
    deleteIdx = [];
    for idx_sample = 1:numel(completeData(:,1))
        if isempty(completeData{idx_sample,2})
            deleteIdx = [deleteIdx,idx_sample];
            disp("plotXRD.m: "+completeData{idx_sample,1}.Id{:}+" wird gelöscht. Keine Messungen übrig.")
        end
    end
    completeData(deleteIdx,:) = [];
    output = completeData;
end



function [] = showFiles(x)
    fprintf("\n---all files---\n")
    x = deleteEmptySample(x);
        % delete empty
    for i = 1:numel(x(:,1))
        for j = 1:numel(x{i,2}(:,1))
            disp(x{i,2}{j,1})
        end
        fprintf("\n")
    end
    fprintf("---end all files---\n")
end