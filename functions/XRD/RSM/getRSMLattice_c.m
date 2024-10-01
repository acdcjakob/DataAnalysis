function lattice = getRSMLattice_c(IdTable)
% lattice = getRSMLattice_c(IdTable) gives relevant parameters from a
% complete RSM scan series

id = IdTable.Id;
    j = 1;
    % 02.10
    lit{j} = getSapphireVector([0 0 2],[0 0 10]);
    j = j+1;
    % 006
    lit{j} = getSapphireVector([0 0 0],[0 0 6]);
    j = j+1;
    
    % 
    % plane = ["cPar1","cPar0","cPerp0"];
    % 
    % % <lit> are the substrate literature values
    % % <sub> are the substrate peaks
    % % <film> are the thin film peaks
    % % <cor> are the thin film peaks corrected to the substrate lit. values
    % 
    % % --- correction of the substrate peak ---
    % for i = 1:3
    %     [sub{i},film{i}] = getRSMData(id,plane(i)); % read the extracted peak locations
    %     [cor{i}(1,1),cor{i}(2,1)] = ...
    %         correctReciprocalData(film{i}(1),film{i}(2),lit{i},sub{i}); % correct the peak locations
    % end
    % 
    % % --- correction of the thin film tilt ---
    % if ~isnan(cor{2}) & ~isnan(cor{3})
    %     tiltAngle_cPar = getTiltAngle(cor{2});
    %     tiltAngle_cPerp = getTiltAngle(cor{3});
    % 
    %     tiltMatrix_cPar = getTiltMatrix(-tiltAngle_cPar); % negative sign because we want to counter the tilt
    %     tiltMatrix_cPerp = getTiltMatrix(-tiltAngle_cPerp); % see above
    % 
    %     for i = 1:2
    %         cor{i} = tiltMatrix_cPar*cor{i};
    %     end
    %     for i = 3
    %         cor{i} = tiltMatrix_cPerp*cor{i};
    %     end
    % else
    %     warning("No tilt correction because of missing symmetric peak")
    % end
    % 
    % % for oop only take symmetric peak
    % d_outSym(1) = 1 / cor{2}(2);
    % d_outSym(2) = 1 / cor{3}(2);
    % lattice.d_outSym = mean(d_outSym);
    % lattice.err_d_outSym = std(d_outSym);
    % 
    % 
    % lattice.d_inAs = 1 / abs(cor{1}(1));
    % lattice.d_outAs = 1 / abs(cor{1}(2));
    % 
    % if exist("tiltAngle_cPar","var")
    %     lattice.tiltAngle_cPar = tiltAngle_cPar;
    %     lattice.tiltAngle_cPerp = tiltAngle_cPerp;
    % else
    %     lattice.tiltAngle_cPar = NaN;
    %     lattice.tiltAngle_cPerp = NaN;
    % end  
end

