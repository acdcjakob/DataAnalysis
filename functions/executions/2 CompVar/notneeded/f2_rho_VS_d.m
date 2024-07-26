dontAskUser = 1;

F = figure("OuterPosition",[100 100 600 500]);
axmatrix = gobjects(4,1);
%%
Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_ZnO_CompVar1$c-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'd';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

axmatrix(1) = axes("OuterPosition",[.05 .5 .45 .4]);
plotHall_v4();
    grid
    title("\rho vs. d (ZnO-doped on c-sapphire)")
    yscale("log")
    H(2).DisplayName = "low I_{set}";
    H(1).DisplayName = "high I_{set}";
    legend
    HZnO = H;
    


Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_ZnO_CompVar1$r-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'd';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

axmatrix(2) = axes("OuterPosition",[.55 .5 .45 .4]);
plotHall_v4();
    grid
    title("\rho vs. d (ZnO-doped on r-sapphire)")
    yscale("log")
    H(2).DisplayName = "low I_{set}";
    H(1).DisplayName = "high I_{set}";
    % legend
    HZnO = [HZnO H];

Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_CuO_CompVar1$c-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'd';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

axmatrix(3) = axes("OuterPosition",[.05 .05 .45 .4]);
plotHall_v4();
    grid
    title("\rho vs. d (CuO-doped on c-sapphire)")
    yscale("log")
    H(2).DisplayName = "low I_{set}";
    H(1).DisplayName = "high I_{set}";
    legend
    HCuO = H;

Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_CuO_CompVar1$r-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'd';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

axmatrix(4) = axes("OuterPosition",[.55 .05 .45 .4]);
plotHall_v4();
    grid
    title("\rho vs. d (CuO-doped on r-sapphire)")
    yscale("log")
    H(2).DisplayName = "low I_{set}";
    H(1).DisplayName = "high I_{set}";
    % legend
    HCuO = [HCuO H];

for n = 1:4
    ax = axmatrix(n);
    ax.FontSize = 10;
    if ~isempty(ax.Legend)
        ax.Legend.FontSize = 8;
    end
    ax.Title.FontSize = 10;
end
%%
linkaxes(axmatrix)
xlim([100 240])
ylim([1e-2 2e1])
% sgtitle("\rho vs. thickness")

linePainter(HZnO);
linePainter([gobjects(2,2);HCuO])

%%
exportgraphics(F,"../Plots/Cr2O3/2 CompVar/2-rho_vs_d.pdf")