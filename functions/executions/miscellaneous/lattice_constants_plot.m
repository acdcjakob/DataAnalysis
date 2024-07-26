% alpha phase
data = [...
    4.98 13.43; ...
    4.96 13.59; ...
    4.75 12.99
    ];

names = [...
    "\alpha-Ga2O3"; ...
    "\alpha-Cr2O3"; ...
    "\alpha-Al2O3"
    ];

figure("OuterPosition",[100 100 400 400]);
hold(gca,"on")
legend(gca,"location","north")
axis padded
grid(gca,"on")
xlabel(gca,"{\ita} ("+char(197)+")")
ylabel(gca,"{\itc} ("+char(197)+")")
fontsize(12,"points")
set(gca,"Box","on")

CM = jet(4);
for n =[2,1,3]
    S(n)=scatter(data(n,1),data(n,2),DisplayName=names(n));
    set(S(n),"MarkerEdgeColor","k",...
        "MarkerFaceColor",CM(n,:),...
        "Marker","s",...
        "SizeData",36*2)
end

exportgraphics(gcf,"../Plots/graphics/graphics-plot-latticeConstants.pdf")
exportgraphics(gcf,"../Plots/graphics/graphics-plot-latticeConstants.png","Resolution",250)