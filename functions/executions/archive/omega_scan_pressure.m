addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis


dontAskUser = 1;
%%
Specs_XRD.property1 = "%%$Batch$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_initial$mbar";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Omega";
Specs_XRD.plotstyle = "allt";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3


for i_sample = 1:numel(data(:,1))
    thisId = data{i_sample,1}.Id{:};
    thisSamplePeaks = findData(thisId,"XRD_omega");
        % table from HighScore
    X(i_sample) = double(string(data{i_sample,1}.NameVal{:}));
    Y(i_sample) = thisSamplePeaks.FWHM;
end
ax1 = gca;
title("\omega-scans","Interpreter","tex");
linePainter(ax1.Children,"StartColor",[.2 .2 .5],"Endcolor",[.2 .9 .9])
ax1.XLim = ax1.XLim-[3 0];
legend("Location","northwest")

ax2 = axes("Position",[.2 .2 .4 .3]);
p = plot(X,Y);
ax2.YLabel.String = "FWHM (°)";
ax2.XLabel.String = "Oxygen pressure (mbar)";
p.Marker = "s";
p.LineWidth = 1.5;
ax2.XScale = "log";
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