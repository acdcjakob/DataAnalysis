function [subPeaks,filmPeaks] = getRSMData(Id,plane)

if ~exist(fullfile("data",Id,"XRD_RSM"),"dir")
    subPeaks = [nan;nan];
    filmPeaks = [nan;nan];
    warning("No RSM folder for "+Id)
    return
elseif ~exist(fullfile("data",Id,"XRD_RSM",plane+".txt"),"file")
    subPeaks = [nan;nan];
    filmPeaks = [nan;nan];
    warning("No RSM data for "+Id+"/"+plane)
    return
end

data = readmatrix(fullfile("data",Id,"XRD_RSM",plane+".txt"));
dataSz = size(data);
subPeaks = transpose(data(1,:));
if dataSz(1)>1
    filmPeaks = transpose(data(2,:));
else
    % for symmetric reflexes I only wrote 1 line sometimes
    filmPeaks = subPeaks;
    subPeaks = [nan;nan];
end

end
