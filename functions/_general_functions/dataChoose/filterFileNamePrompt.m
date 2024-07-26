function output = filterFileNamePrompt(filterString)
% filterFileNamePrompt(string) takes 1 string and converts it into cell array that
% can be read by filterFileName

filterString = char(filterString);
if isempty(filterString), output = {}; return, end

% determine the number of adjunctions
doublePercentageLoc = strfind(filterString,'%%');
n_Adj = numel(doublePercentageLoc);
    toParse_Adj = cell(1,n_Adj);
    output = cell(1,n_Adj);
    Cut_Adj = filterString;
for i_Adj = n_Adj+1-(1:n_Adj)
    % n, n-1, n-2 ...
    toParse_Adj{i_Adj} = Cut_Adj((doublePercentageLoc(i_Adj)+2):end);

        Cut_Adj = Cut_Adj(1:(doublePercentageLoc(i_Adj)-1));

    dollarLoc_prop = strfind(toParse_Adj{i_Adj},'$');
    n_Conj = numel(dollarLoc_prop);
        output{i_Adj} = cell(n_Conj,1);
        Cut_Conj = toParse_Adj{i_Adj};
    for i_Conj = n_Conj+1-(1:n_Conj)
        output{i_Adj}{i_Conj,1} = ...
            Cut_Conj((dollarLoc_prop(i_Conj)+1):end);
        Cut_Conj = Cut_Conj(1:(dollarLoc_prop(i_Conj)-1));
    end
end
end

