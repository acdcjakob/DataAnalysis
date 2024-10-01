L = -2:.1:3;
E = 200:20:800;

F = zeros([numel(E) numel(L)]);
for l = 1:numel(L)
    for j = 1:numel(E)
        F(j,l) = energyDensity(L(l),false,E(j));
    end
end

[ax,f] = makeLatexSize(1,.4);
hold(ax,"on")

ch = contourf(L,E,F,0:.25:2.5,...
    "LineStyle","--",...
    "HandleVisibility","off",...
    "ShowText","on");
ax.XAxis.Label.String = "lens position (cm)";
ax.YAxis.Label.String = "pulse energy (mJ)";

cb = colorbar(ax);
    cb.Label.String = "{\itF} (J cm^{-2})";
    cb.FontSize = 10;
    cb.Label.FontSize = 12;
    

st = [-2,650];
scatter(ax,st(1),st(2),36*4,"sk",...
    "Displayname","standard configuration"+newline+...
    energyDensity(st(1),true,st(2)),...
    "MarkerfaceColor","m")

F_L = [-2,0,1,2];
F_E = [300 450 650 800];
plot(F_L,repmat(650,[1 numel(F_L)]),"o-","LineWidth",1,...
    DisplayName="lens position variation",...
    MarkerFaceColor="w",...
    Color=[.8 .8 .2])

plot(repmat(-1,[1 numel(F_E)]),F_E,"^-","LineWidth",1,...
    DisplayName="pulse energy variation",...
    MarkerFaceColor="w",...
    Color=[.8 .2 .2])

legend("FontSize",10,"Location","southeast")
set(f,"Renderer","Painters");
exportgraphics(f,"../Plots/graphics/fluence.eps")