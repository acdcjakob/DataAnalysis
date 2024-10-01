addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis


dontAskUser = 1;
%%
Specs_XRD.property1 = "%%$Batch";
Specs_XRD.value1 = "%%$Cr2O3_initial";
Specs_XRD.sortColumn = "d";
Specs_XRD.sortColumnName = "dUnit";
Specs_XRD.messung = "XRD_Omega";
Specs_XRD.plotstyle = "allt";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3


for i_sample = 1:numel(data(:,1))
    thisId = data{i_sample,1}.Id{:};
    thisSamplePeaks = findData(thisId,"XRD_omega");
        % table from HighScore
    X(i_sample) = data{i_sample,1}.d(:);
    Y(i_sample) = thisSamplePeaks.FWHM;
end
ax1 = gca;
title("\omega-scans","Interpreter","tex");
linePainter(ax1.Children,"StartColor",[.2 .8 .2],"Endcolor",[.8 .2 .8])
ax1.XLim = ax1.XLim-[3 0];
legend("Location","northwest")

ax2 = axes("Position",[.2 .2 .4 .3]);
p = plot(X,Y);
ax2.YLabel.String = "FWHM (°)";
ax2.XLabel.String = "Thickness (nm)";
p.Marker = "s";
p.LineWidth = 1.5;
ax2.XScale = "log";
p.Color = [.2 .8 .2];
grid on
title("FWHM from \omega-scan");

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