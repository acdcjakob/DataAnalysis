dontaskuser = 1;
x_ax = "d";
%%
subplot(2,2,1)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$c-Al2O3$a%%$Cr2O3_ZnO_CompVar1$c-Al2O3$a%%$Cr2O3_ZnO_PowerVar1$c-Al2O3$a%%$Cr2O3_ZnO_CompVar2$c-Al2O3$a'};
peakPlanes="c";


correlation_peakshift

grid
xlabel("film thickness (nm)")
ylabel("\Delta(006) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 3;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "s";
n = 4;
H(n).MarkerFaceColor = "g";
H(n).MarkerEdgeColor = "g";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";

title("c-orientation")
%%
subplot(2,2,2)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_initial$m-Al2O3$a%%$Cr2O3_CuO_CompVar1$m-Al2O3$a%%$Cr2O3_ZnO_CompVar1$m-Al2O3$a%%$Cr2O3_ZnO_CompVar2$m-Al2O3$a'};
peakPlanes="m";


correlation_peakshift

grid
xlabel("film thickness (nm)")
ylabel("\Delta(300) (°)")

n = 1;
H(n).MarkerFaceColor = "b";
H(n).MarkerEdgeColor = "b";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 2;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 3;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 4;
H(n).MarkerFaceColor = "g";
H(n).MarkerEdgeColor = "g";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";

title("m-orientation")
%%
subplot(2,2,3)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$r-Al2O3$a%%$Cr2O3_ZnO_CompVar1$r-Al2O3$a%%$Cr2O3_ZnO_PowerVar1$r-Al2O3$a%%$Cr2O3_ZnO_CompVar2$r-Al2O3$a'};
peakPlanes="r";


correlation_peakshift

grid
xlabel("film thickness (nm)")
ylabel("\Delta(012) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 3;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "s";
n = 4;
H(n).MarkerFaceColor = "g";
H(n).MarkerEdgeColor = "g";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
delete(H(n))

title("r-orientation")
%%
subplot(2,2,4)
prompt={'%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega%%$Batch$Sub$ThetaOmega',...
    '%%$Cr2O3_CuO_CompVar1$a-Al2O3$a%%$Cr2O3_ZnO_CompVar1$a-Al2O3$a%%$Cr2O3_ZnO_CompVar2$a-Al2O3$a'};
peakPlanes="a";


correlation_peakshift

grid
xlabel("film thickness (nm)")
ylabel("\Delta(110) (°)")

n = 1;
H(n).MarkerFaceColor = "k";
H(n).MarkerEdgeColor = "k";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 2;
H(n).MarkerFaceColor = "r";
H(n).MarkerEdgeColor = "r";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";
n = 3;
H(n).MarkerFaceColor = "g";
H(n).MarkerEdgeColor = "g";
H(n).MarkerFaceAlpha = .4;
H(n).Marker = "o";

title("a-orientation")