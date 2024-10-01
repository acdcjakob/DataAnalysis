function output = filterFileName(searchAdjunct,nameArray,varargin)
% filenameOutput = filterFileName(nameFilter,filenameInput)
%   -> nameFilter = {searchAdjunct1,searchAdjunct2...}
%   -> searchAdjunct = {searchConj1;
%       searchConj2;
%       ...}
% filterFileName(___,true) activates filterFileNamePrompt.m, so that a
% string "%%$s1$s2%%$s1s2" can be entered (otherwise cell array)

p = inputParser();
addRequired(p,"searchAdjunct",@(x) iscell(x) | ischar(x) | isstring(x))
addRequired(p,"nameArray",@(x) iscell(x) | ischar(x) | isstring(x))
addOptional(p,"parseFirst",false,@(x) islogical(x))

parse(p,searchAdjunct,nameArray,varargin{:});

if p.Results.parseFirst
    searchAdjunct = filterFileNamePrompt(searchAdjunct);
end

if isempty(searchAdjunct)
    output = nameArray;
    return
end

% make to row search array
if iscolumn(searchAdjunct)
    searchAdjunct = transpose(searchAdjunct);
end

% make row names to column
if isrow(nameArray)
    nameArray = transpose(nameArray);
end

n_adj = size(searchAdjunct,2);

nameArrayNew = [];
for i_adj = 1:n_adj
    % the results of the adjunct searches add up

    n_conj = size(searchAdjunct{i_adj},1);
    nameArrayCut = nameArray;
    for i_conj = 1:n_conj
        thisFilter = searchAdjunct{i_adj}{i_conj,1};
        TrueIdx = contains(lower(nameArrayCut),lower(thisFilter));
        nameArrayCut = nameArrayCut(TrueIdx);
    end
    
    nameArrayNew = [nameArrayNew;nameArrayCut];
end

% -- remove duplicates
nameArrayNew = unique(nameArrayNew);
output = nameArrayNew;

end