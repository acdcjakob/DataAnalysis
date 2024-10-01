

sampleName = "W6905m";
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
    contourf(qx,qy,intensity,logspace(0,1,30),"LineStyle","none")
    set(gca,"Colorscale","log")
    hold on
    
end
%%
q_Al2O3_exp_306 = [4.6299 ; 7.2644];
    q_Cr2O3_exp_306 = [4.5432 ; 6.863];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_306(1),q_Cr2O3_exp_306(2),q_Al2O3_lit_306,q_Al2O3_exp_306);
    q_Cr2O3_cor_306 = [x,y];

q_Al2O3_exp_300 = [0.019 ; 7.275];
    q_Cr2O3_exp_300 = [nan ; nan];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_300(1),q_Cr2O3_exp_300(2),q_Al2O3_lit_300,q_Al2O3_exp_300);
    q_Cr2O3_cor_300 = [x,y];

q_Al2O3_exp_30m6 = [-4.5929 ; 7.2889];
    q_Cr2O3_exp_30m6 = [-4.3578 ; 6.9904];
    [x,y] = correctReciprocalData(q_Cr2O3_exp_30m6(1),q_Cr2O3_exp_30m6(2),q_Al2O3_lit_30m6,q_Al2O3_exp_30m6);
    q_Cr2O3_cor_30m6 = [x,y];

slope_film = (q_Cr2O3_cor_30m6(2)-q_Cr2O3_cor_306(2)) / (q_Cr2O3_cor_30m6(1)-q_Cr2O3_cor_306(1));

if exist("LATTICE","var")
    % correction of film tilt
    Psi = -1*(q_Cr2O3_cor_306(2)-q_Cr2O3_cor_30m6(2))/(q_Cr2O3_cor_306(1)-q_Cr2O3_cor_30m6(1));
    OUT = sin(Psi)*q_Cr2O3_cor_306(1)+cos(Psi)*q_Cr2O3_cor_306(2);
    IN = cos(Psi)*q_Cr2O3_cor_306(1)-sin(Psi)*q_Cr2O3_cor_306(2);

    in306 = 6 / IN;%q_Cr2O3_cor_306(1);
    in = in306;
    out306 = sqrt(12) / OUT;%q_Cr2O3_cor_306(2);
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



N = {[1,2,3],[4,5,6],[7,8,9]};
N_plane = {'(30.6)','(30.0)','(30.-6)'};
N_sign = {1 1 -1};
N_ax = {3,2,1};
N_q_Al_lit = {q_Al2O3_lit_306,q_Al2O3_lit_300,q_Al2O3_lit_30m6};
N_q_Al_exp = {q_Al2O3_exp_306,q_Al2O3_exp_300,q_Al2O3_exp_30m6};
N_q_Cr_lit = {getChromiumVector([0 0 6],[3 0 0]),...
    getChromiumVector([0 0 0],[3 0 0]),...
    getChromiumVector([0 0 6],[3 0 0]).*[-1;1]};

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
