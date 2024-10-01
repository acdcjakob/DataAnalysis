function output = getFilePathsFromId(IdString,MessungString,Extension,varargin)
% output is cell array with found fileNames
p = inputParser();
if ischar(IdString)
    IdString = string(IdString);
end

addRequired(p,"IdString",@(x) true)
addRequired(p,"MessungString",@(x) true)
addRequired(p,"Extension",@(x) true)
addOptional(p,"Filter",{},@(x) iscell(x))

parse(p,IdString,MessungString,Extension,varargin{:})


folderPath = fullfile("data",p.Results.IdString,p.Results.MessungString);

output = cell(numel(p.Results.IdString),1);
    % nx1 cell array each containing fileNames
for i = 1:numel(p.Results.IdString)
    files = getFileNamesFromFolder(folderPath(i),p.Results.Extension);
    filesFiltered = filterFileName(p.Results.Filter,files);
    output{i} = fullfile(folderPath(i),filesFiltered);
end
end

