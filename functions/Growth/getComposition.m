function x = getComposition(r,varargin)
% x = getComposition(r) calculates composition x in percent for radial
% position r of laser spot
%     - r can be single value
%     - r can be array
%
% x = getComposition(r,compLim) can take [xInner xOuter] as input to
% rescale composition accordingly. Default is [0.01 0]

p = inputParser();
addRequired(p,"r",@(x) true)
addOptional(p,"compLim",[.01 0],@(x) true)

parse(p,r,varargin{:})

x_in = p.Results.compLim(1);
x_out = p.Results.compLim(2);

a = 17/2;
b = 8/2;
ex = sqrt(1-b^2/a^2);

% theoretical prediciton
% x = real(x_out-(x_out-x_in)*2/pi*acos(1/ex*sqrt(1-b^2./p.Results.r.^2)));

% fit with monto-Carlo with 0.01, see `g_composition`
% assumes outer concentration is zero!
fit = [-0.00158 0.014046];
x = fit(1)*r+fit(2);

x(x>0.01) = 0.01;
x(x<0) = 0;

x = x * p.Results.compLim(1)/0.01; % rescale
end