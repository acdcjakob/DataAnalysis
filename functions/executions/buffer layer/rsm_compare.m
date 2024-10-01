sample(1) = "W6957c";
sample(2) = "W6958c";
reflex = "006";
plane = "c";
lims = [-.05 .05 4.3 4.5];
n = 1;
figure();

doIt(sample,reflex,plane,lims,n)
%%
sample(1) = "W6957r";
sample(2) = "W6958r";
reflex = "024";
plane = "r";
lims = [-.01 .15 5.4 5.8];
n = 1:2;
figure();
doIt(sample,reflex,plane,lims,n)
%%
sample(1) = "W6957m";
sample(2) = "W6958m";
reflex = "300";
plane = "m";
lims = [-.1 .05 6.9 7.05];
n = [1,3];
figure();
doIt(sample,reflex,plane,lims,n)
%%
sample(1) = "W6957a";
sample(2) = "W6958a";
reflex = "220";
plane = "a";
lims = [-.1 .1 7.93 8.1];
n = 1;
figure();
doIt(sample,reflex,plane,lims,n)

function doIt(sample,reflex,plane,lims,n)
    t = tiledlayout(1,2,"units","centimeters",...
        "TileSpacing","compact",...
        "Padding","tight");
    
    [t,f] = makeLatexSize(1,.5,t);
    
    for i = 1:2
        ax(i) = nexttile();
        if strcmp(plane,"c")
            SubLit = getSapphireVector([0 0 0],[0 0 6]);
        elseif strcmp(plane,"r")
            SubLit = getSapphireVector([0 0 0],[0 2 4]);
        elseif strcmp(plane,"m")
            SubLit = getSapphireVector([0 0 0],[3 0 0]);
        elseif strcmp(plane,"a")
            SubLit = getSapphireVector([0 0 0],[2 2 0]);
        end

        SubExp = getRSMData(sample(i),"sym");
        [~,~,~,M] = correctReciprocalData(...
        nan,nan,SubLit,SubExp);



        h(i) = plotRSM(sample(i),reflex,n,2,M);

    end

    set(ax,...
        "Linewidth",1,...
        "FontSize",12)

    title(ax(1),"only Cr_2O_3","FontSize",11,"FontWeight","normal");
    title(ax(2),"ex-situ Ga_2O_3 on Cr_2O_3","FontSize",11,"FontWeight","normal");
    
    linkaxes(ax);
    axis(lims);
    
    
    sgtitle(t,plane+"-plane "+char(945)+"-Ga_2O_3 on buffer layer Cr_2O_3",...
        "Fontweight","bold",...
        "Fontsize",12);
    
    xlabel(t,"q_{||} (nm^{-1})")
    ylabel(t,"q_{\perp} (nm^{-1})")
    
    exportgraphics(f,"_temp/RSM_buffer_"+plane+".png","Resolution",300)
end
%%
% 
% figure();
% subplot(1,2,1),plotRSM("W6957r","024",[1,2],2.5)
% ax1=gca;
% subplot(1,2,2),plotRSM("W6958r","024",[1,2],2.5)
% ax2=gca;
% linkaxes([ax1 ax2]);
% axis([-.05 .2 5.4 5.85]);
% title(ax1,"only Cr_2O_3")
% title(ax2,"Cr_2O_3 + Ga_2O_3")
% sgtitle("r-plane")
% exportgraphics(gcf,"_temp/buffer_r.png","Resolution",300)
% 
% figure();
% subplot(1,2,1),plotRSM("W6957m","300",1,2.5)
% ax1=gca;
% subplot(1,2,2),plotRSM("W6958m","300",1,2.5)
% ax2=gca;
% linkaxes([ax1 ax2]);
% axis([-.07 .07 6.9 7.35]);
% title(ax1,"only Cr_2O_3")
% title(ax2,"Cr_2O_3 + Ga_2O_3")
% sgtitle("m-plane")
% exportgraphics(gcf,"_temp/buffer_m.png","Resolution",300)
% 
% figure();
% subplot(1,2,1),plotRSM("W6957a","220",1,2)
% ax1=gca;
% subplot(1,2,2),plotRSM("W6958a","220",1,2)
% ax2=gca;
% linkaxes([ax1 ax2]);
% axis([-0.12 0.05 7.9 8.5]);
% title(ax1,"only Cr_2O_3")
% title(ax2,"Cr_2O_3 + Ga_2O_3")
% sgtitle("a-plane")
% exportgraphics(gcf,"_temp/buffer_a.png","Resolution",300)