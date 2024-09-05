function vectorOut = transformShear(vectorIn,angle,center)

R = getTiltMatrix(angle);
T = center;

vectorOut = R*vectorIn + (eye(size(R))-R)*T;

end

