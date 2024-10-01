function output = insertReference(phaseString,orientationString)
%INSERTREFERENCE Summary of this function goes here
addpath("functions/_general_functions/constants");
REFERENCES;

if strcmp(phaseString,"Cr2O3")
    % a=4.958 angstrom literatur:
    peaks = Cr2O3_peaks;
    % XRD-meas Haus-eigenes target
    peaks = Cr2O3_peaks_own;
    if strcmp(orientationString,"c")
        loc = peaks(1);
    elseif strcmp(orientationString,"m")
        loc = peaks(2);
    elseif strcmp(orientationString,"r")
        loc = peaks(3);
    elseif strcmp(orientationString,"a")
        loc = peaks(4);
    end
elseif strcmp(phaseString,"Al2O3")

end

p = xline(loc);
p.DisplayName = "Lit. "+orientationString+"-"+phaseString+" ("+num2str(loc)+"°)";
p.Color = "k";
p.LineStyle = "--";
p.LineWidth = .5;

output = p;
end

