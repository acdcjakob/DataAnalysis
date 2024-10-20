Ids = ...
    ["W6778c",  "CuO-doped",  "";...
    "W6784c",   "ZnO-doped (L)",  "";...
    "W6856c",   "ZnO-doped (H)",     "";...
    "W6788c",   "undoped",       "origin"...
    ];

N = 4;
%% get data and plot
% init
data = cell(N,1);
scHand = gobjects(N,1);
erHand = gobjects(N,1);
% plot specs
colMap = [.2 .8 .2;
    .7 .2 .7;
    .7 .2 .5;
    .7 .7 .7];
markMap = ["s";
    "s";
    "^";
    "o"];

[axHand,fHand] = makeLatexSize(.5,1);
    hold(axHand,"on")
    set(axHand,...
        "YScale","log",...
        "YGrid","on",...
        "XGrid","on")
for i = 1:N
    data{i} = rescaleTdH_resistivity(Ids(i,1),"filter",Ids(i,3));

    % just use on of the two applied currents
    % look at `f2_TdH` for mor detailled plot

    T = data{i}{1}(:,1);
    rho = data{i}{1}(:,2);
    err_rho = data{i}{1}(:,3);

    scHand(i) = scatter(axHand,...
        1000./T,rho*100,... % inverse temp and Ohm cm
        "MarkerFaceColor",colMap(i,:),...
        "MarkerEdgeColor","w",...
        "Marker",markMap(i),...
        "SizeData",2*36,...
        "Displayname",Ids(i,2));

    erHand(i) = errorbar(...
        1000./T,rho*100,err_rho*100,...
        ".",...
        "Color",colMap(i,:)*.5,...
        "HandleVisibility","off");
end

xlabel("1000/{\itT} (1/K)")
ylabel("\rho (\Omega cm)")

legHand = legend("Location","best",...
    "Position",[0.4181    0.2137    0.4036    0.2111]);
formatAxes(axHand);

exportgraphics(fHand,"../Plots/Thesis/2/2_doped_TdH.eps")