samTable = searchSamples_v2({{ ...
    'Id','W6723';'NameUnit','mbar'},{'Id','W6724';'NameUnit','mbar'}},true);

% get data
for i = 1:2
    [data{i}(:,1),data{i}(:,2)] = getTransmission(samTable.Id{i});
end

% plot
[ax,fh] = makeLatexSize(1,.4);
    hold(ax,"on")
    fh.Renderer = "painters";
cs = cool(4)*.8;
cs = [cs(3,:);cs(1,:)]; % same colors as in 2theta-plot

% axLim = [.5 5.5 -.5e5 9e5]; % for alpha plot
axLim = [.5 5.5 -.5e12 9e12]; % for tauc plot
% axLim = [.5 5.5 0 109]; % for T plot
visSpec = patch([1.6 3.1 3.1 1.6],...
    [axLim(3) axLim(3) axLim(4) axLim(4)],"g",...
    "Facealpha",.2,...
    "edgecolor","none",...
    "displayname","visible light");
for i = 1:2
    x = data{i}(:,1);
    y = data{i}(:,2);
    y(y<0)=nan; % delete negative
    alpha = -1*log(y)./(samTable.d(i)*1e-7); % cm^-1
    tauc = (alpha.*x).^2;

    % ph(i) = plot(x,alpha); % for alpha plot
    ph(i) = plot(x,tauc); % for tauc plot
    % ph(i) = plot(x,y*100); % for T plot

    set(ph(i),...
        "LineWidth",1,...
        "Color",cs(i,:),...
        "DisplayName",samTable.NameVal{i}+" "+samTable.NameUnit{i})

    % fit
    x0 = 3.9;
    x1 = 4.3;
    idx = x>x0 & x<x1;
    p = polyfit(x(idx),tauc(idx),1);
    xFit = (-p(2)/p(1)):.01:x1+.3;
    yFitAlpha = (polyval(p,xFit).^(1/2))./xFit; % for alpha plot
    yFitTauc = polyval(p,xFit); % for tauc plot
    Eg(i) = -p(2)/p(1);
    % phFit = plot(xFit,yFitAlpha,"--"); % for alpha plot
    phFit(i) = plot(xFit,yFitTauc,"--"); % for tauc Plot
    set(phFit(i),...    
        "LineWidth",1,...
        "Color",cs(i,:),...
        "DisplayName","{\itE}_\tau = "+num2str(Eg(i),"%.2f")+" eV")
    
end

axis(axLim)
lh = legend("Location","northwest");
grid on
xlabel("{\itE} (eV)")
% ylabel(getGreek('alpha')+" (cm^{-1})") % for alpha plot
ylabel("(\alpha{\itE})^2 (cm^{-1}\times eV)^2") % for tauc plot
% ylabel("{\itT} (%)"), delete(phFit), lh.Location = "northeast";% for T plot


% fh.Renderer = "Painters"; %this does not render transparancy!
exportgraphics(fh,"../Plots/Thesis/1/1_pressure_tauc.pdf")
% exportgraphics(fh,"../Plots/Thesis/1/1_pressure_transmission.pdf")