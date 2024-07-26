function [output] = getRSMLattice(IdTable)

if strcmp(IdTable.Sub,"m-Al2O3")
    id = IdTable.Id;
    % 306
    lit{1} = getSapphireVector([0 0 6],[3 0 0]);
    % 30m6
    lit{2} = getSapphireVector([0 0 6],[3 0 0]).*[-1;1];
    % 4m20
    lit{3} = getSapphireVector([1 -2 0],[3 0 0]);
    % 220
    lit{4} = getSapphireVector([-1 2 0],[3 0 0]).*[-1;1];

    [sub{1},film{1}] = getRSMData(id,"cPar1");
    [sub{2},film{2}] = getRSMData(id,"cPar2");
    [sub{3},film{3}] = getRSMData(id,"cPerp1");
    [sub{4},film{4}] = getRSMData(id,"cPerp2");
    
    for i = 1:4
        [cor{i}(1,1),cor{i}(2,1)] = correctReciprocalData(film{i}(1),film{i}(2),lit{i},sub{i});
    end
    
    % tilt correction for both directions
    Psi = -1*(cor{1}(2)-cor{2}(2))/(cor{1}(1)-cor{2}(1));
    filmOut = sin(Psi)*cor{1}(1)+cos(Psi)*cor{1}(2);
    filmIn = cos(Psi)*cor{1}(1)-sin(Psi)*cor{1}(2);
    lattice_out_cPar = sqrt(12) / filmOut;
    lattice_in_cPar = 6 / filmIn;

    Psi = -1*(cor{3}(2)-cor{4}(2))/(cor{3}(1)-cor{4}(1));
    filmOut = sin(Psi)*cor{3}(1)+cos(Psi)*cor{3}(2);
    filmIn = cos(Psi)*cor{3}(1)-sin(Psi)*cor{3}(2);
    lattice_out_cPerp = sqrt(12) / filmOut;
    lattice_in_cPerp = 2 / filmIn;

    output = [lattice_out_cPar,lattice_in_cPar,...
        lattice_out_cPerp,lattice_in_cPerp];
    return
end

end

