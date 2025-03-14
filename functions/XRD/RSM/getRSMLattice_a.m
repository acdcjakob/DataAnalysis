function lattice = getRSMLattice_a(IdTable)
% lattice = getRSMLattice_a(IdTable) gives relevant parameters from a
% complete RSM scan series
%   ... in-plane a + error
%   ... in-plane c + error
%   ... oop a + error
%   ... tilt angles
%   ... shear angles

id = IdTable.Id;
    j = 1;
    % 226
    lit{j} = getSapphireVector([0 0 6],[2 2 0]);
    j = j+1;
    % 220
    lit{j} = getSapphireVector([0 0 0],[2 2 0]);
    j = j+1;
    % 22m6
    lit{j} = getSapphireVector([0 0 -6],[2 2 0]).*[-1;1];
    j = j+1;
    % 300
    lit{j} = getSapphireVector([1 -1 0],[1 1 0])*1.5;
    j = j+1;
    % 220
    lit{j} = getSapphireVector([0 0 0],[2 2 0]);
    j = j+1;
    % 030
    lit{j} = getSapphireVector([-1 1 0],[1 1 0]).*[-1;1]*1.5;
    j = j+1;
    
    plane = ["cPar1","cPar0","cPar2","cPerp1","cPerp0","cPerp2"];
    
    % <lit> are the substrate literature values
    % <sub> are the substrate peaks
    % <film> are the thin film peaks
    % <cor> are the thin film peaks corrected to the substrate lit. values

    % --- correction of the substrate peak ---
    for i = 1:6
        [sub{i},film{i}] = getRSMData(id,plane(i)); %#ok<*AGROW> % read the extracted peak locations
        [cor{i}(1,1),cor{i}(2,1)] = ...
            correctReciprocalData(film{i}(1),film{i}(2),lit{i},sub{i}); % correct the peak locations
    end

    % --- correction of the thin film tilt ---
    if ~isnan(cor{2}) & ~isnan(cor{5}) %#ok<AND2>
        tiltAngle_cPar = getTiltAngle(cor{2});
        tiltAngle_cPerp = getTiltAngle(cor{5});
        
        tiltMatrix_cPar = getTiltMatrix(-tiltAngle_cPar); % negative sign because we want to counter the tilt
        tiltMatrix_cPerp = getTiltMatrix(-tiltAngle_cPerp); % see above
        
        for i = 1:3
            cor{i} = tiltMatrix_cPar*cor{i};
        end
        for i = 4:6
            cor{i} = tiltMatrix_cPerp*cor{i};
        end
    else
        warning("No tilt correction because of missing symmetric peak")
    end

    % --- correction of the thin film shear ---

    shearAngle_cPar = getShearAngle(cor{1},cor{3});
    shearAngle_cPerp = getShearAngle(cor{4},cor{6});


    sym_cPar = [mean([cor{1}(1),cor{3}(1)]); ...
        mean([cor{1}(2),cor{3}(2)])];

    sym_cPerp = [mean([cor{4}(1),cor{6}(1)]); ...
        mean([cor{4}(2),cor{6}(2)])];

    for i = 1:3
        cor{i} = transformShear(cor{i},-shearAngle_cPar,sym_cPar);
    end
    
    for i = 4:6
        cor{i} = transformShear(cor{i},-shearAngle_cPerp,sym_cPerp);
    end
    
    if abs((cor{1}(2)-cor{3}(2)))>0.01
        warning(id+": shear and tilt alignment not good")
    end


    


    a_out(1) = 4 / cor{1}(2);
    a_out(2) = 4 / cor{3}(2);
    a_out(3) = 2 / cor{4}(2) * 1.5;
    a_out(4) = 2 / cor{6}(2) * 1.5;
    lattice.a_out = mean(a_out);
    lattice.err_a_out = std(a_out);

    c_in(1) = 6 / cor{1}(1);
    c_in(2) = 6 / cor{3}(1);
    lattice.c_in = mean(abs(c_in));
    lattice.err_c_in = std(abs(c_in));

    a_in(1) = 2/sqrt(3) / cor{4}(1) * 1.5;
    a_in(2) = 2/sqrt(3) / cor{6}(1) * 1.5;
    lattice.a_in = mean(abs(a_in));
    lattice.err_a_in = std(abs(a_in));

    if exist("tiltAngle_cPar","var")
        lattice.tiltAngle_cPar = tiltAngle_cPar;
        lattice.tiltAngle_cPerp = tiltAngle_cPerp;
    else
        lattice.tiltAngle_cPar = NaN;
        lattice.tiltAngle_cPerp = NaN;
    end

    lattice.shearAngle_cPar = shearAngle_cPar;
    lattice.shearAngle_cPerp = shearAngle_cPerp;
    
    
end

