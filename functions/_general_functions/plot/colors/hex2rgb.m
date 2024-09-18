function outputRGB = hex2rgb(inputHex)
    outputRGB = zeros([numel(inputHex) 3]);

    for i = 1:numel(inputHex)
        % Remove '#' if it exists
        x = char(inputHex(i));
        if x(1) == '#'
            xClean = x(2:end);
        else
            xClean = x;
        end
        
        % Convert hexadecimal to decimal
        xSplit = reshape(xClean, 2, []).';
        xRGB = hex2dec(xSplit);
        
        % Normalize and return RGB values
        outputRGB(i,:) = xRGB./255;
    end
end