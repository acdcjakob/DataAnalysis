% planes = ["c" "r"];
% names = ["TiAlAu";
%     "TiAu";
%     "TiAlAu annealed"];
% 
% contacts = {
%     {'TiAlAu'    'TiAu'      'TiAlAu'}
%     {'TiAlAu'    'TiAu'}
% };
% 
% filter = {
%     { {{'2024-02'}}       {}      {{'Annealed'}} }
%     { {{'2024-02'}}       {}      }
% };
% 
% %
% tileHand = tiledlayout(1,2);
%     makeLatexSize(1,.5,tileHand);
% % init
% axHand = gobjects(2,1);
% for i = 1:2
%     axHand(i) = nexttile(tileHand);
% 
%     for ii = 1:numel(contacts{i})
%         fP = 
%     end
% end

tileHand = tiledlayout(1,2,"TileSpacing","compact","Padding","tight");
    [tileHand,figHand] = makeLatexSize(1,.5,tileHand);
    ylabel(tileHand,"\rho (\Omega cm)")
    xlabel(tileHand,"\Theta_{growth} (°C)")

subs = {"c-Al2O3","r-Al2O3"};
planes = ["c" "r"];
name = ["TiAlAu";"TiAu";"TiAlAu annealed"];


% TiAlAu not annealed
batch = "Cr2O3_ZnO_PowerVar1";

contacts{1}{1} = "TiAlAu";
contacts{2}{1} = "TiAlAu";
filter{1}{1} = {{'2024-02'}}; % has been measured in Feb 2024
filter{2}{1} = {{'2024-02'}};

% TiAu not annealed
contacts{1}{2} = "TiAu";
contacts{2}{2} = "TiAu";
filter{1}{2} = {};
filter{2}{2} = {};

% TiAlAu annealed
contacts{1}{3} = "TiAlAu";
filter{1}{3} = {{"Annealed"}};



for i = 1:numel(subs)
    % ax(i) = axes(figHand,"OuterPosition",[-0.5+i*0.5 0 0.5 1]);
    ax(i) = nexttile(tileHand);
        hold(ax(i),"on")
        set(ax(i),"YScale","log")
        grid(ax(i),"on")
        L(i) = legend(ax(i));
            % set(L(i).Title,"String",subs{i})
            title(planes(i)+"-plane")
        formatAxes(ax(i));
    for j = 1:numel(contacts{i})
        Ids{i,j} = searchSamples_v2({{...
            'Batch',batch; ...
            'Sub',subs{i}; ...
            'Contacts',contacts{i}{j}...
           }});
        IdInfos{i,j} = searchSamples_v2({{...
            'Batch',batch; ...
            'Sub',subs{i}; ...
            'Contacts',contacts{i}{j}...
           }},true);

        allFiles = getFilePathsFromId(Ids{i,j},"Hall_RT",".mat");
        for idx_sample = 1:numel(allFiles)
            file{i}{j}(idx_sample) = filterFileName(filter{i}{j},allFiles{idx_sample});
            data = getHallData(file{i}{j}(idx_sample));
            [Y{i,j}(idx_sample),Y_err{i,j}(idx_sample)] = weightedMean([data{1,1}.rho],[data{1,1}.err_rho]);
            scaling = IdInfos{i,j}.d(idx_sample)/1000;
            Y{i,j}(idx_sample) = Y{i,j}(idx_sample)*scaling;
            Y_err{i,j}(idx_sample) = Y_err{i,j}(idx_sample)*scaling;

            X{i,j}(idx_sample) = columnToNumber(IdInfos{i,j}.NameValAlt(idx_sample));
        end
        E(i,j) = errorbar(...
            ax(i),X{i,j},Y{i,j}*100,Y_err{i,j}*100,... % Ohm cm
            "LineStyle",":");
        E(i,j).HandleVisibility = "off";
        linePainter(transpose(E),"prio",0)

        S(i,j) = scatter(ax(i),X{i,j},Y{i,j}*100); % Ohm cm
        S(i,j).DisplayName = name(j);
        linePainter(transpose(S),"Marker",50,"prio",0)
        S(i,j).MarkerFaceColor = S(i,j).MarkerEdgeColor;
        S(i,j).MarkerFaceAlpha = .5;
    end
end
linkaxes(ax)

set(figHand,"Renderer","painters")
exportgraphics(figHand,"../Plots/Thesis/2/2_doped_contacts.eps")