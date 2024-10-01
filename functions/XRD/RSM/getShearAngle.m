function shearAngle = getShearAngle(peakRight,peakLeft,varargin)
% getShearAngle(peakLeft,peakRight) gives the angle of shear for two
% asymmetric peak locations

    x1 = peakRight(1);
    y1 = peakRight(2);
    x2 = peakLeft(1);
    y2 = peakLeft(2);

    shearAngle = atan2(y1-y2,x1-x2);

    if nargin > 2
        shearAngle = shearAngle *180/pi;
    end
end

