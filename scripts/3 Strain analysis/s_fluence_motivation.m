samTable = searchSamples_v2({{'Batch','Cr2O3_ZnO_Lens'}},true);

fP_Omega = getFilePathsFromId(samTable.Id,'XRD_Omega','.xy');
fP_2Theta = getFilePathsFromId(samTable.Id,'XRD_2ThetaOmega','.xy');

[ax1,fh] = makeLatexSize(1,.5);
    hold(ax1,"on")
    set(ax1,...
        "XLim",[35 42],...
        "YScale","log",...
        "YTickLabel",{})
ax2 = axes("Units","centimeters",...
    "Position",[2.7019    3.5510    4.7120    4.6104],...
    "YtickLabel",{},...
    "XAxisLocation","top");
formatAxes(ax2)
    hold(ax2,"on")

p = gobjects(2,2);
colMap = [
    .2 .8 .2;
    .7 .2 .7];
for i = 1:2
    omega = getDiffraction(fP_Omega{i});
    theta = getDiffraction(fP_2Theta{i});

    p(i,1) = plot(ax1,theta(:,1),theta(:,2));
    p(i,2) = plot(ax2,omega(:,1),omega(:,2),'--');
    for j = 1:2
        set(p(i,j),...
            "Color",colMap(i,:),...
            "LineWidth",1)
    end
    p(i,2).DisplayName = num2str(60*getRocking(samTable.Id{i}),"%.1f");
    p(i,1).DisplayName = "{\itF} = "+energyDensity(samTable.NameVal{i},true);
end
xline(ax1,get2Theta([0 0 6],"Cr2O3"),"r",...
    "DisplayName","Cr_2O_3 expected",...
    "LineWidth",1)
l1 = legend(ax1,...
    "Position",[0.6428    0.2190    0.2301    0.1705]);
l2 = legend(ax2,...
    "Position",[0.3340    0.6032    0.1789    0.1604]);
    l2.Title.String = "\omega-FWHM (arcmin)";
formatAxes(ax1)
formatAxes(ax2)

ylabel(ax1,"counts (a.u.)")
xlabel(ax1,"2\theta (°)")
xlabel(ax2,"\omega (°)")

grid([ax1,ax2],"on")

exportgraphics(fh,"../Plots/Thesis/3/3_fluence_motivation.eps")