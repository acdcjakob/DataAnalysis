function plotRSM(sampleName,planeName,n,logLow)
% plotRSM(sampleName,planeName,n,logLow)

fileName = strcat('RSM_data_',sampleName,'_',planeName,'.mat');
load(fileName)
arrow = repmat("",[numel(data),1]);
arrow(n) = "<---";
if isrow(readme)
    readme=transpose(readme);
end

disp([readme arrow]);
n(n>numel(data))=numel(data);
if numel(n)>numel(data)
    n(numel(data)+1:end) = [];
end

for n = n
    qx = q_perp{n};
    qy = q_parallel{n};
    intensity = data{n};
    contourf(qx,qy,intensity,logspace(0,logLow,30),"LineStyle","none")
    set(gca,"Colorscale","log")
    hold on
end
hold off

end

