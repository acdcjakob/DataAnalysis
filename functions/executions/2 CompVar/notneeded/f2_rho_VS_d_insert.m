dontAskUser = 1;

F = figure("OuterPosition",[100 100 600 500]);
axmatrix = gobjects(4,1);
%%
subArray = {'c','r','c','r'};
targetArray = {'ZnO','ZnO','CuO','CuO'};

posArray = {[0 .5 .5 .5],...
    [.5 .5 .5 .5],...
    [0 0 .5 .5],...
    [.5 0 .5 .5]};

for i = 1:4
    % data
    Specs_Hall_RT.property1 = '%%$Batch$Sub$NameUnit';
    Specs_Hall_RT.value1 = strcat('%%$Cr2O3_',targetArray{i},'_CompVar1$',subArray{i},'-Al2O3$mm');
    Specs_Hall_RT.Messung = 'Hall_RT';
    Specs_Hall_RT.xAxisProp = 'Batch';
    Specs_Hall_RT.xAxis = 'd';
    Specs_Hall_RT.yAxis = 'rho';
    Specs_Hall_RT.mean = '0';
    Specs_Hall_RT.filter = '';
    
    axmatrix(i) = axes("OuterPosition",posArray{i});
    set(F,"CurrentAxes",axmatrix(i))

    plotHall_v4;
        Htot{i} = H;
        grid(gca,"on");
        Titles{i} = title(gca,strcat(targetArray{i},"-target ",subArray{i},"-orientation"));
        yscale("log")
        Legends{i} = legend(gca);
    

    % pure
    Specs_Hall_RT.property1 = '%%$Batch$Sub';
    Specs_Hall_RT.value1 = strcat('%%$Cr2O3_Pure$',subArray{i},'-Al2O3');
    Specs_Hall_RT.Messung = 'Hall_RT';
    Specs_Hall_RT.xAxisProp = 'Batch';
    Specs_Hall_RT.xAxis = 'd';
    Specs_Hall_RT.yAxis = 'rho';
    Specs_Hall_RT.mean = '0';
    Specs_Hall_RT.filter = '';

    plotHall_v4;
        Htot{i}(:,2) = H;
end


for i = 1:4
    linePainter(Htot{i}(:,1),"width",0.7);
    for j = 1:numel(Htot{i}(:,2))
        Htot{i}(j,2).Marker = ".";
        if j == 1
            Htot{i}(j,2).DisplayName = "pure";
            Htot{i}(j,2).Color = "k";
            Htot{i}(j,2).MarkerSize = 12;
        else
            Htot{i}(j,2).Visible = "off";
            Htot{i}(j,2).HandleVisibility = "off";
        end
    end
    ax = axmatrix(i);
    ax.FontSize = 10;
    ax.Title.FontSize = 10;
    ax.XLabel.String = "{\itd} (nm)";
    if i == 1
        set(ax.Legend,"Location","northeast")
    else
        set(ax.Legend,"Visible","off")
    end
end
%%
linkaxes(axmatrix)
% xlim([100 240])
% ylim([1e-2 2e1])
% sgtitle("\rho vs. thickness")

%%
% exportgraphics(gcf,"../Plots/Cr2O3/2 CompVar/2-rho_vs_d_insert.pdf")