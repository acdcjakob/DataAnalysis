samTable = searchSamples_v2(...
    {{"Batch","Cr2O3_ZnO_CompVar2";...
    "Sub","c-Al2O3"}},...
    true);

samTable = sortrows(samTable,"Id");
% [~,dplc,~] = unique(samTable.Id);
% samTable = samTable(dplc,:);

x = 1:numel(samTable.Id);
y = growthrateFun(samTable)*1000; % pm/pulse

%% plotting section
[ax,fh] = makeLatexSize(.5,1);
    hold(ax,"on")
    set(ax,"YGrid","on")
    axis padded
ph = plot(x,y,"sq--k","LineWidth",1,"MarkerFaceColor","k",...
        "HandleVisibility","off");

title("ZnO-doped target (H)")
xlabel("process")
ylabel("{\itg} (pm pulse^{-1})")

exportgraphics(fh,"../Plots/Thesis/2/2_doped1_growthrate.eps");