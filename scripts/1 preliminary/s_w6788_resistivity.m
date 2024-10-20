% Get Data
samTable = searchSamples_v2({{'IdParent','W6788'}},true);

% Filters to get the correct data set (different measurements were done to
% test hysteresis)
%
% the order is a -- c -- m -- r
filter = {'origin'
    'origin'
    ''
    'hystUp2'};
planes = ["a" "c" "m" "r"];
data = cell(2,4);
for i = 1:4
    data(:,i) = rescaleTdH_resistivity(samTable.Id{i},"filter",filter{i});
    
end

%% Plotting section
% init
[ax,fh] = makeLatexSize(1,.5);
    hold(ax,"on")
    ylabel("\rho (\Omega cm)");
    xlabel("{\itT} ^{-1} (1000/K)")
eh = gobjects(2,4);
phFit = gobjects(1,4);
fitLims = {{[2.5 3]}
    {[3 10] [15 25]}
    {[2.5 3]}
    {[3 5.5]}}; % inverse units

A = [1,.5];
M = ["^","s"];
L = ["-","--"];
k = 8.62e-5; % eV / K
cm = jet(4);
for i = 1:4
    for ii = 1 % omit the second current
        T = 1./data{ii,i}(:,1);
        r = data{ii,i}(:,2);
        rEr = data{ii,i}(:,3);
        eh(ii,i) = errorbar(T*1000,r*100,rEr*100,"s");
            set(eh(ii,i),...
                "MarkerFaceColor",cm(i,:),...
                "MarkerEdgeColor",cm(i,:)*.7,...
                "Color",cm(i,:)*.7,...
                "Marker",M(ii),...
                "DisplayName","{\it"+planes(i)+"}-plane");
        set(ax,"YScale","log")

        for j = 1:numel(fitLims{i})
            % fitting
            % assume rho = const. * exp[E/(kT)]
            % fit log(rho) = const. + E/(kT)
            % --> E/k = slope --> E = k*slope
            fitIdx = T>fitLims{i}{j}(1)/1000 & T<fitLims{i}{j}(2)/1000;
            xFit = T(fitIdx); % in 1/K
            yFit = log(r(fitIdx)); % in log(Ohm m)
            p = polyfit(xFit,yFit,1);
                E_act(i,j) = p(1)*k*1000; % activation energy in meV
            xPlot = fitLims{i}{j}(1)/1000-0.001:0.0001:fitLims{i}{j}(2)/1000+0.001;
            yPlot = exp(polyval(p,xPlot)); % in Ohm m
            phFit(i,j) = plot(xPlot*1000,yPlot*100); % plot Ohm cm VS. 1000/K
            set(phFit(i,j),"Linewidth",1,...
                "LineStyle",L(j),...
                "Color",cm(i,:)*.7,...
                "DisplayName",num2str(E_act(i,j),"%.1f")+" meV");
        end
        
    end
end
lh = legend("Location","best","NumColumns",2);
    lh.Position = [.41 .24 .48 .25];

xline(1000/300,"DisplayName","Room Temp.","Color",[.2 .8 .2],"linewidth",1)
grid on;
formatAxes(ax);
ax.GridLineWidth = .5;

exportgraphics(fh,"../Plots/Thesis/1/1_W6788_resistivityTempDep.eps")
