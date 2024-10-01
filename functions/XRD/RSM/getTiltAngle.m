function tiltAngle = getTiltAngle(symmetricPeakVector,varargin)
% getTiltAngle(symmetricPeakVector) gives the angle of rotation for a 
% 2D vector
%
% getTiltAngle(symmetricPeakVector,true) outputs the angle in degrees

    x = symmetricPeakVector(1);
    y = symmetricPeakVector(2);

    tiltAngle = acos(y/sqrt(x^2+y^2)) * -1 * sign(x);

    if nargin > 1
        tiltAngle = tiltAngle *180/pi;
    end
end

