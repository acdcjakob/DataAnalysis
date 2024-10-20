Ids = ...
    ["W6778c","0.01%-CuO doped","";...
    "W6784c","0.01%-ZnO doped","";...
    "W6856c","1%-ZnO doped","";...
    "W6788c","pure Cr2O3","origin"...
    ];

N = numel(Ids(:,1));
data = cell(N,1);
F = figure("OuterPosition",[100 100 600 500]);
ax1 = axes(F,"OuterPosition",[0 0 .5 1]);
    hold(ax1,"on")
    set(ax1,"YScale","log")
    grid(ax1,"on")
    legend(ax1)
    ylabel(ax1,"{\it\rho} (\Omegam)")
    xlabel(ax1,"{\itT} (K)")
ax2 = axes(F,"OuterPosition",[.5 0 .5 1]);
    hold(ax2,"on")
    set(ax2,"YScale","log")
    grid(ax2,"on")
    % legend(ax2)
    ylabel(ax2,"{\it\rho} (\Omegam)")
    xlabel(ax2,"{\itT} ^{-1} (1000/K)")

    M = ["^","sq"];
    C = jet(N);
for i = 1:N
    data{i} = rescaleTdH_resistivity(Ids(i,1),"filter",Ids(i,3));

    % iterate I_set
    for j = 1:numel(data{i})
        dataTab = data{i}{j};
        P1(i,j) = plot(ax1,dataTab(:,1),dataTab(:,2));
            P1(i,j).Marker = M(j);
            P1(i,j).MarkerFaceColor = C(i,:);
            P1(i,j).MarkerEdgeColor = C(i,:)*0.5;
            P1(i,j).Color = C(i,:)*0.7;
            P1(i,j).LineStyle = "--";
        P2(i,j) = plot(ax2,1000./dataTab(:,1),dataTab(:,2));
            P2(i,j).Marker = M(j);
            P2(i,j).MarkerFaceColor = C(i,:);
            P2(i,j).MarkerEdgeColor = C(i,:)*0.5;
            P2(i,j).Color = C(i,:)*0.7;
            P2(i,j).LineStyle = "--";
        if j == 1
            P1(i,j).DisplayName = Ids(i,2);
            P2(i,j).DisplayName = Ids(i,2);
        elseif j == 2 & i == 1
            P1(i,j).DisplayName = "diff. I_{set}";
            P2(i,j).DisplayName = "diff. I_{set}";
        else
            P1(i,j).HandleVisibility = "off";
            P2(i,j).HandleVisibility = "off";
        end
    end
end
linkaxes([ax1,ax2],"y");

exportgraphics(F,"../Plots/Cr2O3/2 Doping/2-TdH.pdf")
exportgraphics(F,"../Plots/Cr2O3/2 Doping/2-TdH.png","Resolution",250)

%% activation energy
F2 = figure("OuterPosition",[500 100 800 500]);
T = tiledlayout(2,2);
makeLatexSize(1,.7,T)
k = 8.62e-5; % eV / K
% 0.01%-ZnO-doped target


d = data{2,1}{1,1};

x = 1./d(:,1);
y = log(d(:,2));
x1 = x(x<0.012);
x2 = x(x>=0.012);
y1 = y(x<0.012);
y2 = y(x>=0.012);

p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,1);
T1 = nexttile;
    formatAxes(T1);
    hold(T1,"on");
plot(x*1000,exp(y),"s",HandleVisibility="off",MarkerFaceColor=C(2,:),Color=(C(2,:)*0.5))
set(gca,"Yscale","log")
drawnow
set(gca,"YLimMode","manual")
hold(T1,"on")
act = [p1(1)*k*1000,p2(1)*k*1000]; % meV

plot(x*1000,exp(polyval(p1,x)),"r-","DisplayName",...
    "E_A = "+num2str(act(1),"%.1f")+" meV",...
    LineWidth=1);
plot(x*1000,exp(polyval(p2,x)),"b-","DisplayName",...
    "E_A = "+num2str(act(2),"%.1f")+" meV",...
    LineWidth=1);

l = legend(T1,"Location","southeast");
% l.Title.String = "\rho \propto exp({E_A/(kT)})";
xlabel(T1,"T^{-1} (1000/K)")
ylabel(T1,"\rho (\Omegam)")
grid on

