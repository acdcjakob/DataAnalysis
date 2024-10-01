dontAskUser = 1;
figure();
set(gcf,"OuterPosition",[100 100 500 500]);
%%
Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_CuO_CompVar1$c-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'Rocking';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

plotHall_v4();
    grid on
    yscale("log")
    H(2).DisplayName = "CuO low I_{set}";
    H(1).DisplayName = "CuO high I_{set}";
    legend

    HC = H;

Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
Specs_Hall_RT.value1 = '%%$Cr2O3_ZnO_CompVar1$c-Al2O3$mm';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'Rocking';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

plotHall_v4();
    yscale("log")
    H(2).DisplayName = "ZnO low I_{set}";
    H(2).Marker = "o";
    H(1).DisplayName = "ZnO high I_{set}";
    H(1).Marker = "o";
    legend

    HC = [HC;H];
%%

Specs_Hall_RT.property1 = '%%$Id';
Specs_Hall_RT.value1 = '%%$W6788c';
Specs_Hall_RT.Messung = 'Hall_RT';
Specs_Hall_RT.xAxisProp = 'Batch';
Specs_Hall_RT.xAxis = 'Rocking';
Specs_Hall_RT.yAxis = 'rho';
Specs_Hall_RT.mean = '0';
Specs_Hall_RT.filter = '';

plotHall_v4();
    grid on
    yscale("log")
    H(2).DisplayName = "pure Cr_2O_3 low I_{set}";
    H(2).Marker = "diamond";
    H(2).MarkerSize = 10;
    H(2).MarkerFaceColor = [.5 .5 .5];
    H(2).MarkerEdgeColor = "m";
    H(2).LineStyle = "none";
    H(2).Color = "m";
    delete(H(1));
    % H(1).DisplayName = "pure Cr_2O_3 high I_{set}";
    % H(1).Marker = "diamond";
    % H(1).MarkerSize = 15;
    % H(1).MarkerFaceColor = "k";
    % H(1).MarkerEdgeColor = "m";



%%
title("resistivity vs. \omega-FWHM")
linePainter(HC,'prio',1)
ax1 = gca;
    ax1.FontSize = 12;
    ax1.Legend.FontSize = 10;
    ax1.Title.FontSize = 10;
%%
% exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-rho_vs_rocking.png")
exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-rho_vs_rocking.pdf")