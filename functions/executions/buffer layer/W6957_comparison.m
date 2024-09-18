parentId = "W6957";
plane = ["c" "r" "m" "a"];
t = tiledlayout(4,2);
for i = 1:4
    fP(i)=getFilePathsFromId(parentId+plane(i),...
        "XRD_2ThetaOmega",".xy");
    data{i} = getDiffraction(fP{i});
    x = data{i}(:,1);
    y = data{i}(:,2);

    ax(i) =  nexttile(t,2*i-1);
    hold(ax(i),"on");

    plot(ax(i),x,y,...
        "LineWidth",1,...
        "Displayname",plane(i)+"-plane")
    l(i) = legend;
    
    formatAxes(ax(i))
    set(ax(i),...
        "YScale","log",...
        "YTick",[])
    axis tight
end
limits = {...
    [37 42];
    [45 55];
    [60 70];
    [32 40]};
for i = 1:4
    x = data{i}(:,1);
    y = data{i}(:,2);

    ax(i) =  nexttile(t,2*i);
    hold(ax(i),"on");

    plot(ax(i),x,y,...
        "LineWidth",1,...
        "Displayname",plane(i)+"-plane")
    l(i) = legend();
    xlim(ax(i),limits{i})
    
    formatAxes(ax(i))
    set(ax(i),"YScale","log",...
        "YTick",[])
end

xlabel(t,"2\theta (°)")
ylabel(t,"intensity (a.u.)")

makeLatexSize(1,1,t)
title(t,"ex-situ Ga_2O_3 on Cr_2O_3")
