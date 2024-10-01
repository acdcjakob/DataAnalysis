IdTable = searchSamples_v2({{'Batch','Cr2O3_energy';'Transmission','y'}},true);
IdTable = sortrows(IdTable,"NameVal");

cs = linePainterMap([.2 .8 .2],[.8 .2 .8],numel(IdTable.Id));
for i = 1:numel(IdTable.Id)
    [E{i},T{i}] = getTransmission(IdTable.Id{i});
    T{i}(T{i}<=0)=nan;
    % h = plot(E{i},T{i})
    alpha{i} = -1*log(T{i})./(IdTable.d(i)*1e-7); % cm^-1
    % h = plot(E{i},alpha{i})

    exponent = 2;

    tauc{i} = (alpha{i}.*E{i}).^exponent;
    h = plot(E{i},tauc{i});
    
    h.DisplayName = IdTable.Id{i}+", "+num2str(IdTable.d(i))+"nm, L = "+IdTable.NameVal{i}+"cm";
    h.LineWidth = 1;
    h.Color = cs(i,:);
    hold on
    legend

    H(i) = h;
end

set(gca,"box","on","linewidth",1)
xlabel("{\itE} (eV)")
ylabel("(\alpha*E)^{"+num2str(exponent)+"} (nm^{-1} eV)^{"+num2str(exponent)+"}")
grid

for i = 1:numel(IdTable.Id)
    
end