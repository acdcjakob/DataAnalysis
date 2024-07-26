sampleName = "W6725";
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
q_Al2O3_exp_4m20 = [4.2119 ; 7.2674];
    q_Cr2O3_exp_4m20 = [4.0609 ; 6.9227];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_4m20(1),q_Cr2O3_exp_4m20(2),q_Al2O3_lit_4m20,q_Al2O3_exp_4m20);
    q_Cr2O3_cor_4m20 = [x,y];

q_Al2O3_exp_300 = [0.0131 ; 7.2751];
    q_Cr2O3_exp_300 = [0.0083 ; 6.9192];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
    q_Cr2O3_cor_300 = [x,y];

q_Al2O3_exp_220 = [-4.1870 ; 7.2818];
    q_Cr2O3_exp_220 = [-4.0364 ; 6.9324];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_220(1),q_Cr2O3_exp_220(2),q_Al2O3_lit_220,q_Al2O3_exp_220);
    q_Cr2O3_cor_220 = [x,y];

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