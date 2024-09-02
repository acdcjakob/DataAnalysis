function output = createLegitTableFromHighScore(filePath,varargin)
% createLegitTableFromHighScore(path) yields table with fielpath as input
% createLegitTableFromHighScore(path,true) yields an empty table

    p = inputParser;

    addRequired(p,"filePath",@(x) isstring(x)|ischar(x));
    addOptional(p,"emptyTable",false,@(x) islogical(x))

    parse(p,filePath,varargin{:})
    
    % ------
    newFields = {'No.','No';...
        'Pos. [°2Th.]','Pos';...
        'Pos. [°Omega]','Pos';...
        'FWHM Left [°2Th.]','FWHM';...
        'FWHM Left [°Omega]','FWHM';...
        'd-spacing [Å]','d_lattice';...
        'Height [cts]','I';...
        'Label','Label';...
        'Backgr.[cts]','background';...
        'Shape Left','Lorentz'...
        };

    if p.Results.emptyTable
        output = NaN(1,9);
        output = array2table(output,"VariableNames",...
            {'No','Phase','h','k','l','Pos','FWHM','d_lattice','I'});
        return
    end
    % read Table
    T = readtable(filePath,'Delimiter','\t','VariableNamingRule','preserve');

    % get fieldnames
    F = fieldnames(T);
        % cell array

    % search for important fields
    

    output = table();
    for i_F = 1:numel(F)
        for i_new = 1:size(newFields,1)
            if strcmp(F{i_F},newFields{i_new,1})
                thisField = newFields{i_new,2};
                if strcmp(F{i_F},'Label')
                    labelCell = splitLabel(T{:,i_F});
                    output.Phase = labelCell{:,1};
                    output.h = labelCell{:,2};
                    output.k = labelCell{:,3};
                    output.l = labelCell{:,4};
                    continue
                end
                output.(thisField) = replaceCommaAndBracket(T{:,i_F});
            end
        end
    end

end

function output = splitLabel(labelColumn)
% labelColumn is nx1 cell array with 'Al2O3 0 0 6'-like entries
output = cell(1,4);

    for i = 1:numel(labelColumn)
        thisSplit = strsplit(labelColumn{i});
        output{1,1}(i,1) = string(thisSplit{1}); % phase
        output{1,2}(i,1) = str2double(thisSplit{2}); % h
        output{1,3}(i,1) = str2double(thisSplit{3}); % k
        output{1,4}(i,1) = str2double(thisSplit{4}); % l
    end
end