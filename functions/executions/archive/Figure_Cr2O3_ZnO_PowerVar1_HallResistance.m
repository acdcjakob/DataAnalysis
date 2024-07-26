cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");
H = gobjects();
plotHall_v4
% filter "%%$02-19"
h.DisplayName = "before annealing";
h.Marker = "s";
h.LineWidth = .9;
hold on
H(1) = h;

plotHall_v4
% filter "%%$Annealed"
h.DisplayName = "after annealing";
h.Marker = "o";
h.LineWidth = .9;
hold on
H(2) = h;

drawnow

set(gca,"XTick",[1,2,3,4])
set(gca,"XTickLabel",[300 400 450 500])
xlabel("Substrate Heater Power (W)")
ylabel("\rho (\Omega{m})")
grid
legend
ylabel("\rho (\Omega{m}) (thickness corrected)")
