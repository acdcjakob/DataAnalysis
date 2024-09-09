function [output] = getRSMLattice(IdTable)
% [a,b,...] = getRSMLattice(IdTable) where IdTable can also be only Id
% String (calls searchSamples); outputs are lattice constants depending on
% orientation of sample

if ~istable(IdTable)
    IdTable = searchSamples_v2({{"Id",IdTable}},true);
end



if strcmp(IdTable.Sub,"m-Al2O3") % --- m-Al2O3 ---
    output = getRSMLattice_m(IdTable);
    return
elseif strcmp(IdTable.Sub,"a-Al2O3")% --- a-Al2O3 ---
    output = getRSMLattice_a(IdTable);
    return
elseif strcmp(IdTable.Sub,"r-Al2O3")% --- r-Al2O3 ---
    output = getRSMLattice_r(IdTable);
end

end