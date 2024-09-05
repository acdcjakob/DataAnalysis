function vectorOut = transformShear(vectorIn,angle,center)
% V ... peak vector
% R ... rotation matrix
% +T ... translation operation to symmetric peak
% 1) bring rotation center to origin
%       V' = V-T
% 2) rotate everything
%       V' = RV
% 3) translate back
%       V' = V+T
% So in total:
%       V'  = (R(V-T))+T
%       V'  = RV + (1-R)T
%
% check: pluggin in T should change nothing
%       T'  = RT + (1-R)T = 1T = T

R = getTiltMatrix(angle);
T = center;

vectorOut = R*vectorIn + (eye(size(R))-R)*T;

end

