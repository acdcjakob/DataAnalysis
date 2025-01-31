sampleTable = searchSamples_v2(...
        {{"Batch","Cr2O3_energy";...
        "NameVal","-2";...
        "Sub","c-Al2O3";...
        "RSM","a"}}...
    ,true);

sampleTable = sortrows(sampleTable,"d","descend");
N = numel(sampleTable.Id);
tileH = tiledlayout(1,N,...
    "Padding","tight",...
    "TileSpacing","compact");
[tileH, fH] = makeLatexSize(1,.5,tileH);

xlabel(tileH,"q_{||} (nm^{-1})")
ylabel(tileH,"q_{\perp} (nm^{-1})")
% sgtitle(tileH,"{\itd} (nm)")
tileH.Title.FontSize = 12;

lit = getSapphireVector([0 2 0],[0 0 10]);
ax = gobjects(N,1);

drawnow
for i = 1:N
    [sub{i},film{i}] = getRSMData(sampleTable.Id{i},"mPar1");
    
    [~,~,~,M] = correctReciprocalData(...
        film{i}(1),film{i}(2),lit,sub{i});
    
    ax(i) = nexttile();
        hold(ax(i),"on")
        formatAxes(ax(i))

    plotRSM(sampleTable.Id{i},"0210",[1,2],1.5,M)
    axis([4.57  4.94    7    7.78])
    drawnow
    title(ax(i),"{\itd} = "+num2str(sampleTable.d(i))+" nm")
    ax(i).Title.FontSize = 10;
    ax(i).Title.FontWeight = "normal";

    drawnow
end


exportgraphics(fH,"../Plots/Thesis/3/3_lensPos_RSM_c.png","Resolution",800)