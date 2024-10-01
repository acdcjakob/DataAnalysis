sampleTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy2";...
        "RSM","a";...
        "Sub","r-Al2O3"}}...
    ,true);

sampleTable = sortrows(sampleTable,"NameVal");
N = numel(sampleTable.Id);
F = figure("OuterPosition",[100 100 1000 500]);

lit = q030.*[-1;1];
for i = 1:N
    [sub{i},film{i}] = getRSMData(sampleTable.Id{i},"cPar1");
    
    [qx(i),qy(i),~,M] = correctReciprocalData(...
        film{i}(1),film{i}(2),lit,sub{i});
    
    ax(i) = axes("OuterPosition",[0+(i-1)/N 0 1/N 1],...
        "LineWidth",.75,...
        "box","on",...
        "Fontsize",14);
    hold(ax(i),"on")
    plotRSM(sampleTable.Id{i},"300",[1,2],1.5,M)
    axis([-3.937147936577903  -3.589890895818097   5.831834916680842   6.216052234026121])
    drawnow
    title("{\itF} = "+energyDensity(-1,true,sampleTable.NameVal{i})+newline+...
        "{\itd}="+sampleTable.d(i)+"nm")
end
%%
for i = 1:N
    hold(ax(i),"on")
    plot(ax(i),qx,qy,".-k","linewidth",1)
end


xlabel(ax(1),"q_{||} (nm^{-1})")
ylabel(ax(1),"q_{\perp} (nm^{-1})")

exportgraphics(gcf,"../plots/TCO/r-RSMs.png","Resolution",500)







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