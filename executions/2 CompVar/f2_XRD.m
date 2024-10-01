% create 4 plots for four orientations
% c, m, r, a
w = .45;
w0 = (1-2*w)/4;
h = .45;
h0 = (1-2*h)/4;
axPos = {
    [w0 h+h0 w h],
    [.5+w0 h+h0 w h],
    [w0 h0 w h],
    [.5+w0 h0 w h]
}; %#ok<*COMNL>

planes = ["c";
    "m";
    "r";
    "a"
];
reference = [
    13.59;
    4.96;
    4.96;
    4.96
];
batches = ["Cr2O3_CuO_CompVar1",...
    "Cr2O3_ZnO_CompVar1",...
    "Cr2O3_ZnO_CompVar2",...
    "Cr2O3_ZnO_PowerVar1"];%,...
    % "Cr2O3_energy",...
    % "Cr2O3_energy"
% ];
names = ["0.01%-CuO",...
    "0.01%-ZnO",...
    "1%-ZnO",...
    "power",...
    energyDensity(-2,true),...
    energyDensity(0,true)
];
addSearch = {
    {},...
    {},...
    {},...
    {'Contacts','TiAlAu'},...
    {'NameVal','-2'},...
    {'NameVal','0'}
};
symbols = [
    "o";
    "o";
    "^";
    "s"
    ">";
    "<";
];
colors = jet(5);
colors = [
    colors(1,:)
    colors(2,:)
    colors(3,:)
    1 0 0
    colors(4,:)
    colors(4,:)*.8
];

nB = numel(batches)-1;
    % no "-1" for temperature batch
nP = numel(planes);
%initialize
IdCell = cell(nP,nB);
latticeCell = cell(nP,nB);
xCell = cell(nP,nB);
axAr = gobjects(nP,1);
scatterAr = gobjects(nP,nB);
highlight = gobjects(nP,nB);
figure("Color","w")
for iP = 1:nP
    axAr(iP) = axes("OuterPosition",axPos{iP},"Box","on");
    % legend(gca);
    hold(gca,"on")
    grid(gca,"on")
    
    for jB = 1:nB
        IdCell{iP,jB} = searchSamples_v2({[{...
            'Batch',batches(jB);...
            'Sub',planes(iP)+"-Al2O3";...
            'ThetaOmega','a'};...
            addSearch{jB}
            ]},true);
        if isempty(IdCell{iP,jB})
            continue
        end
        latticeCell{iP,jB} = transpose(getPeakShift(IdCell{iP,jB},"Table",true,"lattice",true));
        % xCell{iP,jB} = IdCell{iP,jB}.d;
        xCell{iP,jB} = growthrateFun(IdCell{iP,jB})*1000;

        % --- marking the replicas
        idx = strcmp(IdCell{iP,jB}.Comment,'repl');
        if any(idx)
            highlight(iP,jB) = plot(xCell{iP,jB}(idx),latticeCell{iP,jB}(idx),"ro","MarkerSize",12,...
                Displayname="replica");
        end
        % ---

        scatterAr(iP,jB) = scatter(xCell{iP,jB},latticeCell{iP,jB},...
            MarkerFaceColor=colors(jB,:),...
            MarkerEdgeColor=colors(jB,:)*0.5,...
            DisplayName=names(jB),...
            Marker=symbols(jB));
    end
    yline(reference(iP),...
        HandleVisibility="off",...
        Color="r",...
        LineStyle="--",...
        LineWidth=1)
    axis(gca,"padded")
    xlabel("growthrate (pm/pulse)","FontSize",11)
    ylabel("lattice constant ("+char(197)+")","FontSize",11)
    t = annotation("textbox");
    t.String = planes(iP);
    t.FontWeight = "bold";
    t.FitBoxToText = "on";
    t.BackgroundColor = "w";
    t.VerticalAlignment = "middle";
    t.HorizontalAlignment = "center";
        drawnow
    tPos = t.Position;
    aPos = get(gca,"Position");
    t.Position = [aPos(1) aPos(2)+aPos(4)-tPos(4) tPos(3) tPos(4)];

    
end
%%
l = legend(axAr(1),scatterAr(1,:),"Location","northeast","NumColumns",4);
        lPos = l.Position;
        l.Position = [.5-lPos(3)/2 2*h+h0 lPos(3) lPos(4)];
        l.Title.String = "target";
lHigh = legend(axAr(2),highlight(2,3));
        q = get(axAr(2),"Position");
    	lHighPos = lHigh.Position;
        lHigh.Position = [q(1)+q(3)-lHighPos(3) q(2)+q(4)-lHighPos(4) lHighPos(3) lHighPos(4)];


delete(scatterAr(3,3))
delete(highlight(3,3))

xlim([2 7]);
linkaxes(axAr,'x')
linkaxes(axAr([2,3,4]),'y')

% exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-lattice_vs_growthrate.pdf")
% exportgraphics(gcf,"../Plots/Cr2O3/2 Doping/2-lattice_vs_growthrate.png","Resolution",250)