addpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");
A1 = subplot(1,2,1);
plotXRD_v3
title("Power Variation")
A1.XGrid = "on";
n = numel(A1.Children);
for i = 1:n
    A1.Children(i).Color = ...
        [0 1-i/n i/n];

end

A2 = subplot(1,2,2);
plotXRD_v3
title("Pressure Variation")
A2.XGrid = "on";
n = numel(A2.Children);
for i = 1:n
    A2.Children(i).Color = ...
        [1-i/n i/n .5];

end