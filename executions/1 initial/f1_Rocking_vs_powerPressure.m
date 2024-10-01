cd C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis
figure("OuterPosition",[100 100 500 500]);
%%
load PLOTCONSTANT.mat
sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch$NameUnit","%%$Cr2O3_initial$°C"),true);

sampleTable = sortrows(sampleTable,"d");
X = columnToNumber(sampleTable.NameVal);
Y = getRocking(sampleTable.Id);
t = sortrows([X,transpose(Y)]);
X = t(:,1);
Y = t(:,2);
% for i = 1:numel(sampleTable.Id(:))
%     X(i) = columnToNumber(sampleTable.NameVal(i));
%     Y(i) = getRocking(sampleTable.Id{i});
%     Id{i} = sampleTable.Id{i};
%  end


p = plot(X,Y,"Linestyle","--","Marker","square","LineWidth",1.5);
ax1 = gca;
    set(ax1,"Position",get(ax1,"Position")-[0 0 0 0.05])
    p.Color = hex2rgb(LINECOLOR(1,1));
    p.MarkerSize = 12;
    ax1.XColor = hex2rgb(LINECOLOR(1,1)).*0.6;
    
    hold on
        % pFit = plot(p.XData,polyval(polyfit(p.XData,p.YData,1),p.XData));
        % pFit.Color = [.5 .5 .8 .6];
    grid
    ax1.GridLineWidth = 1;
    ax1.GridAlpha =.2;
    ax1.YGrid = "off";

ylabel("\omega-scan FWHM (°)");
xlabel("Temperature (°C)")
set(get(ax1,"XLabel"),"FontWeight","bold");
% xscale("log")
ax1.XTick = 725:10:765;
set(ax1,"YGrid","on")
set(ax1,"XGrid","off")
%%
hold on
ax2 = axes("Position",get(ax1,"Position"),"Color","none","YAxisLocation","right","XAxisLocation","top");
% linkaxes([ax1 ax2],'y')

sampleTable = searchSamples_v2(searchSamplesPrompt("%%$Batch$NameUnit","%%$Cr2O3_initial$mbar"),true);

sampleTable = sortrows(sampleTable,"NameVal");
X = columnToNumber(sampleTable.NameVal);
Y = getRocking(sampleTable.Id);


% for i = 1:numel(sampleTable.Id(:))
%     X(i) = columnToNumber(sampleTable.NameVal(i));
%     Y(i) = getRocking(sampleTable.Id{i});
%     Id{i} = sampleTable.Id{i};
%  end

hold(ax2,"on");

p = plot(ax2,X,Y);
axis(ax2,"padded")
p.Marker = "s";
p.Color = hex2rgb(LINECOLOR(2,1));
ax2.XColor = hex2rgb(LINECOLOR(2,1)).*0.6;

p.MarkerSize = 12;
p.LineWidth = 1.5;
hold on
grid(ax2,"off")

xlabel("oxygen pressure (mbar)");
    set(get(ax2,"XLabel"),"FontWeight","bold");

linkaxes([ax1 ax2],'y');
ax2.YTick = [];
ax2.XScale = "log";

%%
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-rocking_vs_both.png","Resolution",250)
exportgraphics(gcf,"../Plots/Cr2O3/1 initial/1-rocking_vs_both.pdf")