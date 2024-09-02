% CALCULATION OF LATTICE CONSTANTS
%
% - correctReciprocalData rotates the RSM on the literature value for the
% substrate peak
%
% (100) oriented
%
%

a = 0.808; % in nm, (MgAl2O4)

F = figure("OuterPosition",[100 100 1200 700]);
%% 400 plane on (100)
% plotRSM("W6847","all",[1],6);

% -------------------------- CALCULATION -----------------------------
q_sub_exp = [-0.0311 ; 4.9421];
q_film_exp = [-0.0305 ; 4.7828];

% in-plane component = 0
% o-o-p component = 400
q_sub_lit = getCubicVector([0 0 0],[4 0 0],a);

% correct the data
[x,y,p] = correctReciprocalData(q_film_exp(1),q_film_exp(2),q_sub_lit,q_sub_exp);
a_100_400 = 4/y;
% --------------------------------------------------------------------


% plotting
subplot(2,2,1);
fileName = strcat('RSM_data_W6847_all','.mat');
    load(fileName)
    
    qx = q_perp{1};
    qy = q_parallel{1};
    intensity = data{1};
    [qx,qy,p] = correctReciprocalData(qx,qy,q_sub_lit,q_sub_exp);
    [~,h] = contourf(qx,qy,intensity,logspace(1,5,30),"LineStyle","none");
    h.HandleVisibility = "off";
    set(gca,"Colorscale","log")
    title("400 on (100) corrected")
    xlabel("q_{||} (nm^{-1})")
    ylabel("q_\perp (nm^{-1})")
    hold on
    xline(x,DisplayName="a_{||} = "+num2str(nan,"%.2s")+" nm")
    yline(y,DisplayName="a_\perp = "+num2str(a_100_400,"%.3f")+" nm")
    axis([-0.0158    0.0225    4.6738    5.0912])
    legend
    colorbar
    
%% 511 plane on (100)
% plotRSM("W6847","all",[2],5);

% -------------------------- CALCULATION -----------------------------
q_sub_exp = [1.7573 ; 6.1732];
q_film_exp = [1.7581 ; 5.9776];

% in-plane component = 011
% o-o-p component = 500
q_sub_lit = getCubicVector([0 1 1],[5 0 0],a);

% correct the data
[x,y,p] = correctReciprocalData(q_film_exp(1),q_film_exp(2),q_sub_lit,q_sub_exp);
a_100_500 = 5/y;
a_100_011 = sqrt(2)/x;
% --------------------------------------------------------------------

% plotting
subplot(2,2,2);
fileName = strcat('RSM_data_W6847_all','.mat');
    load(fileName)
    
    qx = q_perp{2};
    qy = q_parallel{2};
    intensity = data{2};
    [qx,qy,p] = correctReciprocalData(qx,qy,q_sub_lit,q_sub_exp);
    [~,h] = contourf(qx,qy,intensity,logspace(1,4.5,30),"LineStyle","none")
    h.HandleVisibility = "off";

    set(gca,"Colorscale","log")
    title("511 on (100) corrected")
    xlabel("q_{||} (nm^{-1})")
    ylabel("q_\perp (nm^{-1})")
    hold on
    xline(x,DisplayName="a_{||} = "+num2str(a_100_011,"%.3f")+" nm")
    yline(y,DisplayName="a_\perp = "+num2str(a_100_500,"%.3f")+" nm")
    axis([1.6496    1.8493    5.8431    6.3293])
    legend
    colorbar

%% 440 plane on (110)
% plotRSM("W6847","all",[3],5);

% -------------------------- CALCULATION -----------------------------
q_sub_exp = [0.0486 ; 6.9949];
q_film_exp = [0.0484 ; 6.8789];

% in-plane component = 000
% o-o-p component = 440
q_sub_lit = getCubicVector([0 0 0],[4 4 0],a);

% correct the data
[x,y,p] = correctReciprocalData(q_film_exp(1),q_film_exp(2),q_sub_lit,q_sub_exp);
a_110_440 = 4*sqrt(2)/y;
% --------------------------------------------------------------------

% plotting
subplot(2,2,3);
fileName = strcat('RSM_data_W6847_all','.mat');
    load(fileName)
    
    qx = q_perp{3};
    qy = q_parallel{3};
    intensity = data{3};
    [qx,qy,p] = correctReciprocalData(qx,qy,q_sub_lit,q_sub_exp);
    [~,h] = contourf(qx,qy,intensity,logspace(1,4,30),"LineStyle","none")
    h.HandleVisibility = "off";

    set(gca,"Colorscale","log")
    title("440 on (110) corrected")
    xlabel("q_{||} (nm^{-1})")
    ylabel("q_\perp (nm^{-1})")
    hold on
    xline(x,DisplayName="a_{||} = "+num2str(nan,"%.2f")+" nm")
    yline(y,DisplayName="a_\perp = "+num2str(a_110_440,"%.3f")+" nm")
    axis([-0.0626    0.0800    6.6343    7.1078])
    legend
    colorbar

%% 553 plane on (110)
% plotRSM("W6847","all",[4],2.7);

% -------------------------- CALCULATION -----------------------------
q_sub_exp = [3.7265 ; 8.7387];
q_film_exp = [3.6309 ; 8.6007];

% in-plane component = 003
% o-o-p component = 550
q_sub_lit = getCubicVector([0 0 3],[5 5 0],a);

% correct the data
[x,y,p] = correctReciprocalData(q_film_exp(1),q_film_exp(2),q_sub_lit,q_sub_exp);
a_110_550 = 5*sqrt(2)/y;
a_110_003 = 3/x;
% --------------------------------------------------------------------

% plotting
subplot(2,2,4);
fileName = strcat('RSM_data_W6847_all','.mat');
    load(fileName)
    
    qx = q_perp{4};
    qy = q_parallel{4};
    intensity = data{4};
    [qx,qy,p] = correctReciprocalData(qx,qy,q_sub_lit,q_sub_exp);
    [~,h] = contourf(qx,qy,intensity,logspace(1,2.6,30),"LineStyle","none")
    h.HandleVisibility = "off";

    set(gca,"Colorscale","log")
    title("553 on (110) corrected")
    xlabel("q_{||} (nm^{-1})")
    ylabel("q_\perp (nm^{-1})")
    hold on
    xline(x,DisplayName="a_{||} = "+num2str(a_110_003,"%.3f")+" nm")
    yline(y,DisplayName="a_\perp = "+num2str(a_110_550,"%.3f")+" nm")
    axis([3.5475    3.7888    8.5178    8.8592])
    legend
    colorbar







%%
% --------------
% aux. function
% --------------

function vector = getCubicVector(hkl_in,hkl_out,a)
h1 = hkl_in(1);
k1 = hkl_in(2);
l1 = hkl_in(3);

h2 = hkl_out(1);
k2 = hkl_out(2);
l2 = hkl_out(3);

reciprocal = @(h,k,l) sqrt(h^2+k^2+l^2) / a;

in = reciprocal(h1,k1,l1);
out = reciprocal(h2,k2,l2);
vector = [in ; out];
end


    


