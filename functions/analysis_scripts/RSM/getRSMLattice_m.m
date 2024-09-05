function lattice = getRSMLattice_m(IdTable)

id = IdTable.Id;
    j = 1;
    % 306
    lit{j} = getSapphireVector([0 0 6],[3 0 0]);
    j = j+1;
    % 300
    lit{j} = getSapphireVector([0 0 0],[3 0 0]);
    j = j+1;
    % 30m6
    lit{j} = getSapphireVector([0 0 6],[3 0 0]).*[-1;1];
    j = j+1;
    % 4m20
    lit{j} = getSapphireVector([1 -2 0],[3 0 0]);
    j = j+1;
    % 300b
    lit{j} = getSapphireVector([0 0 0],[3 0 0]);
    j = j+1;
    % 220
    lit{j} = getSapphireVector([-1 2 0],[3 0 0]).*[-1;1];
    j = j+1;
    
    plane = ["cPar1","cPar0","cPar2","cPerp1","cPerp0","cPerp2"];
    
    % <lit> are the substrate literature values
    % <sub> are the substrate peaks
    % <film> are the thin film peaks
    % <cor> are the thin film peaks corrected to the substrate lit. values

    % --- correction of the substrate peak ---
    for i = 1:6
        [sub{i},film{i}] = getRSMData(id,plane(i)); % read the extracted peak locations
        [cor{i}(1,1),cor{i}(2,1)] = ...
            correctReciprocalData(film{i}(1),film{i}(2),lit{i},sub{i}); % correct the peak locations
    end

    % --- correction of the thin film tilt ---
    
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

    % --- correction of the thin film shear ---

    shearAngle_cPar = getShearAngle(cor{1},cor{3});
    shearAngle_cPerp = getShearAngle(cor{4},cor{6});
    
    % V ... peak vector
    % R ... rotation matrix
    % +T ... translation operation to symmetric peak
    % 1) bring rotation center to origin
    %       V' = V-T
    % 2) rotate everything
    %       V' = RV
    % 3) translate back
    %       V' = V+T
    % So in total:
    %       V'  = (R(V-T))+T
    %       V'  = RV + (1-R)T
    %
    % check: pluggin in T should change nothing
    %       T'  = RT + (1-R)T = 1T = T

    if isnan(cor{2})
        sym_cPar = [mean([cor{1}(1),cor{3}(1)]);...
            mean([cor{1}(2),cor{3},2])];
    else
        sym_cPar = cor{2};
    end
    if isnan(cor{5})
        sym_cPerp = [mean([cor{4}(1),cor{6}(1)]);...
            mean([cor{4}(2),cor{6}(2)])];
    else
        sym_cPerp = cor{5};
    end


    for i = 1:3
        cor{i} = transformShear(cor{i},-shearAngle_cPar,sym_cPar);
    end
    for i = 4:6
        cor{i} = transformShear(cor{i},-shearAngle_cPerp,sym_cPerp);
    end
    
    if abs((cor{1}(2)-cor{3}(2)))>-0.01
        warning(id+": shear and tilt alignment not good")
    end


    

    
    a_out(1) = sqrt(12) / cor{1}(2);
    a_out(2) = sqrt(12) / cor{3}(2);
    a_out(3) = sqrt(12) / cor{4}(2);
    a_out(4) = sqrt(12) / cor{6}(2);
    lattice.a_out = mean(a_out);
    lattice.err_a_out = std(a_out);

    c_in(1) = 6 / cor{1}(1);
    c_in(2) = 6 / cor{3}(1);
    lattice.c_in = mean(abs(c_in));
    lattice.err_c_in = std(abs(c_in));
    
    a_in(1) = 2 / cor{4}(1);
    a_in(2) = 2 / cor{6}(1);
    lattice.a_in = mean(abs(a_in));
    lattice.err_a_in = std(abs(a_in));
    
end

