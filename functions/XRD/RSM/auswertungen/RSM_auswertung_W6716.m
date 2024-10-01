CHILD = true;
NOEXPORT = true;

figure("OuterPosition",[100 100 800 600],"Name","W6716")
ax1 = axes("OuterPosition",[0 .45 1/3 .45]);
ax2 = axes("OuterPosition",[1/3 .45 1/3 .45]);
ax3 = axes("OuterPosition",[2/3 .45 1/3 .45]);
Ax = [ax1,ax2,ax3];

RSM_auswertung_W6716_220

xlim(ax1,[-4.25 -3.95]);
ylim(ax1,[6.8 7.4]);
xlim(ax2,[-.1 .1])
xlim(ax3,[3.95 4.25])
legend(ax1,"Location","east")
legend(ax2,"off")

% ---
drawnow

ax4 = axes("OuterPosition",[0 0 1/3 .45]);
ax5 = axes("OuterPosition",[1/3 0 1/3 .45]);
ax6 = axes("OuterPosition",[2/3 0 1/3 .45]);
Ax = [ax4,ax5,ax6];

RSM_auswertung_W6716_306

xlim(ax4,[-4.8 -4.2]);
ylim(ax4,[6.8 7.4]);
xlim(ax5,[-.15 .15])
xlim(ax6,[4.2 4.8])
legend(ax4,"Location","east")
legend(ax5,"off")

sgtitle("{\itd} = 155 nm; \omega-FWHM = "+num2str(getRocking("W6716"),"%.2f")+"°")
disp("export..")
exportgraphics(gcf,"../Plots/RSM/RSM_W6716.png","Resolution",300)