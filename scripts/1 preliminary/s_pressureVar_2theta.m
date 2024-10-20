% search the samples
samTable = searchSamples_v2({{ ...
    'Batch','Cr2O3_initial';'NameUnit','mbar'}},true);

% sort
pressure = columnToNumber(samTable.NameVal);
[~,sortIdx] = sort(pressure);
samTable = samTable(sortIdx,:);



N = numel(samTable.Id);
% init
    filePaths = cell(N,1);
    data = cell(N,1);
    nameFilter = "10-1"; % includes the 10-100deg and 10-130deg files
for i = 1:N
    filePaths(i) = getFilePathsFromId(samTable.Id{i},...
        "XRD_2ThetaOmega",".xy",nameFilter);
    data{i} = getDiffraction(filePaths{i});
end

%% plotting section
% init
gh = gobjects(N,1);
cs = cool(N)*.8;

[ax,fh] = makeLatexSize(1,.5);
    hold(ax,"on")
    xlabel("2\theta (°)")
    ylabel("counts (a.u.)")
    set(ax,"XGrid","on",...
        "YTick",[])
    

for i = 1:N
    x = data{i}(:,1);
    y = doLog(data{i}(:,2));
    y = y + 3*(i-1);

    gh(i) = plot(x,y);
        set(gh(i), ...
            "LineWidth",1, ...
            "DisplayName",samTable.NameVal{i}+" mbar",...
            "Color",cs(i,:));
end
lh = legend(ax,"Location","east");
    lh.Title.String = "O_2 pressure";
    lh.Position = [0.273765900639680   0.499345871822019   0.174033151454469   0.269880180109560];
formatAxes(ax);
xlim([53 70])

% additional lines
% ax2 = axes("unit","centimeter","Position",get(ax,"Position"),...
%     "color","none",...
%     "XColor","none",...
%     "YColor","none");
%     xlim(ax2,[53 70])

radiation(1)=xline(get2Theta([3 0 0],"Al2O3","CuKa1",68.1542),"-","linewidth",.75,DisplayName="Cu K\alpha_1");
radiation(2)=xline(get2Theta([3 0 0],"Al2O3","CuKa2",68.1542),"-","linewidth",.75,DisplayName="Cu K\alpha_2");
radiation(3)=xline(get2Theta([3 0 0],"Al2O3","CuKb",68.1542),"-","linewidth",.75,DisplayName="Cu K\beta");
radiation(4)=xline(get2Theta([3 0 0],"Al2O3","WLa1",68.1542),"--","linewidth",.75,DisplayName="W L\alpha_1");
radiation(5)=xline(get2Theta([3 0 0],"Al2O3","WLa2",68.1542),"--","linewidth",.75,DisplayName="W L\alpha_2");
radiation(6)=xline(get2Theta([3 0 0],"Al2O3","WLb1",68.1542),"--","linewidth",.75,DisplayName="W L\beta_1"); % higher angle
radiation(7)=xline(get2Theta([3 0 0],"Al2O3","WLb2",68.1542),"--","linewidth",.75,DisplayName="W L\beta_2");

for i = 1:7
    radiation(i).HandleVisibility = "off";
end
% legend(ax2);

set(fh,"Renderer","painters")
exportgraphics(fh,"../Plots/Thesis/1/Pressure/1_pressure_2theta.eps")
