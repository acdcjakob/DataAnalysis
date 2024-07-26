sampleName = "W6715";
planeName = "306";
fileName = strcat('RSM_data_',sampleName,'_',planeName,'.mat');


%% reference sapphire data

% 306
q_Al2O3_lit_306 = getSapphireVector([0 0 6],[3 0 0]);

% 30-6
q_Al2O3_lit_30m6 = getSapphireVector([0 0 6],[3 0 0]) ...
    .* [-1;1];

% 300
q_Al2O3_lit_300 = getSapphireVector([0 0 0],[3 0 0]);

%% plot for determining the experimental peak
% set true for initial peak aquisition
clear q_perp q_parallel data
for n = []
    load(fileName)
    
    qx = q_perp{n};
    qy = q_parallel{n};
    intensity = data{n};
    contourf(qx,qy,intensity,logspace(0,2,30),"LineStyle","none")
    set(gca,"Colorscale","log")
    hold on
    
end
%%
q_Al2O3_exp_306 = [4.5882 ; 7.2929];
    q_Cr2O3_exp_306 = [4.3830 ; 6.9800];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_306(1),q_Cr2O3_exp_306(2),q_Al2O3_lit_306,q_Al2O3_exp_306);
    q_Cr2O3_cor_306 = [x,y];
    
q_Al2O3_exp_300 = [0.0270 ; 7.2686];
    q_Cr2O3_exp_300 = [0.0896 ; 6.9181];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
    q_Cr2O3_cor_300 = [x,y];

q_Al2O3_exp_30m6 = [-4.6333 ; 7.2534];
    q_Cr2O3_exp_30m6 = [-4.5315 ; 6.8571];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_30m6(1),q_Cr2O3_exp_30m6(2),q_Al2O3_lit_30m6,q_Al2O3_exp_30m6);
    q_Cr2O3_cor_30m6 = [x,y];

if exist("LATTICE","var")
    % correction of film tilt
    Psi = -1*(q_Cr2O3_cor_306(2)-q_Cr2O3_cor_30m6(2))/(q_Cr2O3_cor_306(1)-q_Cr2O3_cor_30m6(1));
    OUT = sin(Psi)*q_Cr2O3_cor_306(1)+cos(Psi)*q_Cr2O3_cor_306(2);
    IN = cos(Psi)*q_Cr2O3_cor_306(1)-sin(Psi)*q_Cr2O3_cor_306(2);

    in306 = 6 / IN;%q_Cr2O3_cor_306(1);
    in = in306;
    out306 = sqrt(12) / OUT;%q_Cr2O3_cor_30m6(2);
    out = out306;
    return
end
%% Main Plot section

load(fileName)
if ~exist("CHILD","var")
    figure("OuterPosition",[100 100 800 500],"Name","Overview")
    ax1 = axes("OuterPosition",[0 .05 1/3 .75]);
    ax2 = axes("OuterPosition",[1/3 .05 1/3 .75]);
    ax3 = axes("OuterPosition",[2/3 .05 1/3 .75]);
    Ax = [ax1,ax2,ax3];
end
% Plot-Specs
    int_max = 2;
        % corresponds to 10^int_max
    int_low = -1;



N = {[7,8,9],[4,5,6],[1,2,3]};
N_plane = {'(30.6)','(30.0)','(30.-6)'};
N_sign = {-1 1 -1};
N_ax = {3,2,1};
N_q_Al_lit = {q_Al2O3_lit_306,q_Al2O3_lit_300,q_Al2O3_lit_30m6};
N_q_Al_exp = {q_Al2O3_exp_306,q_Al2O3_exp_300,q_Al2O3_exp_30m6};
N_q_Cr_lit = {getChromiumVector([0 0 6],[3 0 0]),...
    getChromiumVector([0 0 0],[3 0 0]),...
    getChromiumVector([0 0 -6],[3 0 0]).*[-1;1]};

