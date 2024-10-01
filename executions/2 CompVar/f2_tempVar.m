Ids{1} = ... c-oriented
    searchSamples_v2({{
        'Batch','Cr2O3_ZnO_PowerVar1';
        'Sub','c-Al2O3';
        'Contacts','TiAlAu'
    }},true);

Ids{2} = ... r-oriented
    searchSamples_v2({{
        'Batch','Cr2O3_ZnO_PowerVar1';
        'Sub','r-Al2O3';
        'Contacts','TiAlAu'
    }},true);

const = ["{\itc}","{\ita}"];
plane = ["c","r"];
colors = {[0 .6 .2] [.2 .1 .9]};
lit = [13.59 4.96];
loc = ["west" "northeast"];
% --- initialize data structures
lattice = cell(1,2);
omega = cell(1,2);
X = cell(1,2);
pH = cell(1,2);
% ------------------------------------------
figure("OuterPosition",[100 100 700 400]);

ax{1}(1) = axes("Position",[.1 .15 .3 .8],"YColor",colors{1});
ax{1}(2) = axes("Position",get(ax{1}(1),"Position"),...
    "Color","none",...
    "XTick",[],...
    "XColor","none",...
    "YAxisLocation","right",...
    "YColor",colors{2});

ax{2}(1) = axes("Position",[.6 .15 .3 .8],"YColor",colors{1});
ax{2}(2) = axes("Position",get(ax{2}(1),"Position"),...
    "Color","none",...
    "XTick",[],...
    "XColor","none",...
    "YAxisLocation","right",...
    "YColor",colors{2});

hold([ax{:}],"on")
axis([ax{:}],"padded")
% -------------------------------------------
for i = [1,2]
    xlabel(ax{i}(1),"{\it\Theta} (°C)")
    ylabel(ax{i}(1),const(i)+" ("+char(197)+")")
    ylabel(ax{i}(2),"\omega-FWHM (°)")
    drawnow

    lattice{i} = transpose(getPeakShift(Ids{i},"lattice",true,"table",true));
    omega{i} = transpose(getRocking(Ids{i}.Id));
    X{i} = columnToNumber(Ids{i}.NameValAlt);
    % X{i} = omega{i};

    [~,perm] = sortrows(X{i});
    lattice{i} = lattice{i}(perm);
    omega{i} = omega{i}(perm);
    X{i} = X{i}(perm);

    pH{i}(1) = plot(ax{i}(1),X{i},lattice{i},"^-",...
        Color=colors{1},...
        MarkerFaceColor="g",...
        DisplayName="lattice");
    yline(ax{i}(1),lit(i),"-.",...
        "LineWidth",1,"Alpha",.6,...
        "Color",colors{1}*0.7,...
        HandleVisibility="off")
    pH{i}(2) = plot(ax{i}(2),X{i},omega{i},"s--",...
        Color=colors{2},...
        MarkerFaceColor="b",...
        DisplayName="crystallinity");
    
    linkaxes(ax{i},'x')
    legend(ax{i}(2),[pH{i}],"Location",loc(i),...
        Color="w")

    grid(ax{i}(1),"on")
    set(ax{i}(1),"GridLineWidth",1.2)

end

exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-tempVar_xrd.pdf")
exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-tempVar_xrd.png","Resolution",250)
