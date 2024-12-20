dontaskuser = 1;
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis\"))
figure("OuterPosition",[100 100 500 500])
%%
subplot(2,2,1)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$c-Al2O3$a%%$Cr2O3_ZnO_CompVar1$c-Al2O3$a'};
peakPlanes="c";
x_ax = "d";


correlation_peakshift

grid
xlabel("film thickness (nm)")
ylabel("\Delta(00.6) (°)")

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
xlabel("film thickness (nm)")
ylabel("\Delta(30.0) (°)")

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
xlabel("film thickness (nm)")
ylabel("\Delta(01.2) (°)")

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
xlabel("film thickness (nm)")
ylabel("\Delta(11.0) (°)")

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