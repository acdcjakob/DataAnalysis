function [TrueSamples] = searchSamples_v2(searchAdjunct,varargin)
% searchSamples_v2 has input={searchAdjunct1,searchAdjunct2...}
% searchAdjunct = {property1,value1;property2,value2}
% 
% Output ist String-array mit Namen der Samples
%
% Setze <giveInfo> zu true um Tabelle zu erhalten (optional)
%
% See also: getFileNamesFromFolder
%
%% Parsing the input

defaultInfo = false;

p = inputParser;

addRequired(p,'searchAdjunct',@(x) iscell(x))
% notwendiger input
addOptional(p,'giveInfo',defaultInfo,@(x) islogical(x))
% optionaler input der mit "giveInfo",true gerufen wirdat"

parse(p,searchAdjunct,varargin{:})


% bei nur einem adjunkten input trotzdem 1x1 cell!
if ~iscell(searchAdjunct{1,1})
    disp("Input muss cell array of cell arrays sein.")
    return
end
%% Input formatieren und Daten abrufen

% schauen ob datenbank existiert
%if ~exist('.\ProbenSpreadsheet.xlsx','file'),disp('Datenbank fehlt'),return,end
if ~exist('ProbenSpreadsheet.xlsx','file'),disp('Datenbank fehlt'),return,end
    % direct path

% opts = detectImportOptions('.\ProbenSpreadsheet.xlsx');
opts = detectImportOptions('ProbenSpreadsheet.xlsx');
    % direct path

opts = setvartype(opts, "NameVal", 'char');
    % sorgt dafür dass NameVal als char gelesen wird
% tabelle = readtable('.\ProbenSpreadsheet.xlsx',opts);
opts.VariableNamingRule = "preserve";
tabelle = readtable('ProbenSpreadsheet.xlsx',opts);
    % direct path
    % reads tab-separated table as table
% [transpose(opts.VariableNames),transpose(opts.SelectedVariableNames)]
% check for wrong column headers if gettting warning

%% Daten befragen
TrueSamples = [];

% make to row array
if iscolumn(searchAdjunct)
    searchAdjunct = transpose(searchAdjunct);
end

n_adj = size(searchAdjunct,2);

tabelleNew = table();
for i_adj = 1:n_adj
    % the results of the adjunct searches add up

    n_conj = size(searchAdjunct{i_adj},1);
    tabelleCut = tabelle;
    for i_conj = 1:n_conj
        property = searchAdjunct{i_adj}{i_conj,1};
        value = searchAdjunct{i_adj}{i_conj,2};
        TrueIdx = findProperty(tabelleCut,...
            property,...
            value);
        tabelleCut = tabelleCut(TrueIdx,:);
        disp("searchSamples.m: Samples mit "+property+" "+value+" wurden gesucht")
    end
    
    tabelleNew = [tabelleNew;tabelleCut];
end

% -- remove duplicates
tabelleNew = unique(tabelleNew);

TrueSamples = cellfun(@(x) convertCharsToStrings(x),tabelleNew.Id);


%
% Sollen zu den Samplenamen auch die anderen Properties ausgegeben werden?
% Dann ändere Output von ID zu ganze Zeile für alle idx's
%

if p.Results.giveInfo == true
    TrueSamples = tabelleNew;
end


end

function TrueIdx = findProperty(tabelle,property,value)
    property = char(property);
    value = char(value);
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
       disp("ERROR searchSamples_v2.m: Property "+property+" existiert nicht!")
       return
    end
    %
    % alle Samples mit property = VALUE finden
    %
    TrueIdx = [];
    for idx = 1:length(tabelle{:,1})
        % check all rows for the desired property
        currentProperty = convertCharsToStrings(searchColumn(idx));
        if strcmp(currentProperty,value) == 1
           TrueIdx = [TrueIdx idx];
                % enthält alle idx mit property = VALUE
        end
    end

    %
    % Fehlermeldung falls VALUE nicht gefunden
    %
    
    if isempty(TrueIdx) == 1
        disp("ACHTUNG searchSamples.m: "+property+" mit Wert "+value+" wurde nicht gefunden")
        return
    end
end

% function result = checkCellArray(input)
%     % Check if input is a cell array
%     if iscell(input) 
%         % Check if it has exactly two entries along 2nd dimension
%         if size(input,2) == 2
%             % Check if both entries are of type string or char
%             for i = 1:size(input,1)
%                 if (ischar(input{i,1}) || isstring(input{i,1})) && ...
%                    (ischar(input{i,2}) || isstring(input{i,2}))
%                     result = true;
%                 else
%                     result = false;
%                     disp('searchSamples.m: Both entries in the cell array should be of type string or char.');
%                 end
%             end
%         else
%             result = false;
%             disp('searchSamples.m: Input should be a cell array with exactly 2 entries.');
%         end
%     else
%         result = false;
%         disp('searchSamples.m: Input should be a cell array.');
%     end
% end