function [TrueSamples] = searchSamples(property,VALUE,varargin)
%searchSamples(property,VALUE,<giveInfo>,'searchDeeper',<property2+VALUE2>) gives all samples that exhibit
%property = VALUE.
%   Output ist String-array mit Namen
%
%   Setze <giveInfo> zu true um Tabelle zu erhalten (optional)
%   Setze cell array <property2+VALUE2> um innerhalb einer property
%   genauer zu suchen, also z.B . property = 'Batch' und
%   <property2> = {'Substrat','m-Al2O3'}
%
%   See also: getFileNamesFromFolder
%
%% Parsing the inpu

defaultInfo = false;

defaultSearchDeeper = {char(property),char(VALUE)};
p = inputParser;

validText = @(x) ischar(x) | isstring(x);
addRequired(p,'property',validText)
addRequired(p,'VALUE',validText)
addOptional(p,'giveInfo',defaultInfo,@(x) islogical(x))
addParameter(p,'searchDeeper',defaultSearchDeeper,@(x) checkCellArray(x))

parse(p,property,VALUE,varargin{:})

%% Input formatieren und Daten abrufen
property = convertStringsToChars(property);
    % macht input zu char falls String

addpath("DataAnalysis")

opts = detectImportOptions('ProbenSpreadsheet.xlsx');
% ERROR-potential: es muss der passende Ordner ausgewählt sein, damit ".\"
% funktioniert.
opts = setvartype(opts, "NameVal", 'char');
    % sorgt dafür dass NameVal als char gelesen wird
tabelle = readtable('ProbenSpreadsheet.xlsx',opts);
    % reads tab-separated table as table

%% Daten befragen
TrueSamples = [];
n = size(p.Results.searchDeeper,1);

for j = 1:n+1
    % suche n+1 mal wobei vor der nächsten Iteration die Werte zu
    % 'searchDeeper' geaendert werden
    
    TrueIdx = findProperty(tabelle,property,VALUE);

    tabelle = tabelle(TrueIdx,:);
    disp("searchSamples.m: Samples mit "+property+" "+VALUE+" wurden gesucht")
    if j > n, break, end
    property = p.Results.searchDeeper{j,1};
    VALUE = p.Results.searchDeeper{j,2};
end


TrueSamples = cellfun(@(x) convertCharsToStrings(x),tabelle.Id);


%
% Sollen zu den Samplenamen auch die anderen Properties ausgegeben werden?
% Dann ändere Output von ID zu ganze Zeile für alle idx's
%

if p.Results.giveInfo == true
    TrueSamples = tabelle;
end


end

function TrueIdx = findProperty(tabelle,property,VALUE)
    %
    % check ob property überhaupt existiert
    %
    BOOL = false;
    % initial
    tabelleZeilenkoepfe = tabelle.Properties.VariableNames;
        % Tabellenkopf abrufen
    for idx = 1:length(tabelleZeilenkoepfe)
        thisProperty = tabelleZeilenkoepfe{idx};
            % Spalten durchgehen
        BOOL = strcmp(property,thisProperty);
            % check
        if BOOL == true
            searchColumn = tabelle{:,idx};
            break
        end
    end
    if BOOL == false
       disp("ERROR searchSamples.m: Property "+property+" existiert nicht!")
       return
    end
    %
    % alle Samples mit property = VALUE finden
    %
    TrueIdx = [];
    for idx = 1:length(tabelle{:,1})
        % check all rows for the desired property
        currentProperty = convertCharsToStrings(searchColumn(idx));
        if strcmp(currentProperty,VALUE) == 1
           TrueIdx = [TrueIdx idx];
                % enthält alle idx mit property = VALUE
        end
    end

    %
    % Fehlermeldung falls VALUE nicht gefunden
    %
    
    if isempty(TrueIdx) == 1
        disp("ACHTUNG searchSamples.m: "+property+" mit Wert "+VALUE+" wurde nicht gefunden")
        return
    end
end

function result = checkCellArray(input)
    % Check if input is a cell array
    if iscell(input) 
        % Check if it has exactly two entries along 2nd dimension
        if size(input,2) == 2
            % Check if both entries are of type string or char
            for i = 1:size(input,1)
                if (ischar(input{i,1}) || isstring(input{i,1})) && ...
                   (ischar(input{i,2}) || isstring(input{i,2}))
                    result = true;
                else
                    result = false;
                    disp('searchSamples.m: Both entries in the cell array should be of type string or char.');
                end
            end
        else
            result = false;
            disp('searchSamples.m: Input should be a cell array with exactly 2 entries.');
        end
    else
        result = false;
        disp('searchSamples.m: Input should be a cell array.');
    end
end