function output = energyDensity(inputL,varargin)
%ENERGYDENSITY evaluates laser energy density at W-chamber
%   energyDensity(inputL) takes L-value in cm
%   energyDensity(___,true) gives output as .2f string
%   energyDensity(___,true,energy) takes energy as input (default: 650);
if ischar(inputL) || isstring(inputL)
    inputL = str2double(inputL);
end

p = inputParser();
addRequired(p,"inputL",@(x) true)
addOptional(p,"text",false,@(x) true)
addOptional(p,"energy",650,@(x) true)

parse(p,inputL,varargin{:})

if ischar(p.Results.energy) || isstring(p.Results.energy)
    energy = str2double(p.Results.energy);
else
    energy = p.Results.energy;
end

% L = [0, -5, -15, -10, +5, -20]; % mm
% A = [15.05, 13.05, 9.92, 11.13, 18.81, 7.61]; % mm^2
% pFit = polyfit(L,A,2);
% calculated once

% in chamber we have 164 mJ left, when 650 is applied.
% Assume linearity
P = 164.3 * energy/650; % mJ
pFit = [0.0074    0.5304   15.6129];

for i = 1:numel(inputL)
    density(i) = P/1000 / (polyval(pFit,inputL(i)*10) / 100); % J / cm^2
    if p.Results.text
        output(i) = num2str(density(i),"%.1f")+" J/cm^2";
    else
        output(i) = density(i);
    end
end

end

