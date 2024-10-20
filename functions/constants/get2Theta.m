function output = get2Theta(hkl,varargin)
% get2Theta(hkl) returns the 2-theta angle at which the reflex hkl should
% appear. hkl is an array. Output is in *degrees*
% get2Theta(hkl,phase) returns the 2-theta angle (hkl angle) for the phase
% specified by phase; e.g.: phase = "Ga2O3"
% Documentation of copper input
    % The idea is that you can give the location of the observed K-alpha1
    % substrate peak and then every other peak is "rescaled" such that the
    % K-alpha1 predicted peak rom this function matches the experiment.
    % we have d'=lambda/(2*sin(theta')) from the observed hkl peak
    % Now we can calculate d from hkl and the theoretical wavelength.
    % There will be a deviation r=d'/d.
    % This "factor" can be used to rescale the 2theta angle:
    % output = 2*asin[ lambda / (2*d*r) ]

p = inputParser();

addRequired(p,"hkl",@(x) true)
addOptional(p,"phase","Cr2O3",@(x) ischar(x)|isstring(x)|iscellstr(x))
addOptional(p,"radiation","CuKa1",@(x) ischar(x)|isstring(x)|iscellstr(x))
addOptional(p,"copper",0,@(x) true)

parse(p,hkl,varargin{:})

d = @(hkl,a,c) 1/sqrt(...
    4/3*(hkl(1)^2+hkl(2)^2+hkl(1)*hkl(2))/a^2 ...
    + hkl(3)^2/c^2);

if p.Results.copper > 0
    
end

if strcmp(p.Results.radiation,"CuKa1")
    lambda = 1.5406;
elseif strcmp(p.Results.radiation,"CuKa2")
    lambda = 1.5444;
elseif strcmp(p.Results.radiation,"CuKb")
    lambda = 1.3922;
elseif strcmp(p.Results.radiation,"WLa1")
    lambda = 1.4764;
    % soruce: https://xdb.lbl.gov/Section1/Table_1-2.pdf
elseif strcmp(p.Results.radiation,"WLa2")
    lambda = 1.4875;
    % soruce: https://xdb.lbl.gov/Section1/Table_1-2.pdf
elseif strcmp(p.Results.radiation,"WLb1")
    lambda = 1.2818;
elseif strcmp(p.Results.radiation,"WLb2")
    lambda = 1.2446;
elseif strcmp(p.Results.radiation,"NiKa1")
    lambda = 1.6579;
elseif strcmp(p.Results.radiation,"TaLa2")
    % tallium ? next to K-alpha line of copper
    lambda = 1.5329;
elseif strcmp(p.Results.radiation,"CoKb1")
    lambda = 1.6208;
end

    theta2 = @(d,factor,n) 2 * asin(n*lambda/2/(d*factor));
% Bragg equation: n*lambda = 2*d*sin(theta)

% constants in angstrom, because lambda is provided in angstrom

if strcmp(p.Results.phase,"Cr2O3")
    a = 4.96;
    c = 13.59;
    % source: Mi et al. (2018)

elseif strcmp(p.Results.phase,"Ga2O3")
    a = 4.98;
    c = 13.43;
    % source: Marezio and Remeika (1967)

elseif strcmp(p.Results.phase,"Al2O3")
    a = 4.76;
    c = 13.00;
    % source: Pishchik et al. (2009)
end

if p.Results.copper > 0
    dPred = d(hkl,a,c);
    dReal = 1.5406/(2*sind(p.Results.copper/2));
    factor = dReal/dPred;
else
    factor = 1;
end

output = theta2(d(hkl,a,c),factor,1)*180/pi;

end

