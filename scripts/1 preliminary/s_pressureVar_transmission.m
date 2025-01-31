samTable = searchSamples_v2({{ ...
    'Id','W6723';'NameUnit','mbar'},{'Id','W6724';'NameUnit','mbar'}},true);

% get data
data = cell(1,2);
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
axLim = [.5 5.6 -.3e11 4e11]; % for tauc plot
% axLim = [.5 5.5 0 109]; % for T plot
visSpec = patch([1.6 3.1 3.1 1.6],...
    [axLim(3) axLim(3) axLim(4) axLim(4)],"g",...
    "Facealpha",.2,...
    "edgecolor","none",...
    "displayname","visible light");
ph = gobjects(2);
for i = 1:2
    x = data{i}(:,1);
    y = data{i}(:,2);
    y(y<0)=nan; % delete negative
    alpha = -1*log(y)./(samTable.d(i)*1e-7); % cm^-1
    tauc = (alpha).^2;
    % revisited! As described in my thesis, for crystalline solids, a Tauc
    % plot is not the proper method; just plot alpha^2 vs. E.

    % ph(i) = plot(x,alpha); % for alpha plot
    ph(i) = plot(x,tauc); % for tauc plot
    % ph(i) = plot(x,y*100); % for T plot

    set(ph(i),...
        "LineWidth",1,...
        "Color",cs(i,:),...
        "DisplayName",samTable.NameVal{i}+" "+samTable.NameUnit{i}+...
        ", "+num2str(samTable.d(i))+" nm")

    % fit 1
    x0 = 3.75;
    x1 = 4.3;
    idx = x>x0 & x<x1;
    p = polyfit(x(idx),tauc(idx),1); % linear fit
    xFit = (-p(2)/p(1)):.01:x1+.3;
    yFitAlpha = (polyval(p,xFit).^(1/2))./xFit; % for alpha plot
    yFitTauc = polyval(p,xFit); % for tauc plot
    Eg(i) = -p(2)/p(1);
    % phFit = plot(xFit,yFitAlpha,"--"); % for alpha plot
    phFit(i) = plot(xFit,yFitTauc,"--"); % for tauc Plot
    set(phFit(i),...    
        "LineWidth",1,...
        "Color",cs(i,:),...
        "DisplayName","{\itE}_{opt} = "+num2str(Eg(i),"%.2f")+" eV")

    % % fit 2
    x0 = 5.3;
    x1 = 5.5;
    idx = x>x0 & x<x1;
    p = polyfit(x(idx),tauc(idx),1); % linear fit
    xFit = (-p(2)/p(1)):.01:x1+.3;
    yFitAlpha = (polyval(p,xFit).^(1/2))./xFit; % for alpha plot
    yFitTauc = polyval(p,xFit); % for tauc plot
    Eg(i) = -p(2)/p(1);
    % phFit = plot(xFit,yFitAlpha,"--"); % for alpha plot
    phFit(i) = plot(xFit,yFitTauc,":"); % for tauc Plot
    set(phFit(i),...    
        "LineWidth",1,...
        "Color",cs(i,:),...
        "DisplayName","{\itE}_{opt} = "+num2str(Eg(i),"%.2f")+" eV")
    
    % to "fill" the legend :)
    if i == 1
        plot(nan,nan,"DisplayName","","Color","none")
    end
end

axis(axLim)
lh = legend("Location","northwest","NumColumns",2);
grid on
xlabel("{\itE} (eV)")
% ylabel(getGreek('alpha')+" (cm^{-1})") % for alpha plot
ylabel("\alpha^2 (a.u.)") % for "tauc" plot
set(gca,"YTickLabel",{'0' '' '' '' '' '' ''})
% ylabel("{\itT} (%)"), delete(phFit), lh.Location = "northeast";% for T plot

%%
% fh.Renderer = "Painters"; %this does not render transparancy!
exportgraphics(fh,"../Plots/Thesis/1/1_pressure_tauc.pdf")
% exportgraphics(fh,"../Plots/Thesis/1/1_pressure_transmission.pdf")