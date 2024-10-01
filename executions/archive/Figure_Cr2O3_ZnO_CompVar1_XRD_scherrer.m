originFolder = pwd;
cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");
dontAskUser = true;
%% c
search = {...
    {'Batch','Cr2O3_ZnO_CompVar1';...
        'Sub','c-Al2O3';...
        'NameUnit','mm'}...
    };
messung = "XRD_2ThetaOmega";
phase = ["Cr2O3" "Al2O3"];
orientation = "c";
Y = 'scherrer';

subplot(2,2,1)
analyzePeaks_v2
xlabel("Laser Position during PLD")
title("Cr2O3:ZnO on c-Sapphire")

%% m
search = {...
    {'Batch','Cr2O3_ZnO_CompVar1';...
        'Sub','m-Al2O3';...
        'NameUnit','mm'}...
    };
messung = "XRD_2ThetaOmega";
phase = ["Cr2O3" "Al2O3"];
orientation = "m";
Y = 'scherrer';

subplot(2,2,3)
analyzePeaks_v2
xlabel("Laser Position during PLD")
title("Cr2O3:ZnO on m-Sapphire")

%% r
search = {...
    {'Batch','Cr2O3_ZnO_CompVar1';...
        'Sub','r-Al2O3';...
        'NameUnit','mm'}...
    };
messung = "XRD_2ThetaOmega";
phase = ["Cr2O3" "Al2O3"];
orientation = "r";
Y = 'scherrer';

subplot(2,2,2)
analyzePeaks_v2
xlabel("Laser Position during PLD")
title("Cr2O3:ZnO on r-Sapphire")


%% a
search = {...
    {'Batch','Cr2O3_ZnO_CompVar1';...
        'Sub','a-Al2O3';...
        'NameUnit','mm'}...
    };
messung = "XRD_2ThetaOmega";
phase = ["Cr2O3" "Al2O3"];
orientation = "a";
Y = 'scherrer';

subplot(2,2,4)
analyzePeaks_v2
xlabel("Laser Position during PLD")
title("Cr2O3:ZnO on a-Sapphire")
%%
sgtitle(sprintf("Crystallite sizes for Cr2O3:ZnO\n(Scherrer equation K=0.9)"))

cd(originFolder)