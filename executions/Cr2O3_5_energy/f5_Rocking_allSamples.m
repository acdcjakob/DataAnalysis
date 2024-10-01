Subs = {'c','m','r','a'};
SubCoef = {'(00.6)','(30.0)','(02.4)','(11.0)'};
Lenses = {'-2','0','1','2'};
DensityLabels = {energyDensity(-2,true);...
    energyDensity(0,true);...
    energyDensity(1,true);...
    energyDensity(2,true)};
IdCell = cell(4,4);
rocking = cell(4,4);
for iSub = 1:numel(Subs)
    for iLens = 1:numel(Lenses)
        IdCell{iSub,iLens} = searchSamples_v2(...
            {{'Batch','Cr2O3_energy';...
            'Sub',Subs{iSub}+"-Al2O3";...
            'NameVal',Lenses{iLens};...
            'ThetaOmega','a'}},true...
            );

        for j = 1:numel(IdCell{iSub,iLens}.Id)
            rocking{iSub,iLens}(j,1) = getRocking(IdCell{iSub,iLens}.Id{j});
        end
    end
end
%%
F = figure("OuterPosition",[100 100 600 600]);
ax = cell(1,4);
scats = cell(4,4);
CM = cool(4)*.9;
tem = summer(4)*.9;
CM(2,:) = tem(2,:);
L = cell(1,4);
M = cell(4,4); % mean
for iSub = 1:numel(Subs)
    ax{iSub} = subplot(2,2,iSub);
    for iLens = 1:numel(Lenses)
        hold(gca,"on")
        plotData = [IdCell{iSub,iLens}.d,rocking{iSub,iLens}];
        plotData = sortrows(plotData);
        if isempty(plotData)
            plotData = [nan,nan];
        end
        plot(plotData(:,1),plotData(:,2),"--","Color",CM(iLens,:),"HandleVisibility","off")
        scats{iSub,iLens} = scatter(IdCell{iSub,iLens}.d,rocking{iSub,iLens});
        S = scats{iSub,iLens};
        % S.DisplayName = "L="+Lenses{iLens}+"cm";
        S.DisplayName = DensityLabels{iLens};
        S.MarkerFaceColor = CM(iLens,:);
        S.MarkerEdgeColor = "k";
        
        
        M{iSub,iLens} = xline(mean(rocking{iSub,iLens}),...
            "Color",CM(iLens,:),...
            "Alpha",.5...
            );
        if std(rocking{iSub,iLens}) == 0
            M{iSub,iLens}.LineStyle = "--";
        elseif std(rocking{iSub,iLens})<1
            M{iSub,iLens}.LineWidth = 2;
        end
            if iLens == -1
                M{iSub,iLens}.DisplayName = "(mean)";
            else
                M{iSub,iLens}.HandleVisibility = "off";
            end
        M{iSub,iLens}.Visible = "off";
    end
    L{iSub} = legend;
    L{iSub}.Title.String = Subs{iSub}+"-oriented";
    L{iSub}.NumColumns = 2;
    L{iSub}.Location = "northoutside";
    axis padded
    set(gca,"Box","on")
    grid on
    
    % xtickformat(ax{iSub},'percentage')
    % set(get(ax{iSub},'XAxis'),'Exponent',0)
    ylabel(SubCoef{iSub}+" FWHM (°)")
    xlabel("film thickness (nm)")

    % create standalone
    % Fnew = figure;
    % copyobj([L{iSub},ax{iSub}],Fnew);
    % exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-shift_"+Subs{iSub}+".pdf");
    % exportgraphics(Fnew,"../Plots/Cr2O3/5 energy/5-shiftOnly_"+Subs{iSub}+".png","Resolution",250);
    % delete(Fnew);
    % clear Fnew;

    % % --- mark samples ---
    % if iSub == 4
    %     Fnew = figure;
    %     copyobj([cellfun(@(x) x,ax),cellfun(@(x) x,L)],Fnew);
    % 
    %     W6903a = plot(Fnew.Children(8),rocking{4,1}(3),IdCell{4,1}.d(3),"HandleVisibility","off");
    %     W6903a.Marker = "sq";
    %     W6903a.MarkerSize = 15;
    %     W6903a.LineWidth = 2;
    %     W6903a.Color = "r";
    % 
    %     W6902a = plot(Fnew.Children(8),rocking{4,2}(1),IdCell{4,2}.d(1),"HandleVisibility","off");
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

%%
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-Rocking_allCuts.pdf");
exportgraphics(F,"../Plots/Cr2O3/5 energy/5-Rocking_allCuts.png","Resolution",250)