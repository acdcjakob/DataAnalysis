aCr = 4.96/10;
cCr = 13.59/10;

% read values
d = [216,171,84,43,26];

film = {
    [4.682;7.333]
    [4.681;7.326]
    [4.715;7.273]
    [4.752;7.219]
    [4.85 ;7.1  ]
    };

for i = 1:numel(d)
    c(i) = 10/film{i}(2);
    a(i) = 4/sqrt(3)/film{i}(1);
end

ezz = (c - cCr)/cCr;
exx = (a-aCr)/aCr;

C13 = 1.75;
C33 = 3.62;

exx_pred = ezz/(-2)/C13*C33;
%%
[ax,f] = makeLatexSize(.5,1.2)
hold(ax,"on")
formatAxes(ax);

scatter(d,ezz*100,"r","filled","displayname",...
    "\epsilon_{zz} obs.",...
    "sizedata",36*2,...
    "markerfacecolor",[.7 0 0]);
hold on
scatter(d,exx*100,"g","filled","displayname",...
    "\epsilon_{xx} obs.",...
    "sizedata",36*2,...
    "markerfacecolor",[0 .7 0]);
plot(d,exx_pred*100,"-or","LineWidth",1,"DisplayName",...
    "\epsilon_{xx} calculated from \epsilon_{zz}");

legend
grid

xlabel("{\itd} (nm)")
ylabel("strain \epsilon (%)")
