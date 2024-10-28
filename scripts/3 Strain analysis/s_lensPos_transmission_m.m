%% get data

% L = -2 samples
% W6900m -> 05m -> 10m (ascending thickness)
samTable{1} = searchSamples_v2({{ ...
    'Batch','Cr2O3_energy';...
    'NameVal','-2';...
    'Transmission','y'}},true);

% L = 0 sample
samTable{2} = searchSamples_v2({{ ...
    'Id','W6902m'}},true);

% L = +1 sample
samTable{3} = searchSamples_v2({{ ...
    'Id','W6911m'}},true);

% E = 300mJ sample
% samTable{4} = searchSamples_v2({{ ...
%     'Id','W6932m'}},true);

data = cell(1,numel(samTable));
F = [
    energyDensity(-2)
    energyDensity(0)
    energyDensity(1)
    energyDensity(-1,false,300)];

allThickness = [];
for i = 1:numel(samTable)
    N = numel(samTable{i}.Id);
    data{i} = cell(N,1);
    for ii = 1:N
        data{i}{ii} = ...
            getTransmission(samTable{i}.Id{ii});
        allThickness = [allThickness;samTable{i}.d(ii)];
    end
end

%% Plot only L = -2
tileH = tiledlayout(1,2);
ax(1) = nexttile();
ax(2) = nexttile();
[tileH,fh] = makeLatexSize(.8,.5/.8,tileH);
    fh.Position = fh.Position+[0 0 2 0]; % make space for colorbar
formatAxes(ax(1));
formatAxes(ax(2));
    hold(ax,"on");

% init
colMap = (turbo);
    ax(1).Colormap = colMap;
    % clim(ax,[min(F) max(F)])
    clim(ax(1),[min(allThickness) max(allThickness)])
    % colIdx = floor(rescale(F)*255)+1;
    cb = colorbar(ax(1));
    cb.Layout.Tile = "east";
    cb.Label.String = "{\itd} (nm)";
    cb.Label.FontSize = 12;

lineMap = ["-" "--" ":"];
for i = 1:numel(samTable)    
    N = numel(samTable{i}.Id);
    for ii = 1:N
        alpha = -1 * log(data{i}{ii}(:,2)) ...
            ./ (samTable{i}.d(ii)*1e-7); % cm^-1

        tauc = (alpha.*data{i}{ii}(:,1)).^2;
        
        colIdx = floor( ...
            rescale( ...
                samTable{i}.d(ii),...
                'InputMin',min(allThickness),...
                'InputMax',max(allThickness) ...
            )...
            *255 ...
        )+1;
        

        % Tauc Fit
        x = data{i}{ii}(:,1);
            x0 = 3.9;
            x1 = 4.3;
            xIdx = x>x0 & x<x1;
        p = polyfit(x(xIdx),tauc(xIdx),1);
            Eg = -p(2)/p(1)
            xFit = linspace(Eg,x1+.1,10);
            yFit = polyval(p,xFit);
        

        % Plot
        lblTrans = num2str(F(i),'%.2f');
        lblTauc = num2str(Eg,'%.2f');
        plot(ax(1),data{i}{ii}(:,1),data{i}{ii}(:,2)*100,... % percent
            "DisplayName",lblTrans,...
            "Color",colMap(colIdx,:),...
            "linewidth",1,...
            "LineStyle",lineMap(i))
        plot(ax(2),data{i}{ii}(:,1),tauc,"DisplayName",lblTauc,...
            "Color",colMap(colIdx,:),...
            "linewidth",1,...
            "LineStyle",lineMap(i))
        plot(xFit,yFit,"r--","HandleVisibility","off");
    end
end
xlim(ax(1),[1.5 6])

xlim(ax(2),[1 5.5])
ylim(ax(2),[0 .6e13])

legH(1) = legend(ax(1),"location","northeast");
    legH(1).Title.String = "{\itF} (J cm^{-2})";
    formatAxes(ax(1));
legH(2) = legend(ax(2),"location","northwest");
    legH(2).Title.String = "{\itE_\tau} (eV)";
    formatAxes(ax(2));

xlabel(tileH,"{\itE} (eV)")

ylabel(ax(1),"{\itT} (%)")
ylabel(ax(2),"(\alphaE)^2 (cm^{-1}\times eV)^2")

title(ax(1),"Transmission")
title(ax(2),"Tauc Plot")

grid(ax,"on")
set(ax(1),"Xminorgrid","on")

set(fh,"Renderer","painters");
exportgraphics(fh,"../Plots/Thesis/3/3_lensPos_Transmission.eps");