for i = 1:3
    % plane
    disp(N_plane{i}+"plot...")
    thisAx = Ax(N_ax{i});
    hold(thisAx,"on")

    for n = N{i}
        disp(n)
        qx = N_sign{i}*q_perp{n};
        qy = q_parallel{n};
        [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,N_q_Al_lit{i},N_q_Al_exp{i});
        I = data{n};
        [~,h] = contourf(thisAx,qx_cor,qy_cor,I,logspace(int_low,int_max,20));
            h.LineStyle = "none";
            h.HandleVisibility = "off";
    end

    titleString = (N_plane{i}+"-plane");
    t(N_ax{i}) = title(thisAx,titleString);
    og = plot(thisAx,N_q_Al_exp{i}(1),N_q_Al_exp{i}(2),"x",...
        "MarkerSize",12,...
        "MarkerEdgeColor","w");
    og.DisplayName = "og substrate peak";
    og.HandleVisibility = "off"; % comment out for legend entry
    % legend(thisAx)

    sollFilm = scatter(thisAx,N_q_Cr_lit{i}(1),N_q_Cr_lit{i}(2),"k",...
        "Sizedata",50,...
        "LineWidth",1,...
        "Marker","+",...
        "MarkerEdgeColor","m",...
        "MarkerFaceAlpha",.6);
    sollFilm.HandleVisibility = "off"; % comment out for legend entry
    % legend(thisAx)
    
    drawnow
    thisAx.LineWidth = .8;
    thisAx.XLabel.String = "q_{||} (nm^{-1})";
    thisAx.YLabel.String = "q_\perp (nm^{-1})";
    thisAx.XLimMode = "manual";
    thisAx.ColorScale = "log";
    thisAx.Box = "on";

    slope_sub = (q_Al2O3_lit_30m6(2)-q_Al2O3_lit_306(2)) / (q_Al2O3_lit_30m6(1)-q_Al2O3_lit_306(1));
    line_sub = plot(thisAx,[q_Al2O3_lit_30m6(1) q_Al2O3_lit_306(1)],[q_Al2O3_lit_30m6(2) q_Al2O3_lit_306(2)]);
    line_sub.DisplayName = sprintf("Substrate alignment\n"+num2str(slope_sub,'%.3e'));
    line_sub.Color = "r";
    line_sub.LineWidth = .6;
    line_sub.HandleVisibility = "off";

    slope_film = (q_Cr2O3_cor_30m6(2)-q_Cr2O3_cor_306(2)) / (q_Cr2O3_cor_30m6(1)-q_Cr2O3_cor_306(1));
    line_film = plot(thisAx,[q_Cr2O3_cor_30m6(1) q_Cr2O3_cor_306(1)],[q_Cr2O3_cor_30m6(2) q_Cr2O3_cor_306(2)]);
    line_film.DisplayName = sprintf("Film tilt\n"+num2str(atan(slope_film)*180/pi*60,'%.2f')+"'");
    line_film.Color = "m";
    line_film.LineWidth = 1;
    line_film.HandleVisibility = "on";

    line_film_ref = plot(thisAx,[-1*q_Cr2O3_cor_306(1) q_Cr2O3_cor_306(1)],[q_Cr2O3_cor_306(2) q_Cr2O3_cor_306(2)]);
    line_film_ref.HandleVisibility = "off";
    line_film_ref.Color = line_film.Color;
    line_film_ref.LineStyle = "-.";
    line_film_ref.LineWidth = 1.5;
    line_film_ref.Color = "m";

    if N_ax{i} == 2 | N_ax{i} == 3
        line_sub.HandleVisibility = "off";
        line_film.HandleVisibility = "off";
    end
end

linkaxes(Ax([1,2,3]),'y');

if ~exist("CHILD","var")
    sgtitle(sampleName)
