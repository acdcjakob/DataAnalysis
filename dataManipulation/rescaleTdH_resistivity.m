function output = rescaleTdH_resistivity(Id,varargin)
% cellData = rescaleTdH_resistivity(Id) takes the first found
% .mat file containing "param" and gives temperature, rho and err_rho
%   Detailed explanation goes here

pars = inputParser();
addRequired(pars,"Id",@(x) true);
addParameter(pars,"visualize",false,@(x) true);
addParameter(pars,"filter",'',@(x) true);
addParameter(pars,"xscale","linear",@(x) true);
addParameter(pars,"yscale","linear",@(x) true);

parse(pars,Id,varargin{:})

%%
% 
% rootPath = "C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis";
% cd(rootPath);
% addpath(genpath(rootPath));
rootPath = '';
[d_old,filePath_mat] = getStuff(Id,rootPath,pars); % in microns
d_new = searchSamples_v2({{"Id",Id}},true).d; % in nm

dataStruct = load(filePath_mat);

n = numel(dataStruct.paramtable)/2;
% only the B=0 data fields

for idx = 0:(n-1)
    rho = dataStruct.paramtable{1+2*idx, 1}.table(:,13) * d_new*1e-3 / d_old;
    err_rho = dataStruct.paramtable{1+2*idx, 1}.table(:,14) * d_new*1e-3 / d_old;
    temp = dataStruct.paramtable{1+2*idx, 1}.table(:,3);
    output{idx+1,1} = [temp,rho,err_rho];

    if pars.Results.visualize
        if strcmp(pars.Results.xscale,"linear")

        elseif strcmp(pars.Results.xscale,"inverse")
            temp = 1000./temp; % 1000/K
        end

        if strcmp(pars.Results.yscale,"linear")

        elseif strcmp(pars.Results.yscale,"log")
            err_rho = exp(err_rho);
            rho = exp(rho);
        end

        p = errorbar(temp,rho,err_rho);
        p.Marker = "square";
        p.MarkerSize = 10;
        output{idx+1,2} = p;
        hold on
    end
end

function [d,filePath_mat] = getStuff(Id,rootPath,pars)
    % read the used thickness
    folderPath = fullfile(rootPath,"data",Id,"Hall_TdH");
    fileName_td3 = getFileNamesFromFolder(folderPath,".td3");
    fid = fopen(fullfile(folderPath,fileName_td3(1)));
    d = textscan(fid,'%f','HeaderLines',4);
    d = d{1}(1);
        % sometimes too much is read
    
    fileName_mat = getFileNamesFromFolder(folderPath,".mat");
        % find the param file
        find_par = strfind(fileName_mat,"param");
        found_par = cellfun(@(x) ~isempty(x),find_par);

        if ~isempty(char(pars.Results.filter))
            find_filter = strfind(fileName_mat,pars.Results.filter);
            found_filter = cellfun(@(x) ~isempty(x),find_filter);
            trueIdx = found_par & found_filter;
            % ---------
            % hier könnte man filterFileName.m implementieren ...
        else
            trueIdx = found_par;
        end
        if sum(trueIdx) > 1
            t = find(trueIdx);
            filePath_mat = fullfile(folderPath,fileName_mat(t(1)));
            disp("Too many TdH-.mat files. Choose (better) filter.")
            return
        end

    filePath_mat = fullfile(folderPath,fileName_mat(trueIdx));
end

end

