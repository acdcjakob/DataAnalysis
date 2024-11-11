% check W6715 and W6716 which have quite different shift

samTable = searchSamples_v2({{'Id','W6715'},{'Id','W6716'}},true);

%% get data
% init
filter = ["0","90","180","270"];
data = cell(4,2);

fileNames = getFilePathsFromId([samTable.Id],"XRD_2ThetaOmega",".xy");
for i = 1:2
    for ii = 1:4
        phiFile = filterFileName({{"phi"+filter(ii)}},fileNames{i});
        data{ii,i} = getDiffraction(phiFile);
        
    end
end

%% plotting section
[ax,fh] = makeLatexSize(1,.5);
    hold(ax,"on");
ph = gobjects(4,2);
cs = {cool(4)*.8 autumn(4)*.8};
for i = 1:2
    g = num2str(growthrateFun(samTable(i,:))*1000,"%.1f")+" pm/pulse:";
    dummy(i) = plot(nan,"w","DisplayName",g);
    for ii = 1:4
        x = data{ii,i}(:,1);
        y = data{ii,i}(:,2);
        ph(ii,i) = plot(x,y);

        
        
        set(ph(ii,i),...
            "Linewidth",1,...
            "Color",cs{i}(ii,:),...
            "Displayname","   \phi = "+filter(ii)+"°");
    end
end

xlabel(ax,"2\theta (°)")
ylabel(ax,"counts (a.u.)")
set(ax,"Yscale","log")

set(ax,...
    "XGrid","on",...
    "YTickLabel",{},...
    "YTick",10.^(0:1:5));
axis(1.0e+03 * ...
   [0.062537037037037   0.066796296296296   0.017782794100389   5.076396728502274])

legend(Location="eastoutside",Numcolumns=1)
formatAxes(ax)

exportgraphics(fh,"../Plots/Thesis/1/1_initial_checkPhiDependence.eps")