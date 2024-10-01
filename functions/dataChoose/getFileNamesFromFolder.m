function [FileNames] = getFileNamesFromFolder(folder,extension)
% getFileNamesFromFolder(folder,extension)
%   <folder> ist Name des Ordners
%   <extension> ist die Dateiendung, z.B. '.txt'
if nargin < 2
    disp("ERROR getFileNamesFromFolder.m: Zu wenig input arguments.")
    return
end
extension = strcat('*',extension);
    % strcat sorgt dafür dass es egal ist ob es characters oder strings
    % sind
Path = fullfile(convertStringsToChars(folder),extension);
    
folderContent = dir(Path);
    % array mit Pfaden für jeweilige .extension-Datei
N = length(folderContent);

FileNames = strings(N,1);
for idx = 1:N
   currentFile = folderContent(idx);
   FileNames(idx) = currentFile.name;
end

if N == 0
    disp("WARNING getFileNamesFromFolder.m: Keine Messdaten in "+Path)
end