end
% 
% %% ZOOM stages
% % set(gcf,'renderer','Painters');
% % this crashes everything, mayber too complex to render
% % if ~exist("NOEXPORT","var")
% %     % ---every data
% %     legend(ax2,"off")
% %     disp("Exporting...")
% %     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"/",sampleName,"_22m6_220_226-total.png"),"Resolution",250);
% % 
% % 
% %     % % --- only substrate
% %     % xlim(ax1,[-4.67 -4.57])
% %     % ylim(ax1,[7.2 7.35]);
% %     % 
% %     % xlim(ax2,[-.02 .02]);
% %     % 
% %     % xlim(ax3,[4.57 4.67]);
% %     % 
% %     % legend(ax1,"off")
% %     % disp("Exporting...")
% %     % exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"/",sampleName,"_22m6_220_226-onlySub.png"),"Resolution",250);
% %     % 
% %     % % --- only film
% %     % xlim(ax1,[-4.7 -4.4]);
% %     % ylim(ax1,[6.8 7.2]);
% %     % 
% %     % xlim(ax2,[-.2 .2]);
% %     % 
% %     % xlim(ax3,[4.3 4.6]);
% %     % 
% %     % legend(ax2,"off")
% %     % legend(ax1)
% %     % disp("Exporting...")
% %     % exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"/",sampleName,"_22m6_220_226-onlyFilm.png")"),"Resolution",250);
% %     % 
% %     % % --- both peaks full
% %     % xlim(ax1,[-4.8 -4.2]);
% %     % ylim(ax1,[6.8 7.4]);
% %     % 
% %     % xlim(ax2,[-.1 .1])
% %     % 
% %     % xlim(ax3,[4.2 4.8])
% %     % 
% %     % legend(ax1,"Location","east")
% %     % disp("Exporting...")
% %     % exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"/",sampleName,"_22m6_220_226-bothPeaks.png"),"Resolution",250);
% % end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sampleName = "W6715";
% planeName = "306";
% fileName = strcat('RSM_data_',sampleName,'_',planeName,'.mat');
% 
% 
% %% reference sapphire data
% 
% % 306
% q_Al2O3_lit_306 = getSapphireVector([0 0 6],[3 0 0]);
% 
% % 30-6
% q_Al2O3_lit_30m6 = getSapphireVector([0 0 -6],[3 0 0]) ...
%     .* [-1;1];
% 
% % 300
% q_Al2O3_lit_300 = getSapphireVector([0 0 0],[3 0 0]);
% 
% %% plot for determining the experimental peak
% % set true for initial peak aquisition
% clear q_perp q_parallel data
% for n = [1]
%     load(fileName)
% 
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     intensity = data{n};
%     contourf(qx,qy,intensity,logspace(0,1,30),"LineStyle","none")
%     hold on
% 
% end
% %%
% q_Al2O3_exp_306 = [4.6333 ; 7.2534];
%     q_Cr2O3_exp_306 = [4.5315 ; 6.8571];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_306(1),q_Cr2O3_exp_306(2),q_Al2O3_lit_306,q_Al2O3_exp_306);
%     q_Cr2O3_cor_306 = [x,y];
% q_Al2O3_exp_300 = [0.0270 ; 7.2686];
%     q_Cr2O3_exp_300 = [0.0896 ; 6.9181];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
%     q_Cr2O3_cor_300 = [x,y];
% 
% q_Al2O3_exp_30m6 = [-4.5882 ; 7.2929];
%     q_Cr2O3_exp_30m6 = [-4.3830 ; 6.9800];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_30m6(1),q_Cr2O3_exp_30m6(2),q_Al2O3_lit_30m6,q_Al2O3_exp_30m6);
%     q_Cr2O3_cor_30m6 = [x,y];
% 
% slope_film = (q_Cr2O3_cor_30m6(2)-q_Cr2O3_cor_306(2)) / (q_Cr2O3_cor_30m6(1)-q_Cr2O3_cor_306(1));
% %% Main Plot section
% 
% load(fileName)
% if ~exist("CHILD","var")
%     figure("OuterPosition",[100 100 800 500],"Name","Overview")
%     ax1 = axes("OuterPosition",[0 .05 1/3 .75]);
%     ax2 = axes("OuterPosition",[1/3 .05 1/3 .75]);
%     ax3 = axes("OuterPosition",[2/3 .05 1/3 .75]);
%     Ax = [ax1,ax2,ax3];
% end
% % Plot-Specs
%     % int_max = 4.5;
%     int_max = 2;
%         % corresponds to 10^int_max
%     int_low = -1;
% 
%     Msize = 12;
%     Medge = "k";
% 
% 
% % 306
% disp("plot (30.6)...")
% thisAx = Ax(3);
% hold(thisAx,"on");
% for n = [1,2,3]
%     disp(n)
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,q_Al2O3_lit_306,q_Al2O3_exp_306);
%     I = data{n};
% 
%     [~,h] = contourf(thisAx,qx_cor,qy_cor,I,logspace(int_low,int_max,20),...
%         "LineStyle","none");
%     % ----
%     h.HandleVisibility = "off";
% end
% titleString = ...
%     "\rho = "+num2str(parameters(1),'%.3f')+"; \gamma = "+num2str(parameters(2),'%.2e')...
%     +sprintf("\n(30.6)-plane");
% t(3) = title(thisAx,titleString);
% og = plot(thisAx,q_Al2O3_exp_306(1),q_Al2O3_exp_306(2),"s","MarkerSize",Msize,"MarkerEdgeColor",Medge,"MarkerFaceColor","none");
% og.DisplayName = "og substrate peak";
% 
% 
% % 300
% disp("plot (30.0)...")
% thisAx = Ax(2);
% hold(thisAx,"on")
% for n = [4,5,6]
%     disp(n)
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,q_Al2O3_lit_300,q_Al2O3_exp_300);
%     I = data{n};
% 
%     [~,h] = contourf(thisAx,qx_cor,qy_cor,I,logspace(int_low,int_max,20),...
%         "LineStyle","none");
%     hold on
%     % ----
%     h.HandleVisibility = "off";
% end
% titleString = ...
%     "\rho = "+num2str(parameters(1),'%.3f')+"; \gamma = "+num2str(parameters(2),'%.2e')...
%     +sprintf("\n(30.0)-plane");
% t(2) = title(thisAx,titleString);
% og = plot(thisAx,q_Al2O3_exp_300(1),q_Al2O3_exp_300(2),"s","MarkerSize",Msize,"MarkerEdgeColor",Medge,"MarkerFaceColor","none");
% og.DisplayName = "og substrate peak";
% legend(thisAx)
% 
% % 30m6
% disp("plot (30.-6)...")
% thisAx = Ax(1);
% hold(thisAx,"on")
% for n = [7,8,9]
%     disp(n)
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,q_Al2O3_lit_30m6,q_Al2O3_exp_30m6);
%     I = data{n};
% 
%     [~,h] = contourf(thisAx,qx_cor,qy_cor,I,logspace(int_low,int_max,20),...
%         "LineStyle","none");
%     hold on
%     % ----
%     h.HandleVisibility = "off";
% end
% titleString = ...
%     "\rho = "+num2str(parameters(1),'%.3f')+"; \gamma = "+num2str(parameters(2),'%.2e')...
%     +sprintf("\n(30.-6)-plane");
% t(3) = title(thisAx,titleString);
% og = plot(thisAx,q_Al2O3_exp_30m6(1),q_Al2O3_exp_30m6(2),"s","MarkerSize",Msize,"MarkerEdgeColor",Medge,"MarkerFaceColor","none");
% og.DisplayName = "og substrate peak";
% legend(thisAx)
% 
% 
% linkaxes(Ax,'y');
% 
% if ~exist("CHILD","var")
%     tAll = annotation("textbox");
%         tAll.Position = [.5 .9 0 0];
%         tAll.String = sampleName;
%         tAll.FitBoxToText = "on";
%         tAll.FontWeight = "bold";
%         tAll.HorizontalAlignment = "center";
%         tAll.EdgeColor = "none";
% end
% %% Overview lines
% disp("plot Lines...")
% for a = 1:3
%     Ax(a).LineWidth = .8;
%     Ax(a).XLabel.String = "q_{||} (nm^{-1})";
%     Ax(a).YLabel.String = "q_\perp (nm^{-1})";
%     Ax(a).XLimMode = "manual";
%     Ax(a).ColorScale = "log";
%     slope_sub = (q_Al2O3_lit_30m6(2)-q_Al2O3_lit_306(2)) / (q_Al2O3_lit_30m6(1)-q_Al2O3_lit_306(1));
%     line_sub = plot(Ax(a),[q_Al2O3_lit_30m6(1) q_Al2O3_lit_306(1)],[q_Al2O3_lit_30m6(2) q_Al2O3_lit_306(2)]);
%     line_sub.DisplayName = sprintf("Substrate alignment\n"+num2str(slope_sub,'%.3e'));
%     line_sub.Color = "r";
%     line_sub.LineWidth = .6;
%     line_sub.HandleVisibility = "off";
% 
%     slope_film = (q_Cr2O3_cor_30m6(2)-q_Cr2O3_cor_306(2)) / (q_Cr2O3_cor_30m6(1)-q_Cr2O3_cor_306(1));
%     line_film = plot(Ax(a),[q_Cr2O3_cor_30m6(1) q_Cr2O3_cor_306(1)],[q_Cr2O3_cor_30m6(2) q_Cr2O3_cor_306(2)]);
%     line_film.DisplayName = sprintf("Film alignment\n"+num2str(slope_film,'%.3e'));
%     line_film.Color = "m";
%     line_film.LineWidth = 1;
% 
%     line_film_ref = plot(Ax(a),[-1*q_Cr2O3_cor_306(1) q_Cr2O3_cor_306(1)],[q_Cr2O3_cor_306(2) q_Cr2O3_cor_306(2)]);
%     line_film_ref.HandleVisibility = "off";
%     line_film_ref.Color = line_film.Color;
%     line_film_ref.LineStyle = "--";
% 
%     if a == 2 | a == 3
%         line_sub.HandleVisibility = "off";
%         line_film.HandleVisibility = "off";
%     end
% end
% 
% %% ZOOM stages
% % set(gcf,'renderer','Painters');
% % this crashes everything, mayber too complex to render
% if ~exist("NOEXPORT","var")
%     % ---every data
%     % exportgraphics(gcf,"../Plots/RSM/W6723_30m6_300_306-total.pdf");
%     legend(ax2,"off")
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_30m6_300_306-total.png"),"Resolution",250);
% 
% 
%     % --- only substrate
%     xlim(ax1,[-4.67 -4.57])
%     ylim(ax1,[7.2 7.35]);
% 
%     xlim(ax2,[-.02 .02]);
% 
%     xlim(ax3,[4.57 4.67]);
% 
%     legend(ax1,"off")
%     % exportgraphics(gcf,"../Plots/RSM/W6723_30m6_300_306-onlySub.pdf");
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_30m6_300_306-onlySub.png"),"Resolution",250);
% 
%     % --- only film
%     xlim(ax1,[-4.7 -4.4]);
%     ylim(ax1,[6.8 7.2]);
% 
%     xlim(ax2,[-.2 .2]);
% 
%     xlim(ax3,[4.3 4.6]);
% 
%     legend(ax2,"off")
%     legend(ax1)
%     % exportgraphics(gcf,"../Plots/RSM/W6723_30m6_300_306-onlyFilm.pdf");
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_30m6_300_306-onlyFilm.png"),"Resolution",250);
% 
%     % --- both peaks full
%     xlim(ax1,[-4.8 -4.2]);
%     ylim(ax1,[6.8 7.4]);
% 
%     xlim(ax2,[-.1 .1])
% 
%     xlim(ax3,[4.2 4.8])
% 
%     legend(ax1,"Location","east")
%     % exportgraphics(gcf,"../Plots/RSM/W6723_30m6_300_306-bothPeaks.pdf");
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_30m6_300_306-bothPeaks.png"),"Resolution",250);
% end
