function [] = Transmission(FilePfad)
%   XRD_2ThetaOmega(FilePfad) plottet Intensity vs. 2Theta.

fid = fopen(FilePfad);
NumCol = 2;
DataRaw = textscan(fid,repmat('%f',[1,NumCol]),...
    'delimiter',' ',...
    'CommentStyle','##');

% create array
n = length(DataRaw{1,1});
Data = zeros(n,NumCol);
for i = 1:NumCol
    Data(:,i) = DataRaw{1,i}; 
end
get
% create table for readable variables
DataTable = array2table(Data,'VariableNames',...
    {'Angle','Intensity'});


% one axis
semilogy(DataTable.Angle,DataTable.Intensity)

end

