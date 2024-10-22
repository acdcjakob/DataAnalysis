function output = getFilePathsFromId(IdString,MessungString,Extension,varargin)
% output is cell array with found fileNames
% input can be cell array of strings or string array
p = inputParser();
% making string to char
if ischar(IdString)
    IdString = string(IdString);
elseif iscell(IdString)
    IdString = cellfun(@(x) string(x),IdString);
end


addRequired(p,"IdString",@(x) true)
addRequired(p,"MessungString",@(x) true)
addRequired(p,"Extension",@(x) true)
addOptional(p,"Filter",{},@(x) iscell(x) | ischar(x) | isstring(x))

parse(p,IdString,MessungString,Extension,varargin{:})

% if filtering for only one word
if ischar(p.Results.Filter) | isstring(p.Results.Filter)
    fil = {{p.Results.Filter}};
else
    fil = p.Results.Filter;
end


folderPath = fullfile("data",p.Results.IdString,p.Results.MessungString);

output = cell(numel(p.Results.IdString),1);
    % nx1 cell array each containing fileNames
for i = 1:numel(p.Results.IdString)
    files = getFileNamesFromFolder(folderPath(i),p.Results.Extension);
    filesFiltered = filterFileName(fil,files);
    output{i} = fullfile(folderPath(i),filesFiltered);
end
end

