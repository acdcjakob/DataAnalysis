function [subPeaks,filmPeaks] = getRSMData(Id,plane)
% [sub,film] = getRSMData(Id,plane) looks in the <Id> folder for `XRD_RSM`
% and extracts data in the <plane>.txt-file. sub and film are column
% vectors.
%
% If there is not such a folder `data/<Id>/XRD_RSM` or if `<plane>.txt`
% does not exist, output will be NaN and a warning is thrown.
%
% <plane>.txt should have the following format:
%   subPeak_x       /t  subPeak_y
%   filmPeak_x      /t  filmPeak_y

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
    return
else
    % for symmetric reflexes I only wrote 1 line sometimes
    filmPeaks = subPeaks;
    subPeaks = [nan;nan];
end

end
