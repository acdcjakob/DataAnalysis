Specs_Hall_RT = struct( ...
    'property1','Batch', ...
    'value1','Cr2O3_ZnO_CompVar1', ...
    'property2','Sub', ...
    'value2','c-Al2O3', ...
    'Messung','Hall_RT', ...
    'Combined','1', ...
    'xAxis','$Batch', ...
    'yAxis','rho$log', ...
    'mean','1' ...
    );

dontAskUser = 1;

plotHall_v3
l = plot(x,y);
l.DisplayName = "c-Saphirre ZnO";
l.LineWidth = 1;
l.Color = "B";

%%
Specs_Hall_RT.value1 = 'Cr2O3_ZnO_CompVar1';
Specs_Hall_RT.value2 = 'r-Al2O3';
Specs_Hall_RT.xAxis = '$Batch';
Specs_Hall_RT.yAxis = 'rho$log';

plotHall_v3
l = plot(x,y);
l.DisplayName = "r-Saphhire ZnO";
l.LineWidth = 1;
l.Color = "K";

%%
Specs_Hall_RT.value1 = 'Cr2O3_CuO_CompVar1';
Specs_Hall_RT.value2 = 'c-Al2O3';
Specs_Hall_RT.xAxis = '$Batch';
Specs_Hall_RT.yAxis = 'rho$log';

plotHall_v3
l = plot(x,y);
l.DisplayName = "c-Saphhire CuO";
l.LineWidth = 1;
l.Color = "M";

%%
Specs_Hall_RT.value1 = 'Cr2O3_CuO_CompVar1';
Specs_Hall_RT.value2 = 'r-Al2O3';
Specs_Hall_RT.xAxis = '$Batch';
Specs_Hall_RT.yAxis = 'rho$log';

plotHall_v3
l = plot(x,y);
l.DisplayName = "r-Saphhire CuO";
l.LineWidth = 1;
l.Color = "R";
