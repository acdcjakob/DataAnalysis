dontaskuser = 1;
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis\"))
%%
subplot(2,2,1)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$c-Al2O3$a%%$Cr2O3_ZnO_CompVar1$c-Al2O3$a'};
peakPlanes="c";
x_ax = "NameVal";


correlation_peakshift

grid
xlabel("y (mm)")
ylabel("\Delta(006) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "CuO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.Color = [0 0 0 .2];
p.HandleVisibility = "off";

n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "ZnO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.HandleVisibility = "off";
p.Color = [1 0 0 .2];


title("c-orientation")
legend("Location","north")
%%
subplot(2,2,2)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$m-Al2O3$a%%$Cr2O3_ZnO_CompVar1$m-Al2O3$a'};
peakPlanes="m";


correlation_peakshift

grid
xlabel("y (mm)")
ylabel("\Delta(300) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "CuO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.HandleVisibility = "off";
p.Color = [0 0 0 .2];

n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "ZnO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.HandleVisibility = "off";
p.Color = [1 0 0 .2];

title("m-orientation")

%%
subplot(2,2,3)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$r-Al2O3$a%%$Cr2O3_ZnO_CompVar1$r-Al2O3$a'};
peakPlanes="r";


correlation_peakshift

grid
xlabel("y (mm)")
ylabel("\Delta(012) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "CuO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.Color = [0 0 0 .2];

n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "ZnO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.Color = [1 0 0 .2];

title("r-orientation")
%%
subplot(2,2,4)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$a-Al2O3$a%%$Cr2O3_ZnO_CompVar1$a-Al2O3$a'};
peakPlanes="a";


correlation_peakshift

grid
xlabel("y (mm)")
ylabel("\Delta(110) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "CuO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.Color = [0 0 0 .2];

n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
H(n).DisplayName = "ZnO";
m = polyfit(H(n).XData,H(n).YData,1);
p = plot(H(n).XData,H(n).XData*m(1)+m(2),"-");
p.Color = [1 0 0 .2];


title("a-orientation")