function [E,T] = getTransmission(Id)

    files(1) = getFilePathsFromId(Id,"Transmission",".dx","filter",{{"ref"}});
    files(2) = getFilePathsFromId(Id,"Transmission",".dx","filter",{{Id}});
    
    for i = 1:2
        dataRaw{i} = readmatrix(files{i},...
            "FileType","text",...
            "CommentStyle","##");
    end

    lambdaRef = dataRaw{1}(:,1);
    lambdaSam = dataRaw{2}(:,1);
    IRef = dataRaw{1}(:,2);
    ISam = dataRaw{2}(:,2);
    
    [lambda,idxRef,idxSam] = intersect(lambdaRef,lambdaSam);

    T = ISam(idxSam) ./ IRef(idxRef); % in 100%

    h = 6.626e-34; % Js
    c = 299.792e6; % m/s
    e0 = 1.602e-19; % J
    E = h*c ./ (lambda*1e-9*e0); % eV
    
    % figure()
    %     plot(lambdaRef,IRef,DisplayName="reference")
    %     hold on
    %     plot(lambdaSam,ISam,DisplayName="sample")
    %     legend
    %     title(Id)
end
