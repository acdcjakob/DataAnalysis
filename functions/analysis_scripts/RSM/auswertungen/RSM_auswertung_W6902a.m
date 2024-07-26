CHILD = true;
NOEXPORT = true;

figure("OuterPosition",[100 100 800 600],"Name","W6902a")

ax1 = axes("OuterPosition",[0 0 1/3 .45]);
ax2 = axes("OuterPosition",[1/3 0 1/3 .45]);
ax3 = axes("OuterPosition",[2/3 0 1/3 .45]);
Ax = [ax1,ax2,ax3];

RSM_auswertung_W6902a_226

xlim(ax1,[-4.7 -4.3]);
ylim(ax1,[7.8 8.5]);
xlim(ax2,[-.2 .2]);
xlim(ax3,[4.3 4.7]);
legend(ax1,"Location","southwest")
legend(ax2,"off")
legend(ax3,"off")

% ---
drawnow
ax4 = axes("OuterPosition",[0 .45 1/3 .45]);
ax5 = axes("OuterPosition",[1/3 .45 1/3 .45]);
ax6 = axes("OuterPosition",[2/3 .45 1/3 .45]);

Ax = [ax4,ax5,ax6];

RSM_auswertung_W6902a_300

xlim(ax4,[-3.9 -3.3]);
ylim(ax4,[5.7 6.5]);
xlim(ax5,[-.2 .2])
ylim(ax5,[7.8 8.5])
xlim(ax6,[3.3 3.9])
legend(ax4,"Location","southwest")
legend(ax5,"off")
legend(ax6,"off")

delete(ax5);

sgtitle("a-plane Cr2O3 ("+energyDensity(0,true)+")")
exportgraphics(gcf,"../Plots/RSM/RSM_W6902a.png","Resolution",300)