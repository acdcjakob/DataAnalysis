function output = getRocking(IdCell)
%getRocking(Id) gives FWHM of omega-scan.
%   Id can be
%       - cell array of Strings/char vectors (-> multiple Ids)
%       - string array (-> multiple Ids)
%       - char vector (-> one Id)

cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
addpath(genpath("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis"))
%%

% --- if input is cell array ---
    if iscell(IdCell)
        for i = 1:numel(IdCell)
            thisId = IdCell{i};
            output(i) = getFWHM(thisId);
    
        end
    end
    
% --- if input is string (array) ---
    if isstring(IdCell)
        for i = 1:numel(IdCell)
            thisId = IdCell(i);
            output(i) = getFWHM(thisId);
        end
    end

% --- if input is char array ---
    if ischar(IdCell)
        output = getFWHM(IdCell);
    end


function FWHM = getFWHM(thisId)
    folderPath = fullfile("data",thisId,"XRD_Omega");
    fileName = getFileNamesFromFolder(folderPath,".TXT");
    if isempty(fileName)
        disp("getRocking.m: No peak data.")
        FWHM = nan;
        return
    end
    filePath = fullfile(folderPath,fileName);
    
    T = createLegitTableFromHighScore(filePath);
    FWHM = T.FWHM;
end

end

