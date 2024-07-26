function output = searchSamplesPrompt(property,value)
% SEARCHSAMPLESPROMPT(property,value) takes 2 strings and converts them into cell array that
% can be read by searchSamples

property = char(property);
value = char(value);

% determine the number of adjunctions
doublePercentageLoc_prop = strfind(property,'%%');
doublePercentageLoc_val = strfind(value,'%%');
% [ERROR]
if numel(doublePercentageLoc_val)~=numel(doublePercentageLoc_prop)
    disp("searchSamplesPrompt.m: missing '%%': dimensions of adjunct properties and values do not match")
    output = {{'',''}};return
end
n_Adj = numel(doublePercentageLoc_prop);
    propToParse_Adj = cell(1,n_Adj);
    valToParse_Adj = cell(1,n_Adj);
    output = cell(1,n_Adj);
    propertyCut_Adj = property;
    valueCut_Adj = value;
for i_Adj = n_Adj+1-(1:n_Adj)
    % n, n-1, n-2 ...
    propToParse_Adj{i_Adj} = propertyCut_Adj((doublePercentageLoc_prop(i_Adj)+2):end);
    valToParse_Adj{i_Adj} = valueCut_Adj((doublePercentageLoc_val(i_Adj)+2):end);

        propertyCut_Adj = propertyCut_Adj(1:(doublePercentageLoc_prop(i_Adj)-1));
        valueCut_Adj = valueCut_Adj(1:(doublePercentageLoc_val(i_Adj)-1));

    dollarLoc_prop = strfind(propToParse_Adj{i_Adj},'$');
    dollarLoc_val = strfind(valToParse_Adj{i_Adj},'$');
    if numel(dollarLoc_val)~=numel(dollarLoc_prop)
        disp("searchSamplesPrompt.m: missing '$': dimensions of property and value do not match for adjunct#"+num2str(i_Adj))
        output = {{'',''}}; return
    end
    n_Conj = numel(dollarLoc_prop);
        output{i_Adj} = cell(n_Conj,2);
        propertyCut_Conj = propToParse_Adj{i_Adj};
        valueCut_Conj = valToParse_Adj{i_Adj};
    for i_Conj = n_Conj+1-(1:n_Conj)
        output{i_Adj}{i_Conj,1} = ...
            propertyCut_Conj((dollarLoc_prop(i_Conj)+1):end);
        output{i_Adj}{i_Conj,2} = ...
            valueCut_Conj((dollarLoc_val(i_Conj)+1):end);

        propertyCut_Conj = propertyCut_Conj(1:(dollarLoc_prop(i_Conj)-1));
        valueCut_Conj = valueCut_Conj(1:(dollarLoc_val(i_Conj)-1));

    end
end
end

