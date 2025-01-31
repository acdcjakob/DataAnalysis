% extracted from c_plane_stabilization.m
fP(3)=getFilePathsFromId("W6959m",...
        "XRD_2ThetaOmega",".xy");

O(3) = 0;

i = 3;
data{i} = getDiffraction(fP{i});
x{i} = data{i}(:,1)+O(i);
y{i} = data{i}(:,2);

ax = makeLatexSize(.9,.5);
xlabel(ax,"2\theta (°)")
ylabel(ax,"counts (a.u.)")
    formatAxes(ax);
p(i) = plot(x{i},y{i},...
    "LineWidth",1,...
    "DisplayName","Ga_2O_3 on m-plane Cr_2O_3",...
    "Color",[.8 0 0]);
hold on;

set(gca,...
        "YScale","log",...
        "YTickLabel",{},...
        "LineWidth",1,...
        "FontSize",12);
axis tight
grid on

xlabel("2\theta (°)")
ylabel("intensity (a.u.)")

leg = legend;

exportgraphics(gcf,"../Plots/Thesis/4/4_mPlane_onlyInSitu.eps")

%%
% get ex-situ
fP(2)=getFilePathsFromId("W6957m",...
        "XRD_2ThetaOmega",".xy");
O(2) = 0.06;
i = 2;
data{i} = getDiffraction(fP{i});
x{i} = data{i}(:,1)+O(i);
y{i} = data{i}(:,2);

p(i) = plot(x{i},y{i},...
    "LineWidth",1,...
    "DisplayName","Ga_2O_3 on m-plane Cr_2O_3",...
    "Color",[0 .8 0]);



xlim([58 70])

xline(get2Theta([3 0 0],"Ga2O3"),":","LineWidth",2,...
    "DisplayName","(00.6)_{\alpha-Ga2O3}",...
    "Alpha",1,...
    "Color",[.8 .2 .2]);

xline(get2Theta([3 0 0],"Cr2O3"),":","LineWidth",2,...
    "DisplayName","(00.6)_{Cr2O3}",...
    "Alpha",1,...
    "Color",[0 0 .8]);

delete(leg);

exportgraphics(gcf,"../Plots/Thesis/4/4_mPlane_inAndExSitu_zoom.eps")