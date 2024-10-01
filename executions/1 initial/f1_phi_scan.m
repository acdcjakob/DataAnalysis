addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis

dontAskUser = 1;
F = figure("OuterPosition",[100 100 800 500]);
set(F,'renderer','Painters');
%%
subplot(3,2,1)
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6715";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData+90;
H(2).XData = H(2).XData+90;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

subplot(3,2,2)
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6716";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData-90;
H(2).XData = H(2).XData-90;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

subplot(3,2,3)
Specs_XRD.property1 = "%%$Id$NameUnit";
Specs_XRD.value1 = "%%$W6723$mbar";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData+90;
H(2).XData = H(2).XData+90;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

subplot(3,2,4)
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6724";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData-90;
H(2).XData = H(2).XData-90;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

%%
subplot(3,2,5)
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6725";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData+180;
H(2).XData = H(2).XData+180;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

subplot(3,2,6)
Specs_XRD.property1 = "%%$Id";
Specs_XRD.value1 = "%%$W6726";
Specs_XRD.sortColumn = "NameVal";
Specs_XRD.sortColumnName = "NameUnit";
Specs_XRD.messung = "XRD_Phi";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3, xlim([0 360])
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).XData = H(1).XData-90;
H(2).XData = H(2).XData-90;
newData = [bringTo360(transpose(H(1).XData)),transpose(H(1).YData)];
    newData = sortrows(newData);
    H(1).XData = newData(:,1);
    H(1).YData = newData(:,2);
newData = [bringTo360(transpose(H(2).XData)),transpose(H(2).YData)];
    newData = sortrows(newData);
    H(2).XData = newData(:,1);
    H(2).YData = newData(:,2);
H(1).DisplayName = H(1).DisplayName+" (Film)";
H(2).DisplayName = H(2).DisplayName+" (Sub)";
set(gca,"FontSize",10);
l = legend;
l.FontSize = 8;

for j =  1:6
    subplot(3,2,j)
    set(gca,"XTick",0:60:360)
end
sgtitle("(30.6)-plane on m-oriented Cr_2O_3/Al_2O_3","Fontsize",10,"Fontweight","bold")
%%
% sgtitle("In-plane orientation of thin films (\phi-scan)"+sprintf("\n(012) plane in m-Cr_2O_3"))

% Zoom on peaks (comment out)
% subplot(3,2,1)
% xlim([50 55])
% subplot(3,2,2)
% xlim([123 128])
% subplot(3,2,4)
% xlim([230 235])
% subplot(3,2,5)
% xlim([215 220])
% subplot(3,2,3)
% xlim([52 57])
% subplot(3,2,6)
% xlim([123 128])
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-phi_scan.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-phi_scan.png","Resolution",250)