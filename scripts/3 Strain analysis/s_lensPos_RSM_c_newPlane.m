samTable = searchSamples_v2({{"Id","W6904c"}},true);

[ax,fH]=makeLatexSize(.7,1);

hold(ax,"On")
xlabel(ax,"q_{||} (nm^{-1})")
ylabel(ax,"q_{\perp} (nm^{-1})")

lit = getSapphireVector([1 0 0],[0 0 10]);

sub = [2.4349;7.6880];
film = [2.3665;7.2435];

[~,~,~,M] = correctReciprocalData(...
        film(1),film(2),lit,sub);

plotRSM(samTable.Id{1},"1010",[1,2],1.2,M)
title(ax,"{\itd} = "+num2str(samTable.d)+" nm");
ax.Title.FontSize = 12;
ax.Title.FontWeight = "normal";

axis(ax,[2.2 2.5 7 8])

exportgraphics(fH,"../Plots/Thesis/3/3_lensPos_c_RSM_1010.png","Resolution",800)