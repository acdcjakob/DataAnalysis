sampleName = "W6716";
planeName = "220";
fileName = strcat('RSM_data_',sampleName,'_',planeName,'.mat');


%% reference sapphire data

% 4-20
q_Al2O3_lit_4m20 = getSapphireVector([1 -2 0],[3 0 0]);

% 220
q_Al2O3_lit_220 = getSapphireVector([-1 2 0],[3 0 0]) ...
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
q_Al2O3_exp_4m20 = [4.1985 ; 7.2662];
    q_Cr2O3_exp_4m20 = [4.0402 ; 6.9438];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_4m20(1),q_Cr2O3_exp_4m20(2),q_Al2O3_lit_4m20,q_Al2O3_exp_4m20);
    q_Cr2O3_cor_4m20 = [x,y];
    a_in = 2./x;
    a_out = sqrt(12)/y; 
q_Al2O3_exp_300 = [0.0107 ; 7.2760];
    q_Cr2O3_exp_300 = [nan ; nan];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
    q_Cr2O3_cor_300 = [x,y]; clear x y

q_Al2O3_exp_220 = [-4.1863 ; 7.2832];
    q_Cr2O3_exp_220 = [-4.0388 ; 6.9555];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_220(1),q_Cr2O3_exp_220(2),q_Al2O3_lit_220,q_Al2O3_exp_220);
    q_Cr2O3_cor_220 = [x,y];
    a_in = 2./x;
    a_out = sqrt(12)/y;

if exist("LATTICE","var")
    in4m20 = 2 / q_Cr2O3_cor_4m20(1);
    in = in4m20;
    out4m20 = sqrt(12) / q_Cr2O3_cor_4m20(2);
    out = out4m20;
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



