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
    id = IdTable.Id;
    % 226
    lit{1} = getSapphireVector([0 0 6],[2 2 0]);
    % 22m6
    lit{2} = getSapphireVector([0 0 -6],[2 2 0]).*[-1;1];
    % 300
    lit{3} = 1.5*getSapphireVector([1 -1 0],[1 1 0]);
    % 030
    lit{4} = 1.5*getSapphireVector([-1 1 0],[1 1 0]).*[-1;1];

    [sub{1},film{1}] = getRSMData(id,"cPar1");
    [sub{2},film{2}] = getRSMData(id,"cPar2");
    [sub{3},film{3}] = getRSMData(id,"cPerp1");
    [sub{4},film{4}] = getRSMData(id,"cPerp2");
    
    plane = ["cPar1","cPar2","cPerp1","cPerp2"];
    for i = 1:4
        [sub{i},film{i}] = getRSMData(id,plane(i));
        [cor{i}(1,1),cor{i}(2,1)] = correctReciprocalData(film{i}(1),film{i}(2),lit{i},sub{i});
    end
    
    % correct tilt
    % c parallel
    Psi = -1*(cor{1}(2)-cor{2}(2))/(cor{1}(1)-cor{2}(1));
    filmOut = sin(Psi)*cor{1}(1)+cos(Psi)*cor{1}(2);
    filmIn = cos(Psi)*cor{1}(1)-sin(Psi)*cor{1}(2);
    lattice_out_cPar = 4 / filmOut;
    lattice_in_cPar = 6 / filmIn;

    % c perpendicular
    Psi = -1*(cor{3}(2)-cor{4}(2))/(cor{3}(1)-cor{4}(1));
    filmOut = sin(Psi)*cor{3}(1)+cos(Psi)*cor{3}(2);
    filmIn = cos(Psi)*cor{3}(1)-sin(Psi)*cor{3}(2);
    lattice_out_cPerp = 2 / filmOut * 1.5;
    lattice_in_cPerp = 2/sqrt(3) / filmIn * 1.5;
    output = [lattice_out_cPar,...
        lattice_in_cPar,...
        lattice_out_cPerp,...
        lattice_in_cPerp];
    return
end

end