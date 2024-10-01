addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"));
load PLOTCONSTANT
F = figure("OuterPosition",[100 100 500 500]);
%%
PowerVar = searchSamples_v2(...
    {{"Batch","Cr2O3_initial";"NameUnit","°C"}},...
    true);
PowerVar = sortrows(PowerVar,"NameVal");

PressureVar = searchSamples_v2(...
    {{"Batch","Cr2O3_initial";"NameUnit","mbar"}},...
    true);
PressureVar = sortrows(PressureVar,"NameVal");

X_Power = str2double(PowerVar.NameVal);
X_Pressure = str2double(PressureVar.NameVal);

Y_Power = growthrateFun(PowerVar)*1000; % pm/pulse
Y_Pressure = growthrateFun(PressureVar)*1000; % pm/pulse

%%


H(1) = plot(X_Power,Y_Power,"s-");
H(1).DisplayName = "growth temperature";
ax1 = gca;
set(ax1,"Position",get(ax1,"Position")+[0 0.05 0 -0.1])
set(ax1,'box','off')
ax1.FontSize = 12;

ax2 = axes("Position",get(ax1,"Position"),"Color","None");
set(ax2,"box","off")
set(ax2,"XAxisLocation","top")
set(ax2,"YAxisLocation","right")
hold on
H(2,1) = plot(ax2,X_Pressure,Y_Pressure,"s-");
H(2).DisplayName = "oxygen pressure";     

set(ax2,"XScale","log")
set(ax2,"YLim",get(ax1,"YLim"))
set(ax2,"YTick",[])


linePainter(H,"priority",1)
l = legend([H(1),H(2)]);

set(get(ax1,"XLabel"),"string","growth temperature (°C)");
set(get(ax1,"XLabel"),"Fontweight","bold")
set(get(ax1,"YLabel"),"string","growth rate (pm/pulse)");
set(get(ax2,"XLabel"),"string","Oxygen Pressure (mbar)");
set(get(ax2,"XLabel"),"Fontweight","bold")

set(ax1,"XColor",hex2rgb(LINECOLOR(1,1)).*0.6);
set(ax2,"XColor",hex2rgb(LINECOLOR(2,1)).*0.4);
set(ax1,"YGrid","on")

hold off
fontsize(10,"points")
%%
exportgraphics(F, "../Plots/Cr2O3/1 initial/1-growthrate_vs_parameter.pdf")
exportgraphics(F, "../Plots/Cr2O3/1 initial/1-growthrate_vs_parameter.png","Resolution",250)