function output = getIntensity(IdCell)
%getIntensity(Id) gives intensity of 2Omega-scan.
%   Id can be
%       - cell array of Strings/char vectors (-> multiple Ids)
%       - string array (-> multiple Ids)
%       - char vector (-> one Id)

if isempty(IdCell)
    output = nan;
    return
end

% --- if input is cell array ---
    if iscell(IdCell)
        for i = 1:numel(IdCell)
            thisId = IdCell{i};
            output(i) = getInt(thisId);
    
        end
    end
    
% --- if input is string (array) ---
    if isstring(IdCell)
        for i = 1:numel(IdCell)
            thisId = IdCell(i);
            output(i) = getInt(thisId);
        end
    end

% --- if input is char array ---
    if ischar(IdCell)
        output = getInt(IdCell);
    end


    function I = getInt(thisId)
    folderPath = fullfile("data",thisId,"XRD_Omega");
    fileName = getFileNamesFromFolder(folderPath,".TXT");
    if isempty(fileName)
        disp("getRocking.m: No peak data.")
        I = nan;
        return
    end
    filePath = fullfile(folderPath,fileName);
    
    T = createLegitTableFromHighScore(filePath);
    I = T.I;
end

end

