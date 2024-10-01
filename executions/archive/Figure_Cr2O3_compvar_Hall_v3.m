subplot(2,2,1)
dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_CuO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='r-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';

plotHall_v3
% for i = 1:numel(H)
%     H(i).HandleVisibility = "off";
% end

l = plot(x,y);
l.Color = LINECOLOR(2);
l.LineWidth = 1.5;
l.DisplayName = "r-Saphir";

% ----

dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_CuO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='c-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';
plotHall_v3
% for i = 1:numel(H)
%     H(i).HandleVisibility = "off";
% end

l = plot(x,y);
l.Color = LINECOLOR(1);
l.LineWidth = 1.5;
l.DisplayName = "c-Saphir";


%%
subplot(2,2,3)


dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_ZnO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='r-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';

plotHall_v3
% for i = 1:numel(H)
%     H(i).HandleVisibility = "off";
% end

l = plot(x,y);
l.Color = LINECOLOR(2);
l.LineStyle = "--";
l.LineWidth = 1.5;
l.DisplayName = "r-Saphir";
% ----
dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_ZnO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='c-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';
plotHall_v3
% for i = 1:numel(H)
%     H(i).HandleVisibility = "off";
% end


l = plot(x,y);
l.Color = LINECOLOR(1);
l.LineStyle = "--";
l.LineWidth = 1.5;
l.DisplayName = "c-Saphir";
%%
subplot(2,2,[2,4])

dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_ZnO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='r-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';

plotHall_v3
for i = 1:numel(H)
    H(i).HandleVisibility = "off";
end

l = plot(x,y);
l.Color = LINECOLOR(2);
l.LineStyle = "--";
l.LineWidth = 1.5;
l.DisplayName = "ZnO r-Saphir";
% ----
dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_ZnO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='c-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';
plotHall_v3
for i = 1:numel(H)
    H(i).HandleVisibility = "off";
end


l = plot(x,y);
l.Color = LINECOLOR(1);
l.LineStyle = "--";
l.LineWidth = 1.5;
l.DisplayName = "ZnO c-Saphir";

% ----

dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_CuO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='r-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';

plotHall_v3
for i = 1:numel(H)
    H(i).HandleVisibility = "off";
end

l = plot(x,y);
l.Color = LINECOLOR(2);
l.LineWidth = 1.5;
l.DisplayName = "CuO r-Saphir";

% ----

dontAskUser = 1;
Specs_Hall_RT.property1='Batch';
Specs_Hall_RT.value1='Cr2O3_CuO_CompVar1';
Specs_Hall_RT.property2='Sub';
Specs_Hall_RT.value2='c-Al2O3';

Specs_Hall_RT.xAxis='$Batch';
Specs_Hall_RT.yAxis='rho$log';
Specs_Hall_RT.mean='1';
Specs_Hall_RT.Messung = 'Hall_RT';
plotHall_v3
for i = 1:numel(H)
    H(i).HandleVisibility = "off";
end 

l = plot(x,y);
l.Color = LINECOLOR(1);
l.LineWidth = 1.5;
l.DisplayName = "CuO c-Saphir";






title("Cr2O3 CompVar ZnO/CuO")
