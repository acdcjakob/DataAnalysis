function [deltaTheta,Theta] = peakPositionNormed(table,peakPhases,peakPlanes)
%PEAKPOSITIONNORMED(table,peakPhase,peakPlanes)
% table is the converted highscore table with entries Phase, h, k and l.
% peakPhases, e.g. {"Cr2O3","Al2O3"}
% peakPlanes, e.g. "m"

peak = [peakPhases(1),hkl_conv(peakPlanes)];
    % the investigated peak
peakRelative = [peakPhases(2),hkl_conv(peakPlanes)];
    % the "standard", e.g. substrate

% prepare the thing used for finding correct row of peak:
peak_idx = strcmp(table.Phase,peak{1}) & ...
    table.h == peak{2} & ...
    table.k == peak{3} & ...
    table.l == peak{4};

% prepare the thing used for finding correct row of reference:
peakRelative_idx = strcmp(table.Phase,peakRelative{1}) & ...
    table.h == peakRelative{2} & ...
    table.k == peakRelative{3} & ...
    table.l == peakRelative{4};

if ~any(peak_idx)
    % abort if the desired phase is not present in the table
    deltaTheta = NaN;
    Theta = NaN;
    return
else
    peak_data = table(peak_idx,:);
        % the investigated peak
end

if ~any(peakRelative_idx)
    deltaTheta = NaN;
    Theta = NaN;
    return
else
    peakRelative_data = table(peakRelative_idx,:);
        % the "standard"
end

% theta + (thetaSub_lit-thetaSub_meas)
Theta = peak_data.Pos + (...
    get2Theta(hkl_conv_arr(peakPlanes),"Al2O3") - peakRelative_data.Pos ...
    );
deltaTheta = Theta-get2Theta(hkl_conv_arr(peakPlanes),"Cr2O3");
% deltaTheta = peak_data.Pos - peakRelative_data.Pos - literatureDistance(peakPlanes);

% Theta = peak_data.Pos + literatureReference(peakPlanes) - peakRelative_data.Pos;
% literatureReference(peakPlanes) - peakRelative_data.Pos;

function output = hkl_conv(name)
    if strcmp(name,"c")
        output = {0,0,6};
    elseif strcmp(name,"m")
        output = {3,0,0};
    elseif strcmp(name,"r")
        output = {0,1,2};
    elseif strcmp(name,"a")
        output = {1,1,0};
    elseif strcmp(name,"r2")
        output = {0,2,4};
    end
end

function output = hkl_conv_arr(name)
    if strcmp(name,"c")
        output = [0 0 6];
    elseif strcmp(name,"m")
        output = [3 0 0];
    elseif strcmp(name,"r")
        output = [0 1 2];
    elseif strcmp(name,"a")
        output = [1 1 0];
    elseif strcmp(name,"r2")
        output = [0 2 4];
    end
end

% function output = literatureDistance(name)
%     [Cr2O3_peaks,Al2O3_peaks] = getPeakReference();
%     if strcmp(name,"c")
%         n = 1;
%     elseif strcmp(name,"m")
%         n = 2;
%     elseif strcmp(name,"r")
%         n = 3;
%     elseif strcmp(name,"a")
%         n = 4;
%     elseif strcmp(name,'r2')
%         n = 5;
%     end
%     output = Cr2O3_peaks(n)-Al2O3_peaks(n);
%     clear n;
% end

function output = literatureReference(name)
    [~,Al2O3_peaks] = getPeakReference();
    if strcmp(name,"c")
        n = 1;
    elseif strcmp(name,"m")
        n = 2;
    elseif strcmp(name,"r")
        n = 3;
    elseif strcmp(name,"a")
        n = 4;
    elseif strcmp(name,'r2')
        n = 5;
    end
    output = Al2O3_peaks(n);
    clear n;
end

end