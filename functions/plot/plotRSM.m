function h = plotRSM(sampleName,planeName,n,logLow,varargin)
% plotRSM(sampleName,planeName,n,logLow)
p = inputParser();

addRequired(p,"sampleName",@(x) true)
addRequired(p,"planeName",@(x) true)
addRequired(p,"n",@(x) true)
addRequired(p,"logLow",@(x) true)
addOptional(p,"M",eye(2),@(x) true)

parse(p,sampleName,planeName,n,logLow,varargin{:})

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
    if strcmp(p.UsingDefaults,"M")
        qx = q_perp{n};
        qy = q_parallel{n};
        intensity = data{n};
    else
        for i = 1:numel(q_perp{n})
            new = p.Results.M*[q_perp{n}(i);q_parallel{n}(i)];
            q_perp{n}(i) = new(1);
            q_parallel{n}(i) = new(2);
        end
        qx = q_perp{n};
        qy = q_parallel{n};
        intensity = data{n};
    end

    [~,h] = contourf(qx,qy,intensity,logspace(0,logLow,30),"LineStyle","none","HandleVisibility","off");
    set(gca,"Colorscale","log")
    hold on
end
hold off

end

