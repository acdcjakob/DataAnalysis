CHILD = true;
NOEXPORT = true;

figure("OuterPosition",[100 100 800 600],"Name","W6723")
ax1 = axes("OuterPosition",[0 .5 1/3 .5]);
ax2 = axes("OuterPosition",[1/3 .5 1/3 .5]);
ax3 = axes("OuterPosition",[2/3 .5 1/3 .5]);
Ax = [ax1,ax2,ax3];

RSM_auswertung_W6723_220

xlim(ax1,[-4.25 -3.95]);
ylim(ax1,[6.8 7.4]);
xlim(ax2,[-.1 .1])
xlim(ax3,[3.95 4.25])
legend(ax1,"Location","east")
legend(ax2,"off")
% ---
drawnow

ax4 = axes("OuterPosition",[0 0 1/3 .5]);
ax5 = axes("OuterPosition",[1/3 0 1/3 .5]);
ax6 = axes("OuterPosition",[2/3 0 1/3 .5]);
Ax = [ax4,ax5,ax6];

RSM_auswertung_W6723_306

xlim(ax4,[-4.8 -4.2]);
ylim(ax4,[6.8 7.4]);
xlim(ax5,[-.15 .15])
xlim(ax6,[4.2 4.8])
legend(ax4,"Location","east")
legend(ax5,"off")

exportgraphics(gcf,"../Plots/RSM/RSM_W6723.png","Resolution",300)