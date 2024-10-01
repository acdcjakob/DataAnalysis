function xy = getDiffraction(filePfad)
% data = getDiffraction(filePfad)
%       data is a [x,y] file
fid = fopen(filePfad);
NumCol = 2;
dataRaw = textscan(fid,repmat('%f',[1,NumCol]),...
    'delimiter','\t');
xy = [dataRaw{:,1},dataRaw{:,2}];
end