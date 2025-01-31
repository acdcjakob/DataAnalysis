L = [0, -5, -15, -10, +5, -20]/10; % cm
A = [15.05, 13.05, 9.92, 11.13, 18.81, 7.61]; % mm^2
pFit = polyfit(L,A,2);

[ax,f] = makeLatexSize(.8,.35/.8);
    hold(ax,"on")

scatter(ax,L,A,"sk","filled","displayname","measured")
xFit = -2:0.1:2;
plot(ax,xFit,polyval(pFit,xFit),"--r","LineWidth",1,...
    "DisplayName","fit")

l = legend(ax,"location","northwest");
l.Title.Interpreter = "latex";
l.Title.String = "$A(L)=a_2L^2+a_1L+a_0$";

xlabel("{\itL} (cm)")
ylabel("{\itA} (mm^2)")

grid on

exportgraphics(f,"../Plots/Thesis/Graphs/laserSpotSize.eps")


% units of pFit:
% a_2: [] * cm^2    = [mm^2]    --> mm^2/cm^2 = 0.01
% a_1: [] * cm      = [mm^2]    --> mm^2/cm = 0.0001 m = 0.1 mm
% a_0: []           = [mm^2]    --> mm^2    = mm^2