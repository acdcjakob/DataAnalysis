x_out = 0;
x_in = 0.01; % in percent 
a = 17 / 2; % 8.5 mm
b = 8 / 2; % 4 mm
ex = sqrt(1-b^2/a^2);

r = 2:0.05:10 ; % laser spot positions in mm
monteError = [0,.5,2,4];

cm = copper(100)*.9;
colIdx = floor(rescale(monteError)*99)+1;
clim([min(monteError) max(monteError)]);
colormap(cm);

ax = makeLatexSize(.5,1,gca);
hold(ax,"On");

for j = flip(1:numel(monteError))
    N = 10000;

    for i = 1:numel(r)
        rRand = r(i)+2*monteError(j)*(rand(1,N)-.5);
        xRand = x_out-(x_out-x_in)*2/pi*acos(1/ex*sqrt(1-b^2./rRand.^2));
        x(i) = mean(real(xRand));
    end
    
    plot(r,x,...
        "Color",cm(colIdx(j),:),...
        "LineWidth",1.5,...
        "DisplayName","\Delta{\itr} = "+monteError(j)+"mm",...
        "HandleVisibility","off")
    hold on
    % ytickformat("percentage")
    
    
end

fit = [-0.00158 0.014046];
xFit = (2:10)*fit(1)+fit(2);
plot(2:10,xFit,"b:",...
    "LineWidth",1.5,...
    "DisplayName","linear fit"+newline+"\Deltar = 2mm")

ylabel("{\itx}_D (%)")
xlabel("{\itr}_{PLD} (mm)")
cb = colorbar;
cb.Label.String = ("\Delta{\itr} (mm)");
grid("on")
lh = legend("Position",[0.3307    0.6693    0.3175    0.1100]);

xlim([2 10]);
ylim([0 0.01]);

