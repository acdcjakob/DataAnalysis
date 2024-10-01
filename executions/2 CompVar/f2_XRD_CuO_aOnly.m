addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis

dontAskUser = 1;
figure("OuterPosition",[100 100 500 500]);
%%
L = ["c";"m";"r";"a"];
Lit = [39.78;65.11;24.48;36.19];
%%

Specs_XRD.property1 = "%%$Batch$Sub$NameUnit";
Specs_XRD.value1 = "%%$Cr2O3_CuO_CompVar1$a-Al2O3$mm";
Specs_XRD.sortColumn= "d";
Specs_XRD.sortColumnName= "dUnit";
Specs_XRD.messung = "XRD_2ThetaOmega";
Specs_XRD.plotstyle = "s";
Specs_XRD.filter = '';
Specs_XRD.broken = '0';

plotXRD_v3
% title("a-orientation")

linePainter(H,"start",[.8 .4 .4],"end",[.4 .4 .8])
xlim(gca,[33 39])

n = 4;
p = xline(Lit(n),"k--","LineWidth",.8);
p.DisplayName = "literature "+sprintf("\n"+L(n)+"-plane: "+num2str(Lit(n)));

t = annotation("textarrow");
t.X = [.511 .444];
t.Y = [.2 .78];
t.String = sprintf("increasing thickness\n110 nm - 240 nm");
t.LineWidth = 1;
t.FontWeight = "bold";

% legend("FontSize",8,"NumColumns",2,"Location","northeast")
legend off
% b = annotation("textbox");
% b.String = sprintf("770°C, 1E-3 mbar O2, 40k Pulses");
% b.BackgroundColor = [1 1 1];
% b.Position = [.53 .18 .1 .1];
% b.Color = [.3 .3 .3];
% b.FitBoxToText = "on";
b = annotation("textbox");
b.String = "segmented Cr2O3-target on a-sapphire";
b.Position = [.1 .8 .1 .1];
b.BackgroundColor = [1 1 1];
b.FitBoxToText = "on";

%%
set(gcf,"Renderer","painters")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-xrd_aOnly.png","Resolution",250);
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-xrd_aOnly.pdf");