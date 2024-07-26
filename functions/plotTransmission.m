cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis")
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))


% ------ plot Specs ------
dontAskUser(2) = 1;
    % if not specified, dontAskUser(1) is automatically set to 0
if ~dontAskUser(1)
    Specs_Transmission.property1 = 'Batch';
    Specs_Transmission.value1 = 'Cr2O3_initial';
    
    Specs_Transmission.property2 = '';
    Specs_Transmission.value2 = '';
    
    Specs_Transmission.plotVis = true;
    Specs_Transmission.idx = 1;
end

if isempty(Specs_Transmission.property2)
    Specs_Transmission.property2 = Specs_Transmission.property1;
    Specs_Transmission.value2 = Specs_Transmission.value1;
end

SampleData = findIdsFun(Specs_Transmission);

% --- plot visible spectrum ---
if Specs_Transmission.plotVis
    P = patch([380 750 750 380],[0 0 1 1],[1,0,1]);
    P.FaceAlpha = 0.1;
    P.EdgeAlpha = 0.1;
    P.DisplayName = "Visible light";
    hold on
end
H = gobjects();
for idx_sample = 1:numel(SampleData.Id)
    
    MeasFileName = getFileNamesFromFolder(fullfile(...
        "data",...
        SampleData.Id{idx_sample},...
        "Transmission"),...
        '.dx');
    MeasFileDir = fullfile("data",SampleData.Id{idx_sample},"Transmission",MeasFileName);
    
    MeasData = importdata(MeasFileDir,' ',21);
    
    MeasData = MeasData.data;
    
    % RefData = findRefFun(MeasFileName);
    % y = MeasData(:,2)-RefData(:,2)+100;

    h = plot(MeasData(:,1),MeasData(:,2));
    h.DisplayName = SampleData.Id{idx_sample}+...
        " ("+string(SampleData.d(idx_sample))+" nm)";%+...
        %" "+SampleData.NameUnit{idx_sample}+")";
    h.LineWidth = 1;
    
    % --- style ---
    % h.LineStyle = LINESTYLE(Specs_Transmission.idx);
    % h.Color = LINECOLOR(idx_sample,Specs_Transmission.idx);
    allPlots(idx_sample) = h;
    hold on
    H(idx_sample,1) = h;
end
Ax = h.Parent;
legend
Ax.XLabel.String = "\lambda (nm)";
Ax.YLabel.String = "Transmission intensity (%)";
Ax.XLim = [0 1000];

Ax.XGrid = "on";
Ax.YGrid = "on";

if Specs_Transmission.plotVis
    P.Vertices = [transpose([380 750 750 380]),transpose([min(Ax.YLim)*[1 1] max(Ax.YLim)*[1 1]])];
end

linePainter(transpose(allPlots),"st",[.2 .8 .2],"end",[.8 .2 .8])
title("Transmission vs. thickness")

%%
% -------- Functions --------

function output = findIdsFun(Specs_Transmission)
% output as cell array
    sampleTable = searchSamples(Specs_Transmission.property1,Specs_Transmission.value1,true,...
        "searchDeeper",{Specs_Transmission.property2,Specs_Transmission.value2});
        % Ausschnitt aus Uebersicht; alle Samples des Batches
    sampleTableSorted = sortrows(sampleTable,"d");
        % sortiere gemäß NameVal (fuer spaeter lesbare Legende)
    output = sampleTableSorted;
end

function MeasData = findRefFun(MeasFileName)
    % Assume that all Transmission files are named like this:
    % "XXXXX_ddmmyy.dx"
    % So access the date and search for the corresponding reference file

    NameVector = char(MeasFileName);
    extensionIdx = strfind(NameVector,'.dx');
    MeasIdentifier = NameVector(extensionIdx-6:extensionIdx-1);
    allReferences = getFileNamesFromFolder("References/Transmission",'.dx');
    thisReferenceIdx = strfind(allReferences,MeasIdentifier);
    thisReferenceIdx = cellfun(@(x) ~isempty(x),thisReferenceIdx);
    thisReference = allReferences(thisReferenceIdx);
    if numel(thisReference)>1
        disp("plotTransmission.m: es existieren mehrere Referenzen.")
    end
    
    MeasFileDir = fullfile("data","References","Transmission",thisReference(1,1));
    MeasData = importdata(MeasFileDir,' ',21);
    MeasData = MeasData.data;
end