CHILD = true;
NOEXPORT = true;

figure("OuterPosition",[100 100 800 600],"Name","W6902m")
ax1 = axes("OuterPosition",[0 .45 1/3 .45]);
ax2 = axes("OuterPosition",[1/3 .45 1/3 .45]);
ax3 = axes("OuterPosition",[2/3 .45 1/3 .45]);
Ax = [ax1,ax2,ax3];

RSM_auswertung_W6902m_220

xlim(ax1,[-4.3 -3.9]);
ylim(ax1,[6.8 7.4]);
xlim(ax2,[-.2 .2]);
xlim(ax3,[3.9 4.3]);
legend(ax1,"Location","west")
legend(ax2,"off")
legend(ax3,"off")

% ---
drawnow

ax4 = axes("OuterPosition",[0 0 1/3 .45]);
ax5 = axes("OuterPosition",[1/3 0 1/3 .45]);
ax6 = axes("OuterPosition",[2/3 0 1/3 .45]);
Ax = [ax4,ax5,ax6];

RSM_auswertung_W6902m_306

xlim(ax4,[-4.8 -4.2]);
ylim(ax4,[6.8 7.4]);
xlim(ax5,[-.2 .2])
xlim(ax6,[4.2 4.8])
legend(ax4,"Location","west")
legend(ax5,"off")
legend(ax6,"off")

sgtitle("m-plane Cr2O3 ("+energyDensity(0,true)+")")
exportgraphics(gcf,"../Plots/RSM/RSM_W6902m.png","Resolution",300)