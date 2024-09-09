function output = get2Theta(hkl,varargin)
% get2Theta(hkl) returns the 2-theta angle at which the reflex hkl should
% apper. hkl is an array. Output is in *degrees*
% get2Theta(hkl,phase) returns the 2-theta angle (hkl angle) for the phase
% specified by phase; e.g.: phase = "Ga2O3"

p = inputParser();

addRequired(p,"hkl",@(x) true)
addOptional(p,"phase","Cr2O3",@(x) ischar(x)|isstring(x)|iscellstr(x))

parse(p,hkl,varargin{:})

d = @(hkl,a,c) 1/sqrt(4/3*(hkl(1)^2+hkl(2)^2+hkl(1)*hkl(2))/a^2 ...
    + hkl(3)^2/c^2);
theta2 = @(d,n) asin(n*1.5406/2/d)*2;

if strcmp(p.Results.phase,"Cr2O3")
    a_Cr = 4.96;
    c_Cr = 13.59;
    
    output = theta2(d(hkl,a_Cr,c_Cr),1);
    return
end


end

