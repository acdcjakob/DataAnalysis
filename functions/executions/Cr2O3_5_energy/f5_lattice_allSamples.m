Subs = {'c','m','r','a'};
SubCoef = {'(00.6)','(30.0)','(02.4)','(11.0)'};
Lenses = {'-2','0','1','2'};
DensityLabels = {energyDensity(-2,true);...
    energyDensity(0,true);...
    energyDensity(1,true);...
    energyDensity(2,true)};
IdCell = cell(4,4);
lattice = cell(4,4);
for iSub = 1:numel(Subs)
    for iLens = 1:numel(Lenses)
        IdCell{iSub,iLens} = searchSamples_v2(...
            {{'Batch','Cr2O3_energy';...
            'Sub',Subs{iSub}+"-Al2O3";...
            'NameVal',Lenses{iLens};...
            'ThetaOmega','a'}},true...
            );

        for j = 1:numel(IdCell{iSub,iLens}.Id)
            lattice{iSub,iLens}(j) = getPeakShift(IdCell{iSub,iLens}.Id{j},"lattice",true);
        end
    end
end
%%
F = figure("OuterPosition",[100 100 600 700]);
ax = cell(1,4);
scats = cell(4,4);
CM = cool(4)*.9;
tem = summer(4)*.9;
CM(2,:) = tem(2,:);
Legends = cell(1,4);
Means = cell(4,4); % mean
LabelsY = ["out-of-plane{\it c} ("+char(197)+")";...
    "out-of-plane{\it a} ("+char(197)+")";...
    "out-of-plane{\it a} ("+char(197)+")";...%+sprintf("\n(assuming reference ratio")+"{\it a/c})";...
    "out-of-plane{\it a} ("+char(197)+")"];
subplotindex = {1 2 4 6};
reference = [13.59;4.96;4.96;4.96];
pos = {[0 .45 .5 .45],...
    [.5 .45 .5 .45],...
    [0 0 .5 .45],...
    [.5 0 .5 .45]};
ax{1} = axes("OuterPosition",pos{1});
ax{2} = axes("OuterPosition",pos{2});
ax{3} = axes("OuterPosition",pos{3});
ax{4} = axes("OuterPosition",pos{4});
for iSub = 1:numel(Subs)
    % ax{iSub} = subplot(3,2,subplotindex{iSub});
    for iLens = 1:numel(Lenses)
        scats{iSub,iLens} = scatter(ax{iSub},IdCell{iSub,iLens}.d,lattice{iSub,iLens});
            % PLOT X VS Y
        hold(ax{iSub},"on");
        % scats{iSub,iLens}.DisplayName = "L="+Lenses{iLens}+"cm";
        scats{iSub,iLens}.DisplayName = DensityLabels{iLens};
        scats{iSub,iLens}.MarkerFaceColor = CM(iLens,:);
        scats{iSub,iLens}.MarkerEdgeColor = "k";
        Means{iSub,iLens} = yline(ax{iSub},mean(lattice{iSub,iLens}),...
            "Color",CM(iLens,:),...
            "Alpha",.5,...
            "HandleVisibility","off"...
            );
        if std(lattice{iSub,iLens}) == 0
            Means{iSub,iLens}.LineStyle = "--";
        elseif std(lattice{iSub,iLens})<1
            Means{iSub,iLens}.LineWidth = 2;
        end
        % if  iLens == 3 || iLens == 4
            Means{iSub,iLens}.Visible = "off";
        % end
            % if iLens == -1 % show mean in legend 
            %     Means{iSub,iLens}.DisplayName = "(mean)";
            % else
            %     Means{iSub,iLens}.HandleVisibility = "off";
            % end
    end
    Legends{iSub} = legend(ax{iSub});
    Legends{iSub}.Title.String = Subs{iSub}+"-oriented";
    Legends{iSub}.NumColumns = 2;
    Legends{iSub}.Location = "northoutside";
    title(ax{iSub},Subs{iSub}+"-oriented")
    axis padded
    set(ax{iSub},"Box","on")
    grid(ax{iSub},"on")

    ylabel(ax{iSub},LabelsY(iSub))
    xlabel(ax{iSub},"film thickness (nm)")
    yline(ax{iSub},reference(iSub),"k","LineWidth",1,"HandleVisibility","off")
    % create standalone
    Fnew = figure("Position",get(F,"Position"));
    copyobj([Legends{iSub},ax{iSub}],Fnew);
    exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-lattice_"+Subs{iSub}+".pdf");
    exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-latticeOnly_"+Subs{iSub}+".png","Resolution",250);
    delete(Fnew);
    clear Fnew;

    % % --- mark samples ---
    % if iSub == 4
    %     Fnew = figure;
    %     copyobj([cellfun(@(x) x,ax),cellfun(@(x) x,Legends)],Fnew);
    % 
    %     W6903a = plot(Fnew.Children(8),lattice{4,1}(3),IdCell{4,1}.d(3),"HandleVisibility","off");
    %     W6903a.Marker = "sq";
    %     W6903a.MarkerSize = 15;
    %     W6903a.LineWidth = 2;
    %     W6903a.Color = "r";
    % 
    %     W6902a = plot(Fnew.Children(8),lattice{4,2}(1),IdCell{4,2}.d(1),"HandleVisibility","off");
    %     W6902a.Marker = "sq";
    %     W6902a.MarkerSize = 15;
    %     W6902a.LineWidth = 2;
    %     W6902a.Color = "r";
    %     exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-highlight_RSM_01.pdf");
    %     exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-highlight_RSM_01.png","Resolution",250);
    %     delete(Fnew)
    %     clear Fnew
    % end
end
for j = 1:numel(Legends)
    delete(Legends{j});
end
set(F,"OuterPosition",[100 100 500 500])
L = legend(ax{1});
L.NumColumns = 2;
L.Position = [0.349318801089919,0.91770698521455,0.300000000000001,0.053848642766244];
linkaxes(cellfun(@(x) x,ax([2,3,4])))
%%
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-lattice_allCuts.pdf");
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-lattice_allCuts.png","Resolution",250)
