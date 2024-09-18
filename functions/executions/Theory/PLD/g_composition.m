x_out = 0;
x_in = .01; % in percent
ex = 0.9; 

b = 6; % smaller elliptical half axis in mm
r = 2:0.1:20 ; % laser spot position in mm

x = x_out-(x_out-x_in)*2/pi*acos(1/ex*sqrt(1-b^2./r.^2));

plot(r,x,...
    "Color",[.7 .2 .7],...
    "LineWidth",1)

ytickformat("percentage")

ylabel("{\itx}_D (%)")
xlabel("{\itr}_{PLD} (mm)")

grid("on")

makeLatexSize(.5,1,gca)