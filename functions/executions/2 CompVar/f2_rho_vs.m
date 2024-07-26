dependence = ["d","NameVal","Number","rate","lattice","rocking"];
dependence_names = ["thickness-dependence","composition-dependence","order-dependence","growthrate-dependence","lattice-dependence","omega-dependence"];
dependence_marker = ["o", "s", "dia","pent","hex","^"];
colors = spring(4);
TileSpec = {[1:4],[1:3],[1:4],[1:4],[1:4],[1:4]};
TileX = {"{\itd} (nm)" "{\ity} (mm)" "#process" "growth rate (pm pulse^{-1})" "o-o-p lattice constant ("+char(197)+")" "\omega-FWHM (°)"};

for idx_F = 1:numel(dependence_names)
    F(idx_F) = figure("name",dependence(idx_F),"OuterPosition",[100*idx_F 100 400 700]);
    batches = "Cr2O3_"+ ...
        ["CuO_CompVar1", "ZnO_CompVar1", "ZnO_CompVar2", "ZnO_PowerVar1"];
    titles = ["0.01%-CuO","0.01%-ZnO","1%-ZnO","0.01%-ZnO Temp. Var."];
    subs = ["c","r"];
    
    Ids = cell(numel(batches),2);
    X = cell(numel(batches),2);
    Y = cell(numel(batches),2);
    Y_err = cell(numel(batches),2);
    
    
    Tiles = tiledlayout(F(idx_F),numel(TileSpec{idx_F}),2);
    ax = gobjects(numel(batches),2);
    erPlot = gobjects(numel(batches),2);
    scPlot = gobjects(numel(batches),2);
    for i = TileSpec{idx_F}
        for j = 1:2
            if strcmp(batches(i),"Cr2O3_ZnO_PowerVar1")
                Ids{i,j} = searchSamples_v2(...
                        {{'Batch',batches(i);...
                        'Sub',subs(j)+"-Al2O3";...
                        'Hall','y';...
                        'Contacts','TiAlAu'}}...
                    ,true);
            else
                Ids{i,j} = searchSamples_v2(...
                        {{'Batch',batches(i);...
                        'Sub',subs(j)+"-Al2O3";...
                        'Hall','y'}}...
                    ,true);
            end
            batchIds = getFilePathsFromId(cellfun(@(x) string(x),Ids{i,j}.Id),'Hall_RT','.mat');
            for idx_sample = 1:numel(batchIds)
                data = getHallData(batchIds{idx_sample});
                [Y{i,j}(idx_sample),Y_err{i,j}(idx_sample)] = weightedMean([data{1,1}.rho],[data{1,1}.err_rho]);
                    scaling = Ids{i,j}.d(idx_sample)/1000;
                    Y{i,j}(idx_sample) = Y{i,j}(idx_sample)*scaling;
                    Y_err{i,j}(idx_sample) = Y_err{i,j}(idx_sample)*scaling;
                if strcmp(dependence(idx_F),"rate")
                    if idx_sample==1
                        X{i,j} = growthrateFun(Ids{i,j});
                    end
                elseif strcmp(dependence(idx_F),"lattice")
                    if strcmp(Ids{i,j}.ThetaOmega(idx_sample),"a")
                        X{i,j}(idx_sample) = getPeakShift(Ids{i,j}.Id(idx_sample),"lattice",true);
                    else
                        X{i,j}(idx_sample) = nan;
                    end
                elseif strcmp(dependence(idx_F),"rocking")
                    if strcmp(Ids{i,j}.Omega(idx_sample),"a")
                        X{i,j} = getRocking(Ids{i,j}.Id);
                    else
                        X{i,j}(idx_sample) = nan;
                    end
                else
                    X{i,j}(idx_sample) = columnToNumber(Ids{i,j}.(dependence(idx_F))(idx_sample));
                end
                
            end
            ax(i,j) = nexttile(Tiles);
            hold(ax(i,j),"on")
            erPlot(i,j) = errorbar(X{i,j},Y{i,j},Y_err{i,j},"k.","LineStyle","none");
            scPlot(i,j) = scatter(X{i,j},Y{i,j},"k",'markeredgealpha',.5,"MarkerFaceAlpha",.6);
                scPlot(i,j).MarkerFaceColor = colors(i,:);
                scPlot(i,j).Marker = dependence_marker(idx_F);
                scPlot(i,j).SizeData = 60;
            title(ax(i,j),titles(i)+sprintf(strcat('\n',subs(j),'-orientation')),'FontSize',9);
            set(ax(i,j),"YScale",'log')
            grid(ax(i,j),"on")
        end
    end
    linkaxes(ax,'y')
    linkaxes(ax(1:3,1),'x')
    linkaxes(ax(1:3,2),'x')
    if strcmp(dependence(idx_F),"rocking")
        linkaxes(ax)
    end
    xlabel(Tiles,TileX{idx_F},"fontsize",12)
    ylabel(Tiles,"{\it\rho} (\Omegam)","fontsize",12)
    sgtitle(dependence_names(idx_F),"fontsize",12,"fontweight","bold")

    exportgraphics(F(idx_F),"../Plots/Cr2O3/2 Doping/2-rho_vs_"+dependence_names(idx_F)+".pdf")
    exportgraphics(F(idx_F),"../Plots/Cr2O3/2 Doping/2-rho_vs_"+dependence_names(idx_F)+".png","Resolution",250)
end