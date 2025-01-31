% alpha phase

data = [...
    4.98 13.43; ...
    4.96 13.59; ...
    4.76 13.00
    ];

names = [...
    "\alpha-Ga_2O_3"; ...
    "\alpha-Cr_2O_3"; ...
    "\alpha-Al_2O_3"
    ];

[ax,f] = makeLatexSize(.5,.8);
hold(ax,"on")
legend(ax,"location","north")
axis padded
grid(ax,"on")
xlabel(ax,"{\ita} ("+char(197)+")")
ylabel(ax,"{\itc} ("+char(197)+")")

CM = jet(4);
for n =[2,1,3]
    S(n)=scatter(data(n,1),data(n,2),DisplayName=names(n));
    set(S(n),"MarkerEdgeColor","k",...
        "MarkerFaceColor",CM(n,:),...
        "Marker","s",...
        "SizeData",36*2)
end
formatAxes(ax)

axHilf = axes;
axHilf.YColor = "none";
axHilf.XColor = "none";
axHilf.Position = [0.0507    0.0737    0.8543    0.8513];
axHilf.Color = "none";

% exportgraphics(gcf,"../Plots/graphics/graphics-plot-latticeConstants.pdf")
% exportgraphics(gcf,"../Plots/graphics/graphics-plot-latticeConstants.png","Resolution",250)
set(ax,"Position",get(ax,"Position")+[.5 0 0 0])
exportgraphics(f,"../Plots/Thesis/graphs/latticeConstantsComparison.png","Resolution",400)