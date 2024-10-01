function output = getHallData(fileIds)
% if input is str-array then iterate through all entries
% if input is cell array of str arrays, only take first cell and iteratur
% through all entries

if iscell(fileIds)
    N = numel(fileIds{1});
else
    N = numel(fileIds);
end

output = cell(N,1);
for i_file = 1:N
    if iscell(fileIds)
        load(fileIds{1}(i_file),"results")
    else
        load(fileIds(i_file),"results")
    end
    fileContent = results{1,1}.data;

    N = size(fileContent,1);
    TeilMessungen = struct([]);
    for j = 1:N
        TeilMessungen(j).rho = fileContent(j,1).rho;
        TeilMessungen(j).err_rho = fileContent(j,1).err_rho;
        TeilMessungen(j).Iset = fileContent(j,1).Iset;

        TeilMessungen(j).RH = fileContent(j,2).RH;
        TeilMessungen(j).err_RH = fileContent(j,2).err_RH;
        TeilMessungen(j).n = fileContent(j,2).n;
        TeilMessungen(j).err_n = fileContent(j,2).err_n;
        TeilMessungen(j).mu = fileContent(j,2).mu;
        TeilMessungen(j).err_mu = fileContent(j,2).err_mu;
        
        TeilMessungen(j).Imax = fileContent(j,1).I_max;
        TeilMessungen(j).Iset = fileContent(j,1).Iset;
    end
    output{i_file} = TeilMessungen;
end

end

