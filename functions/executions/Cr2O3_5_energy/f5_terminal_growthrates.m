E = [
    energyDensity(-1,false,650)
    energyDensity(-1,false,300)
    energyDensity(-1,false,450)
    energyDensity(-1,false,800)
    energyDensity(-1,false,300)
];
p = [
    40e3
    40e3
    40e3
    35e3
    70e3
];
d = [
  200
  90
  150
  165
  148
];

[~,i] = sortrows(E);

plot(E(i),d(i)./p(i)*1000,"s-k","MarkerFaceColor","m","MarkerSize",12);

axis padded

xlabel("J/cm^2")
ylabel("pm/pulse")
grid on

exportgraphics(gcf,"../Plots/Cr2O3/5 energy/5-DRAFT_terminal_growthrates.pdf")