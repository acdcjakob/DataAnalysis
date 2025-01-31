% extracted from c_plane_stabilization.m
fP(3)=getFilePathsFromId("W6959c",...
        "XRD_2ThetaOmega",".xy");

O(3) = 0.03;

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
    "DisplayName","Ga_2O_3 on c-plane Cr_2O_3",...
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

% exportgraphics(gcf,"../Plots/Thesis/4/4_cPlane_onlyInSitu.eps")

%%
% get ex-situ
fP(2)=getFilePathsFromId("W6957c",...
        "XRD_2ThetaOmega",".xy");zt
O(2) = 0.06;
i = 2;
data{i} = getDiffraction(fP{i});
x{i} = data{i}(:,1)+O(i);
y{i} = data{i}(:,2);

p(i) = plot(x{i},y{i},...
    "LineWidth",1,...
    "DisplayName","Ga_2O_3 on c-plane Cr_2O_3",...
    "Color",[0 .8 0]);



xlim([38,42])

xline(get2Theta([0 0 6],"Ga2O3"),":","LineWidth",2,...
    "DisplayName","(00.6)_{\alpha-Ga2O3}",...
    "Alpha",1,...
    "Color",[.8 .2 .2]);

xline(38.77,"--","LineWidth",1.5,...
    "DisplayName","(004) {\kappa-Ga_2O_3}",...
    "Alpha",1,...
    "Color",[.2 .6 .5])

delete(leg);

exportgraphics(gcf,"../Plots/Thesis/4/4_cPlane_inAndExSitu_zoom.eps")