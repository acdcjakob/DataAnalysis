function M = getTiltMatrix(tiltAngle)
    M = [cos(tiltAngle),-sin(tiltAngle); ...
        sin(tiltAngle),cos(tiltAngle)];
end

