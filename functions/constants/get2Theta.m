function output = get2Theta(hkl,varargin)
% get2Theta(hkl) returns the 2-theta angle at which the reflex hkl should
% appear. hkl is an array. Output is in *degrees*
% get2Theta(hkl,phase) returns the 2-theta angle (hkl angle) for the phase
% specified by phase; e.g.: phase = "Ga2O3"

p = inputParser();

addRequired(p,"hkl",@(x) true)
addOptional(p,"phase","Cr2O3",@(x) ischar(x)|isstring(x)|iscellstr(x))

parse(p,hkl,varargin{:})

d = @(hkl,a,c) 1/sqrt(...
    4/3*(hkl(1)^2+hkl(2)^2+hkl(1)*hkl(2))/a^2 ...
    + hkl(3)^2/c^2);

theta2 = @(d,n) 2 * asin(n*1.5406/2/d);
% Bragg equation: n*lambda = 2*d*sin(theta)

% constants in angstrom, because lambda is provided in angstrom

if strcmp(p.Results.phase,"Cr2O3")
    a = 4.96;
    c = 13.59;
    % source: Mi et al. (2018)
    output = theta2(d(hkl,a,c),1)*180/pi;
    return

elseif strcmp(p.Results.phase,"Ga2O3")
    a = 4.98;
    c = 13.43;
    % source: Marezio and Remeika (1967)
    output = theta2(d(hkl,a,c),1)*180/pi;
    return

elseif strcmp(p.Results.phase,"Al2O3")
    a = 4.76;
    c = 13.00;
    % source: Pishchik et al. (2009)
    output = theta2(d(hkl,a,c),1)*180/pi;
    return

end


end

