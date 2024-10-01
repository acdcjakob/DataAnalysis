originFolder = pwd;
cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");
dontAskUser = true;
%% c
search = {...
    {'Batch','Cr2O3_ZnO_PowerVar1';...
        'Sub','c-Al2O3';...
        'Annealed',''}...
    };
messung = "XRD_Omega";
phase = ["Cr2O3"];
orientation = "c";
Y = 'FWHM';

%subplot(2,2,1)
analyzePeaks_v2
xlabel("Growth Power")
title("Cr2O3:ZnO on c-Sapphire")


%%
%sgtitle(sprintf("Crystallite sizes for Cr2O3:CuO\n(Scherrer equation K=0.9)"))

cd(originFolder)

