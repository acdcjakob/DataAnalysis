samTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","r-Al2O3"}}...
    ,true);
samTable = sortrows(samTable,"NameVal"); % sort dep. on pulse energy

N = numel(samTable.Id);

%%



tH = tiledlayout(4,2);
[tH,fH] = makeLatexSize(1,1,tH)

for i = 1:N
    % 024
    lit = getSapphireVector([0 0 0],[0 2 4]);
    [sub,film] = getRSMData(samTable.Id{i},"cPar0");
    [~,~,~,M] = correctReciprocalData(...
        film(1),film(2),lit,sub);

    ax(i,1) = nexttile(tH,1+2*(i-1));
        formatAxes(ax(i,1))
        hold(ax(i,1),"on")
    plotRSM(samTable.Id{i},"300",[3,4],2,M)
        drawnow
    hold(ax(i,1),"on")
    

    % 300
    lit = q030.*[-1;1];
    [sub,film] = getRSMData(samTable.Id{i},"cPar1");
    [qx,qy,~,M] = correctReciprocalData(...
        film(1),film(2),lit,sub);

    ax(i,2) = nexttile(tH,2*i);
        formatAxes(ax(i,2))
        hold(ax(i,2),"on")
    set(gcf,"CurrentAxes",ax(i,2))
    plotRSM(samTable.Id{i},"300",[1,2],2,M)
    % plotRSM(samTable.Id{i},"300",1,2)
        drawnow
    X = q030Cr.*[-1;1];
    hold(ax(i,2),"on")
    L_lit = scatter(ax(i,2),X(1),X(2),"dk","filled","displayname",...
        "lit.");
    L_obs = scatter(ax(i,2),qx,qy,"rs","filled","displayname",...
        "obs.");
    leg = legend(ax(i,2),[L_obs,L_lit],"location","southwest");
    leg.Title.String = samTable.NameVal{i}+" mJ";

    linkaxes(ax(:,1));
    axis(ax(1,1),[-.1 .1 5.4 5.8])
    linkaxes(ax(:,2));
    axis(ax(1,2),[-3.95 -3.65 5.9 6.2])
end

title(ax(1,1),"symmetric (02.4)")
title(ax(1,2),"asymmetric (30.0)")

xlabel(tH,"q_{||} (nm^{-1})")
ylabel(tH,"q_\perp (nm^{-1})")

exportgraphics(fH,"../Plots/Thesis/3/3_misc_r_RSMs.png","Resolution",800)

function q = q030Cr()
a_Cr2O3 = 4.958; % angstrom
c_Cr2O3 = 13.593; % angstrom
a = a_Cr2O3;
c = c_Cr2O3;
h = 0; k = 1 ; l = 2;
alpha = acos(l/sqrt(4/3*c^2/a^2*(h^2+k^2+h*k)+l^2));
q = getChromiumVector([0 3 0],[0 3 0]).* ...
        [cos(alpha);sin(alpha)];
end

function q = q030()
a_Al2O3 = 4.755; % angstrom
c_Al2O3 = 12.99; 
a = a_Al2O3;
c = c_Al2O3;
h = 0; k = 1 ; l = 2;
alpha = acos(l/sqrt(4/3*c^2/a^2*(h^2+k^2+h*k)+l^2));
q = getSapphireVector([0 3 0],[0 3 0]).* ...
        [cos(alpha);sin(alpha)];
end