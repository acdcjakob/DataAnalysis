cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))

T = searchSamples_v2({{"Batch","Cr2O3_CuO_CompVar1";"NameUnit","mm"}},true);

d = columnToNumber(T.d(:));
y = columnToNumber(T.NameVal(:));

scatter(y,d)
% scatter(1:numel(d),d)

xlabel("{\ity} on target (mm)")
ylabel("thickness (nm)")