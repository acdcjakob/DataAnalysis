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

%% get diffraction Data
% init
N = [0,0];
filePaths = cell(1,2);
data = cell(1,2);
for i = 1:2
    N(i) = numel(samTable{i}.Id);
    % init
    filePaths{i} = cell(N(i),1);
    data{i} = cell(N(i),2); % substrate , film
    for ii = 1:N(i)
        filePaths{i}(ii) = getFilePathsFromId(samTable{i}.Id{ii},...
            "XRD_Phi",".xy");
        data{i}{ii,1} = getDiffraction(filePaths{i}{ii}(1));
        data{i}{ii,2} = getDiffraction(filePaths{i}{ii}(2));
    end
end

%% plotting section
% init
[ax,fh] = makeLatexSize(1.1,.4);
    hold(ax,"on")
    fh.Renderer = "painters";

ph = {gobjects(N(1),2) gobjects(N(2),2)};
cmap = {cool(N(1)+3)*.8 autumn(N(2))*.8};
logAdd = 0;
correction = {[180,0,0,180],[180 0 90]}; % shift everything to same peaks
for i = 1:2
    for ii = 1:N(i)
        % bring to -180 to 180 degrees and sort to avoid intersecting line
        % due to plotting non-ascending data
        xSub = bringTo360( data{i}{ii,1}(:,1)+correction{i}(ii) );
        ySub = doLog( data{i}{ii,1}(:,2) ) + logAdd;
        [xSub,idxSub] = sort(xSub);
            ySub = ySub(idxSub);

        xFilm = bringTo360( data{i}{ii,2}(:,1)+correction{i}(ii) );
        yFilm = doLog( data{i}{ii,2}(:,2) ) + logAdd;
        [xFilm,idxFilm] = sort(xFilm);
            yFilm = yFilm(idxFilm);
            
        
        ph{i}(ii,1) = plot(ax,xSub,ySub);
        ph{i}(ii,2) = plot(ax,xFilm,yFilm,"HandleVisibility","off");
    

        logAdd = logAdd + 5;
    end
    % styling
    for j = 1:numel(ph{i})
        ph{i}(j).LineWidth = 1.5;
    end

    for j = 1:numel(ph{i}(:,1))
        ph{i}(j,1).Color = cmap{i}(j,:);
        ph{i}(j,1).DisplayName = ...
            samTable{i}.NameVal{j}+" "+samTable{i}.NameUnit{j};
    end
    for j = 1:numel(ph{i}(:,2))
        ph{i}(j,2).Color = cmap{i}(j,:).*[.6 .7 .5].*.8; % adjust factor for brightness
    end
    logAdd = logAdd + 4;
end
lh = legend([flip(ph{2}(:,1));flip(ph{1}(:,1))],"location","eastoutside");
    lh.Title.String = sprintf("(30.6)-plane\nprobed");
ylabel("counts (a.u.)")
xlabel("\phi (°)")
formatAxes(ax); % change legend font size
    set(ax,...
        "YTick",[],...
        "XGrid","on")
% cropping
axis tight
xlim([-181 181])
ax.XTick = -180:60:180;

%% export
exportgraphics(fh,"../Plots/Thesis/1/1_both_phi.eps")