title("0.01%-ZnO doped trgt")
formatAxes(T1);
% pure target

d = data{4,1}{1,1};

x = 1./d(:,1);
y = log(d(:,2));
x1 = x(x<0.014);
x2 = x(x>=0.014);
y1 = y(x<0.014);
y2 = y(x>=0.014);

p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,1);
T2 = nexttile();
    formatAxes(T2);
    hold(T2,"on");
plot(x*1000,exp(y),"s",HandleVisibility="off",MarkerFaceColor=C(4,:),Color=(C(4,:)*0.5))
set(gca,"Yscale","log")
drawnow
set(gca,"YLimMode","manual")
hold on
act = [p1(1)*k*1000,p2(1)*k*1000]; % meV

plot(x*1000,exp(polyval(p1,x)),"r-","DisplayName",...
    "E_A = "+num2str(act(1),"%.1f")+" meV",...
    LineWidth=1);
plot(x*1000,exp(polyval(p2,x)),"b-","DisplayName",...
    "E_A = "+num2str(act(2),"%.1f")+" meV",...
    LineWidth=1);

l = legend(T2,"Location","southeast");
% l.Title.String = "\rho \propto exp({E_A/(kT)})";
xlabel("T^{-1} (1000/K)")
ylabel("\rho (\Omegam)")
grid on

title("pure trgt")
formatAxes(T2);
% 1%-ZnO doped

d = data{3,1}{1,1};

x = 1./d(:,1);
y = log(d(:,2));
x1 = x(x<0.01);
x2 = x(x>=0.01);
y1 = y(x<0.01);
y2 = y(x>=0.01);

p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,1);
T3 = nexttile();

    formatAxes(T3);
    hold(T3,"on");
plot(x*1000,exp(y),"s",HandleVisibility="off",MarkerFaceColor=C(3,:),Color=(C(3,:)*0.5))
set(gca,"Yscale","log")
drawnow
set(gca,"YLimMode","manual")
hold on
act = [p1(1)*k*1000,p2(1)*k*1000]; % meV

plot(x*1000,exp(polyval(p1,x)),"r-","DisplayName",...
    "E_A = "+num2str(act(1),"%.1f")+" meV",...
    LineWidth=1);
plot(x*1000,exp(polyval(p2,x)),"b-","DisplayName",...
    "E_A = "+num2str(act(2),"%.1f")+" meV",...
    LineWidth=1);

l = legend(T3,"Location","southeast");
% l.Title.String = "\rho \propto exp({E_A/(kT)})";
xlabel("T^{-1} (1000/K)")
ylabel("\rho (\Omegam)")
grid on

title("1%-ZnO doped trgt")
formatAxes(T3);
% 0.01-CuO doped

d = data{1,1}{1,1};

x = 1./d(:,1);
y = log(d(:,2));
x1 = x(x<0.009);
x2 = x(x>=0.009&x<0.016);
y1 = y(x<0.009);
y2 = y(x>=0.009&x<0.016);

p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,1);
T4 = nexttile;
    formatAxes(T4);
    hold(T4,"on");
plot(x*1000,exp(y),"s",HandleVisibility="off",MarkerFaceColor=C(1,:),Color=(C(1,:)*0.5))
set(gca,"Yscale","log")
drawnow
set(gca,"YLimMode","manual")
hold(T4,"on")
act = [p1(1)*k*1000,p2(1)*k*1000]; % meV

plot(x*1000,exp(polyval(p1,x)),"r-","DisplayName",...
    "E_A = "+num2str(act(1),"%.1f")+" meV",...
    LineWidth=1);
plot(x*1000,exp(polyval(p2,x)),"b-","DisplayName",...
    "E_A = "+num2str(act(2),"%.1f")+" meV",...
    LineWidth=1);

l = legend(T4,"Location","southeast");
l.Title.String = "\rho \propto exp({E_A/(kT)})";
xlabel(T1,"T^{-1} (1000/K)")
ylabel(T1,"\rho (\Omegam)")
grid on

title("0.01%-CuO doped trgt")
formatAxes(T4);
% exportgraphics(F2,"../Plots/Cr2O3/2 Doping/2-TdH_activation.pdf")
% exportgraphics(F2,"../Plots/Cr2O3/2 Doping/2-TdH_activation.png","Resolution",250)