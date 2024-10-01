subs = ["m-Al2O3","a-Al2O3"];

ax = axes();
    hold(ax,"on");
    legend(ax,"location","north");
    grid(ax,"on");
    yscale(ax,"log")
    xlabel(ax,"{\itd} (nm)")
    ylabel(ax,"{\it\rho} (\Omegam)")
C = spring(3);

for i_sub = [1,2]
    Ids = searchSamples_v2({{'Batch','Cr2O3_ZnO_CompVar2';...
        'Hall','y'; ...
        'Sub',subs(i_sub)}},true);
    files = getFilePathsFromId(cellfun(@(x) string(x),Ids.Id),'Hall_RT','.mat');
    
    for i = 1:numel(files)
        data{i} = getHallData(files{i});
        
        [Y(i) Y_err(i)] = weightedMean([data{i}{1}.rho],[data{i}{1}.err_rho]);
        Y(i) = Y(i) * Ids.d(i)/1000;
        Y_err(i) = Y_err(i) * Ids.d(i)/1000;
        X(i) = Ids.d(i);

        y{i} = [data{i}{1}.rho]* Ids.d(i)/1000;
        y_err{i} = [data{i}{1}.err_rho]* Ids.d(i)/1000;
        x{i}= repmat(Ids.d(i),[1,numel(y{i})]);
        Ref(i_sub) = errorbar(x{i},y{i},y_err{i},...
            "LineStyle","none",...
            "Marker","x",...
            "LineWidth",.2,...
            "Color",C(i_sub,:),...
            "HandleVisibility","off");
            
    end
    
    
    E(i_sub) = errorbar(X,Y,Y_err,"LineStyle","none");
        E(i_sub).Color = C(i_sub,:);
        E(i_sub).HandleVisibility = "off";
    S(i_sub) = scatter(X,Y);
        S(i_sub).MarkerFaceColor = C(i_sub,:);
        S(i_sub).MarkerFaceAlpha = .7;
        S(i_sub).MarkerEdgeColor = C(i_sub,:)*0.5;
        S(i_sub).DisplayName = subs(i_sub);
    
end

exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-nonConductive_rho.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-nonConductive_rho.png","Resolution",250)