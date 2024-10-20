function y = doLog(y,varargin)
%DOLOG Summary of this function goes here
%   Detailed explanation goes here
if nargin>1
    thresh = varargin{:};
else
    thresh = 3;
end

y(y<thresh)=thresh;
y = log(y);
end

