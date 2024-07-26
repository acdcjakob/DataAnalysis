originFolder = pwd;
cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");

subplot(1,2,1)
clear dontAskUser
plotXRD_v3
title("\Omega-"+sprintf("scan:\nTemperature Variation Cr_2O_3:ZnO"))
linePainter(H,"StartColor",[0 .2 1],"EndColor",[1 .2 0])
legend("location","southoutside","NumColumns",2)
%%
dontAskUser = 1;
    Specs_XRD.messung = 'XRD_2ThetaOmega';
    Specs_XRD.filter = '';
    % Specs_XRD.property2 = 'Annealed';
    % Specs_XRD.value2 = '';
subplot(1,2,2)
plotXRD_v3
title("2\theta-\Omega-"+sprintf("scan:\nTemperature Variation Cr_2O_3:ZnO"))
legend("location","southoutside","NumColumns",2)
linePainter(H,"StartColor",[0 .2 1],"EndColor",[1 .2 0])
xlim([38 43])
%%
clear dontAskUser

cd(originFolder)