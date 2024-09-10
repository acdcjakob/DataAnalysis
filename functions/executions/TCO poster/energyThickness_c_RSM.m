sampleTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy";...
        "NameVal","-2";...
        "Sub","c-Al2O3";...
        "RSM","a"}}...
    ,true);

sampleTable = sortrows(sampleTable,"d","descend");
N = numel(sampleTable.Id);
F = figure("OuterPosition",[100 100 1000 500]);

lit = getSapphireVector([0 2 0],[0 0 10]);
for i = 1:N
    [sub{i},film{i}] = getRSMData(sampleTable.Id{i},"mPar1");
    
    [~,~,~,M] = correctReciprocalData(...
        film{i}(1),film{i}(2),lit,sub{i});
    
    ax(i) = axes("OuterPosition",[0+(i-1)/N 0 1/N 1],...
        "LineWidth",.75,...
        "box","on",...
        "Fontsize",14);
    hold(ax(i),"on")
    plotRSM(sampleTable.Id{i},"0210",[1,2],1.5,M)
    axis([4.57  4.94    7    7.78])
    drawnow
    title("{\itd} = "+sampleTable.d(i)+"nm")
end


xlabel(ax(1),"q_{||} (nm^{-1})")
ylabel(ax(1),"q_{\perp} (nm^{-1})")

exportgraphics(gcf,"../plots/TCO/c-RSMs.png","Resolution",500)