% search Samples
samTable{1} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','mbar'}},true);

samTable{2} = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','°C'}},true);

% sorting the tables
for i = 1:2
    sortData = columnToNumber(samTable{i}.NameVal);
    [~,sortIdx] = sort(sortData);
    samTable{i} = samTable{i}(sortIdx,:);
    clear sortIdx sortData
end

%% get transmission Data
% init
N = [0,0];
data = cell(1,2);
for i = 1:2
    N(i) = numel(samTable{i}.Id);
    % init
    data{i} = cell(N(i),1);
    for ii = 1:N(i)
        [data{i}{ii}(:,1),data{i}{ii}(:,2)] = getTransmission(samTable{i}.Id{ii});
    end
end

%% plotting section
% init
[ax,fh] = makeLatexSize(1,.6);
    hold(ax,"on")
    fh.Renderer = "painters";

ph = {gobjects(N(1),1) gobjects(N(2),1)};
cmap = {cool(N(1))*.8 autumn(N(2))*.8};
offset = 0;
for i = 1
    for ii = 1:N(i)
        x = data{i}{ii}(:,1);
        y = data{i}{ii}(:,2);
        y(y<=0)=nan; % delete negative transmission data
        alpha = -1*log(y)./(samTable{i}.d(ii)*1e-7); % cm^-1
        tauc = (alpha.*x).^2;

        ph{i}(ii) = plot(x,tauc);
        
        ph{i}(ii).LineWidth = 1.5;
        ph{i}(ii).Color = cmap{i}(ii,:);
        ph{i}(ii).DisplayName = ...
            samTable{i}.NameVal{ii}+" "+samTable{i}.NameUnit{ii};
    end
    offset = offset + 4;
end