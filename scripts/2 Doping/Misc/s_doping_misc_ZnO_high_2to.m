Ids = searchSamples_v2({{'Batch','Cr2O3_ZnO_CompVar2';'Sub','r-Al2O3'}});

fP = getFilePathsFromId(Ids,"XRD_2ThetaOmega",".xy");


[ax,fH] = makeLatexSize(.5,1);
    hold(ax,"on")

colMap = flip(cool(numel(fP)));
logAdd = 0;
for i = flip(1:numel(fP))
    T = searchSamples_v2({{'Id',Ids(i)}},true);
    data = getDiffraction(fP{i});
    x = data(:,1);
    y = log(data(:,2))+logAdd;
    plot(ax,x,y,...
        "Color",colMap(i,:)*.8,...
        "LineWidth",1,...
        "HandleVisibility","off")
    logAdd = logAdd + 4;
end
axis([49 53 0 32])
grid on
ax.YTickLabel = {};

ylabel('counts (a.u.)')
xlabel('\omega (°)')
% yscale log

title("{\itr}-plane from Zn-doped (H)")

xline(get2Theta([0 2 4],"Al2O3","WLa1",52.506),"--r","DisplayName","Al_2O_3: W-L\alpha_1")
xline(get2Theta([0 2 4],"Al2O3","WLa2",52.506),"--b","DisplayName","Al_2O_3: W-L\alpha_2")
xline(get2Theta([0 2 4],"Cr2O3","CuKa1"),"k","DisplayName","Cr_2O_3: Cu-K\alpha_1")

legend

set(fH,"Renderer","painters")
exportgraphics(fH,"../Plots/Thesis/2/2_misc_ZnO_high_r_2to.pdf")