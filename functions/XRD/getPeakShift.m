function output = getPeakShift(IdInput,varargin)
%GETPEAKSHIFT(Id) recognizes the substrate of the sample and calculates the
%respective shift
%   getPeakShift(___,"relative",true) gives the relative shift to
%   literature value (plane distances)
%   getPeakShift(___,"Lattice",true) gives the lattice constant
%   getPeakShift(___,"TableInput",true) accepts a searchSamples-output as
%   input

p = inputParser();
addRequired(p,"Id",@(x) true)
addParameter(p,"Relative",false,@(x) islogical(x))
addParameter(p,"Lattice",false,@(x) islogical(x))
addParameter(p,"TableInput",false,@(x) true)
parse(p,IdInput,varargin{:})

if p.Results.TableInput
    sampleTable = IdInput;
else
    sampleTable = searchSamples_v2({{"Id",IdInput}},true);
    sampleTable = sampleTable(1,:);
        % if more entries in database #W6723 :b
end

for idx = 1:numel(sampleTable.Id(:))
    Id = sampleTable.Id{idx};
    folderPath = fullfile("data",Id,"XRD_2ThetaOmega");
    fileName = getFileNamesFromFolder(folderPath,".TXT");
    filePath = fullfile(folderPath,fileName);
    
    T = createLegitTableFromHighScore(filePath);
    if T.h(1)==0 & T.k(1)==2 & T.l(1)==4
        planeShort = 'r2';
    else
        temp = char(sampleTable.Sub{idx});
        planeShort = temp(1); clear temp
            % 'm-Al2O3' -> 'm' etc.
    end
    
    % get the substrate-corrected peak data
    [shift,theta] = ...
        peakPositionNormed(T,{"Cr2O3","Al2O3"},planeShort); % degree
    
    if p.Results.Relative
        % calculating the relative shift by first transforming into the
        % "plane distance space":
        %
        % n*lambda = 2dsin(2theta/2) % Bragg equ.
        % d = n*lambda/2 * 1/sin(2theta/2)
        % -> (d'-d)/d
        %   = [ 1/sin(2theta'/2) - 1/sin(2theta/2) ] * sin(2theta/2)
        %
        % This differs from just (theta'-theta)/theta
        
        t = get2Theta(hkl_conv_arr(planeShort),"Cr2O3");
        % t = literature(planeShort);
        tPrime = theta;
        output(idx) = (1/sind(tPrime/2)-1/sind(t/2))*sind(t/2);
        fprintf( ...
        "\tRelative peak shift for "+Id+": "+num2str(output(idx),"%.4f")+"\n");
    elseif p.Results.Lattice
        K = 1.5406; % angstrom
        d = K*1/(2*sin(theta/2*pi/180));
        if strcmp(planeShort,'c')
            c = 6*d;
            output(idx) = c;
        elseif strcmp(planeShort,'m')
            a = sqrt(12)*d;
            output(idx) = a;
        elseif strcmp(planeShort,'r')
            ratio = 13.593/4.958; 
            a = 2*d*sqrt(1/3+1/ratio^2);
            output(idx) = a;
            % output = d;
        elseif strcmp(planeShort,'r2')
            ratio = 13.593/4.958; 
            a = 4*d*sqrt(1/3+1/ratio^2);
            output(idx) = a;
            
            % output = d*2; % because (02.4) is the second harmonic
        elseif strcmp(planeShort,'a')
            a = 2*d;
            output(idx) = a;
        end
    else
        output(idx) = shift;
        fprintf( ...
        "\tPeak shift for "+Id+": "+string(output(idx))+"\n");
    end

end

function output = hkl_conv_arr(name)
    if strcmp(name,"c")
        output = [0 0 6];
    elseif strcmp(name,"m")
        output = [3 0 0];
    elseif strcmp(name,"r")
        output = [0 1 2];
    elseif strcmp(name,"a")
        output = [1 1 0];
    elseif strcmp(name,"r2")
        output = [0 2 4];
    end
end

% function output = literature(name)
%     [Cr2O3_peaks] = getPeakReference();
%     if strcmp(name,"c")
%         output = Cr2O3_peaks(1);
%     elseif strcmp(name,"m")
%         output = Cr2O3_peaks(2);
%     elseif strcmp(name,"r")
%         output = Cr2O3_peaks(3);
%     elseif strcmp(name,"a")
%         output = Cr2O3_peaks(4);
%     elseif strcmp(name,"r2")
%         output = Cr2O3_peaks(5);
%     end
% end

end