N = {[3],[2],[1]};
N_plane = {'(4-2.0)','(30.0)','(22.0)'};
N_sign = {1 1 1};
N_ax = {3,2,1};
N_q_Al_lit = {q_Al2O3_lit_4m20,q_Al2O3_lit_300,q_Al2O3_lit_220};
N_q_Al_exp = {q_Al2O3_exp_4m20,q_Al2O3_exp_300,q_Al2O3_exp_220};
N_q_Cr_lit = {getChromiumVector([1 -2 0],[3 0 0]),...
    getChromiumVector([0 0 0],[3 0 0]),...
    getChromiumVector([-1 2 0],[3 0 0]).*[-1;1]};

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

    slope_sub = (q_Al2O3_lit_220(2)-q_Al2O3_lit_4m20(2)) / (q_Al2O3_lit_220(1)-q_Al2O3_lit_4m20(1));
    line_sub = plot(thisAx,[q_Al2O3_lit_220(1) q_Al2O3_lit_4m20(1)],[q_Al2O3_lit_220(2) q_Al2O3_lit_4m20(2)]);
    line_sub.DisplayName = sprintf("Substrate alignment\n"+num2str(slope_sub,'%.3e'));
    line_sub.Color = "r";
    line_sub.LineWidth = .6;
    line_sub.HandleVisibility = "off";

    slope_film = (q_Cr2O3_cor_220(2)-q_Cr2O3_cor_4m20(2)) / (q_Cr2O3_cor_220(1)-q_Cr2O3_cor_4m20(1));
    line_film = plot(thisAx,[q_Cr2O3_cor_220(1) q_Cr2O3_cor_4m20(1)],[q_Cr2O3_cor_220(2) q_Cr2O3_cor_4m20(2)]);
    line_film.DisplayName = sprintf("Film tilt\n"+num2str(atan(slope_film)*180/pi*60,'%.2f')+"'");
    line_film.Color = "m";
    line_film.LineWidth = 1;
    line_film.HandleVisibility = "on";

    line_film_ref = plot(thisAx,[-1*q_Cr2O3_cor_4m20(1) q_Cr2O3_cor_4m20(1)],[q_Cr2O3_cor_4m20(2) q_Cr2O3_cor_4m20(2)]);
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sampleName = "W6716";
% planeName = "220";
% fileName = strcat('RSM_data_',sampleName,'_',planeName,'.mat');
% 
% 
% %% reference sapphire data
% 
% % 4-20
% q_Al2O3_lit_4m20 = getSapphireVector([1 -2 0],[3 0 0]);
% 
% % 220
% q_Al2O3_lit_220 = getSapphireVector([-1 2 0],[3 0 0]) ...
%     .* [-1;1];
% 
% % 300
% q_Al2O3_lit_300 = getSapphireVector([0 0 0],[3 0 0]);
% 
% %% plot for determining the experimental peak
% % set true for initial peak aquisition
% clear q_perp q_parallel data
% for n = []
%     load(fileName)
% 
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     intensity = data{n};
%     contourf(qx,qy,intensity,logspace(0,1.65,30),"LineStyle","none")
%     hold on
% 
% end
% %%
% q_Al2O3_exp_4m20 = [4.1985 ; 7.2662];
%     q_Cr2O3_exp_4m20 = [4.0402 ; 6.9438];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_4m20(1),q_Cr2O3_exp_4m20(2),q_Al2O3_lit_4m20,q_Al2O3_exp_4m20);
%     q_Cr2O3_cor_4m20 = [x,y];
%     a_in = 2./x;
%     a_out = sqrt(12)/y; 
% q_Al2O3_exp_300 = [0.0107 ; 7.2760];
%     q_Cr2O3_exp_300 = [nan ; nan];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
%     q_Cr2O3_cor_300 = [x,y]; clear x y
% 
% q_Al2O3_exp_220 = [-4.1863 ; 7.2832];
%     q_Cr2O3_exp_220 = [-4.0388 ; 6.9555];
%     [x,y] = correctReciprocalData(q_Cr2O3_exp_220(1),q_Cr2O3_exp_220(2),q_Al2O3_lit_220,q_Al2O3_exp_220);
%     q_Cr2O3_cor_220 = [x,y];
%     a_in = 2./x;
%     a_out = sqrt(12)/y;
% 
% slope_film = (q_Cr2O3_cor_220(2)-q_Cr2O3_cor_4m20(2)) / (q_Cr2O3_cor_220(1)-q_Cr2O3_cor_4m20(1));
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
%     int_max = 2.2;
%         % corresponds to 10^int_max
%     int_low = -1;
% 
%     Msize = 12;
%     Medge = "k";
% 
% 
% % 4-20
% disp("plot (4-2.0)...")
% thisAx = Ax(3);
% hold(thisAx,"on");
% for n = 3
%     disp(n)
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,q_Al2O3_lit_4m20,q_Al2O3_exp_4m20);
%     I = data{n};
% 
%     [~,h] = contourf(thisAx,qx_cor,qy_cor,I,logspace(int_low,int_max,20),...
%         "LineStyle","none");
%     % ----
%     h.HandleVisibility = "off";
% end
% titleString = ...
%     "\rho = "+num2str(parameters(1),'%.3f')+"; \gamma = "+num2str(parameters(2),'%.2e')...
%     +sprintf("\n(4-2.0)-plane");
% t(3) = title(thisAx,titleString);
% og = plot(thisAx,q_Al2O3_exp_4m20(1),q_Al2O3_exp_4m20(2),"s","MarkerSize",Msize,"MarkerEdgeColor",Medge,"MarkerFaceColor","none");
% og.DisplayName = "og substrate peak";
% 
% 
% % 300
% disp("plot (30.0)...")
% thisAx = Ax(2);
% hold(thisAx,"on")
% for n = 2
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
% disp("plot (22.0)...")
% thisAx = Ax(1);
% hold(thisAx,"on")
% for n = 1
%     disp(n)
%     qx = q_perp{n};
%     qy = q_parallel{n};
%     [qx_cor,qy_cor,parameters] = correctReciprocalData(qx,qy,q_Al2O3_lit_220,q_Al2O3_exp_220);
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
%     +sprintf("\n(22.0)-plane");
% t(3) = title(thisAx,titleString);
% og = plot(thisAx,q_Al2O3_exp_220(1),q_Al2O3_exp_220(2),"s","MarkerSize",Msize,"MarkerEdgeColor",Medge,"MarkerFaceColor","none");
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
%     slope_sub = (q_Al2O3_lit_220(2)-q_Al2O3_lit_4m20(2)) / (q_Al2O3_lit_220(1)-q_Al2O3_lit_4m20(1));
%     line_sub = plot(Ax(a),[q_Al2O3_lit_220(1) q_Al2O3_lit_4m20(1)],[q_Al2O3_lit_220(2) q_Al2O3_lit_4m20(2)]);
%     line_sub.DisplayName = sprintf("Substrate alignment\n"+num2str(slope_sub,'%.3e'));
%     line_sub.Color = "r";
%     line_sub.LineWidth = .6;
%     line_sub.HandleVisibility = "off";
% 
%     slope_film = (q_Cr2O3_cor_220(2)-q_Cr2O3_cor_4m20(2)) / (q_Cr2O3_cor_220(1)-q_Cr2O3_cor_4m20(1));
%     line_film = plot(Ax(a),[q_Cr2O3_cor_220(1) q_Cr2O3_cor_4m20(1)],[q_Cr2O3_cor_220(2) q_Cr2O3_cor_4m20(2)]);
%     line_film.DisplayName = sprintf("Film alignment\n"+num2str(slope_film,'%.3e'));
%     line_film.Color = "m";
%     line_film.LineWidth = 1;
% 
%     line_film_ref = plot(Ax(a),[-1*q_Cr2O3_cor_4m20(1) q_Cr2O3_cor_4m20(1)],[q_Cr2O3_cor_4m20(2) q_Cr2O3_cor_4m20(2)]);
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
% 
% if ~exist("NOEXPORT","var")
%     % ---every data
%     legend(ax2,"off")
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_220_300_4m20-total.png"),"Resolution",250);
% 
% 
%     % --- only substrate
%     xlim(ax1,[-4.25 -4.15])
%     ylim(ax1,[7.2 7.35]);
% 
%     xlim(ax2,[-.02 .02]);
% 
%     xlim(ax3,[4.15 4.25]);
% 
%     legend(ax1,"off")
%     legend(ax2)
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_220_300_4m20-onlySub.png"),"Resolution",250);
% 
%     % --- only film
%     xlim(ax1,[-4.1 -3.95]);
%     ylim(ax1,[6.9 7.025]);
% 
%     xlim(ax2,[-.1 .1]);
% 
%     xlim(ax3,[3.95 4.15]);
% 
%     legend(ax2,"off")
%     legend(ax1,"Location","south")
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_220_300_4m20-onlyFilm.png"),"Resolution",250);
% 
%     % --- both peaks full
%     xlim(ax1,[-4.25 -3.95]);
%     ylim(ax1,[6.9 7.35]);
% 
%     xlim(ax2,[-.1 .1])
% 
%     xlim(ax3,[3.95 4.25])
% 
%     legend(ax1,"Location","east")
%     disp("Exporting...")
%     exportgraphics(gcf,strcat("../Plots/RSM/",sampleName,"_220_300_4m20-bothPeaks.png"),"Resolution",250);
% end
