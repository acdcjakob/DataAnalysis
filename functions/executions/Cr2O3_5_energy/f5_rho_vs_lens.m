% Observations:
% for c-orientation, E and FWHM are correlated -> higher E makes worse
% crystals (FWHM) -> better conductivity
% for r-orientation, E does not change FWHM but still makes better
% conductivity (??? which other physical property changes?)
% for a-orientation, E and FWHM are correleated but inverse to c: and
% higher E still makes better conductivity
% --> so is E crucial and not FWHM?
% however only looking at E~2: higher FWHM makes better conductivity across
% thin film directions
%
% more measurements have to be done
%%
% columns orientation
% rows lens position
o = ["c","r","a"];
symb = ["o","s","^"];

samples(1).names = searchSamples_v2({{'Batch','Cr2O3_energy';'Hall','y';'Sub','c-Al2O3'}});
samples(2).names = searchSamples_v2({{'Batch','Cr2O3_energy';'Hall','y';'Sub','r-Al2O3'}});
samples(3).names = searchSamples_v2({{'Batch','Cr2O3_energy';'Hall','y';'Sub','a-Al2O3'}});

figure()
ax1 = axes();
figure()
ax2 = axes();
hold(ax1,"on")
hold(ax2,"on")

for i =  1:3
    samples(i).orientation = o(i);
    for j = 1:numel(samples(i).names)
        samples(i).results(j) = getHallData(getFilePathsFromId(samples(i).names(j),"Hall_RT",".mat"));
        [Y,Y_err] = weightedMean([samples(i).results{j}.rho],[samples(i).results{j}.err_rho]);
        samples(i).rho(j) = Y;
        samples(i).rho_err(j) = Y_err;
        samples(i).x(j) = energyDensity(searchSamples_v2({{'Id',samples(i).names(j)}},true).NameVal{1,1});
        samples(i).x2(j) = searchSamples_v2({{'Id',samples(i).names(j)}},true).d;
        samples(i).x3(j) = getRocking(samples(i).names(j));
        scatter(ax1,samples(i).x(j),samples(i).rho(j),"Marker",symb(i),"DisplayName",samples(i).names(j));
    end
    errorbar(ax1,samples(i).x,samples(i).rho,samples(i).rho_err,'k--',HandleVisibility="off")
end

set(ax1,"YScale","log")
grid(ax1,"on")
legend(ax1,"Location","east")
%%
CM = jet(256);
range = [samples.rho];
% colorbar(ax2);

clim(ax2,[min([samples.rho]),max([samples.rho])])

for i = 1:3
    CM_idx = floor(rescale(log([samples(i).rho]),1,256,...
        InputMax=log(max(range)),...
        InputMin=log(min(range))));
    scatter(ax2,[samples(i).x],[samples(i).x3],repmat(36,size([samples(i).x])),CM(CM_idx,:),...
        "LineWidth",2,...
        "Marker",symb(i),...
        "DisplayName",o(i))

    cb = colorbar(ax2);
    legend(ax2,"location","south");
    set(ax2,"ColorScale","log","Colormap",CM)
    clim(ax2,[min(range),max(range)])
end
xlabel("energy density (J/cm^2)")
ylabel(char(969)+"-FWHM (°)")
cb.Label.String = "\rho (\Omegam)";
cb.Label.FontSize = 12;
grid(ax2,"on");

delete(get(ax1,"Parent"))