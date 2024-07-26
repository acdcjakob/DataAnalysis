function output = getPeakShift(IdInput,varargin)
%GETPEAKSHIFT(Id) recognizes the substrate of the sample and calculates the
%respective shift
%   getPeakShift(___,"relative",true) gives the relative shift to
%   literature value
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
        % if more entries in database
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
        planeShort = char(sampleTable.Sub{idx}(1));
            % 'm-Al2O3' -> 'm' etc.
    end
    
    [shift,theta] = peakPositionNormed(T,{"Cr2O3","Al2O3"},planeShort); % degree
    
    if p.Results.Relative
        output(idx) = shift / literature(planeShort);
        fprintf( ...
        "\tRelative peak shift for "+Id+": "+string(output)+"\n");
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


function output = literature(name)
    [Cr2O3_peaks] = getPeakReference();
    if strcmp(name,"c")
        output = Cr2O3_peaks(1);
    elseif strcmp(name,"m")
        output = Cr2O3_peaks(2);
    elseif strcmp(name,"r")
        output = Cr2O3_peaks(3);
    elseif strcmp(name,"a")
        output = Cr2O3_peaks(4);
    elseif strcmp(name,"r2")
        output = Cr2O3_peaks(5);
    end
end

end

