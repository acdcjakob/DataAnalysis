folder = "Cr2O3_CuO_CompVar1/r-Al2O3";
paths = dir(folder+"/*.TXT");
data = cell([]);
for i = 1:numel(paths)
    data{i,1} = paths(i).name;
    data{i,2} = createLegitTable(fullfile(paths(i).folder,paths(i).name));
end, clear i;

% row is the sample, and values are idx of the peak
% 1st column is Cr (012)
% 2nd column i s Cr (024)
% 3rd Cr (036)
% 4th Cr (048)

Cr_peaks = [...
    1,3,7,0;
    1,4,8,0;
    1,4,8,0;
    1,4,8,0;
    1,4,8,0;
    1,3,0,0
    ];

Cr_names = {'(012)';'(024)';'(036)';'(048)'};
Cr_position = [24.5067, 50.2343, 79.0932, 116.193];

for i = 1:numel(data(:,1))
    T = data{i,2};
    for i_peak = 1:numel(Cr_names)
        if Cr_peaks(i,i_peak) == 0
            pos(i,i_peak) = NaN;
        else
            pos(i,i_peak) = T.Pos(Cr_peaks(i,i_peak))-Cr_position(i_peak);
        end
    end
end

for i = 1:numel(data(:,1))
    T = data{i,2};
    for i_peak = 1:numel(Cr_names)
        if Cr_peaks(i,i_peak) == 0
            intensity(i,i_peak) = NaN;
        else
            intensity(i,i_peak) = T.I(Cr_peaks(i,i_peak));
        end
    end
    intensity(i,:) = intensity(i,:)./max(intensity(i,:));
end

NameVal = [4,5,6,3,7,8].';

%% angles
subplot(2,1,1)
diff = sortrows([NameVal,pos(:,1)]);
h = plot(diff(:,1),diff(:,2),'o--');
h.DisplayName = "(012) Cr2O3";
hold on

diff = sortrows([NameVal,pos(:,2)]);
h = plot(diff(:,1),diff(:,2),'o--');
h.DisplayName = "(024) Cr2O3";

hold on

diff = sortrows([NameVal,pos(:,3)]);
h = plot(diff(:,1),diff(:,2),'o--');
h.DisplayName = "(036) Cr2O3";

hold on

diff = sortrows([NameVal,pos(:,4)]);
h = plot(diff(:,1),diff(:,2),'o--');
h.DisplayName = "(048) Cr2O3";

legend
hold off
h.Parent.XTick = sort(NameVal);
xlabel("y @VCCS")
ylabel("shift in 2\theta\Omega to literature (deg)")
title("r-oriented Cr_2O_3")
%% intensity

subplot(2,1,2)

relInt = sortrows([NameVal,intensity(:,1)]);
h = plot(relInt(:,1),relInt(:,2),'o--');
h.DisplayName = "(012) Cr2O3";
hold on

relInt = sortrows([NameVal,intensity(:,2)]);
h = plot(diff(:,1),relInt(:,2),'o--');
h.DisplayName = "(024) Cr2O3";
hold on

relInt = sortrows([NameVal,intensity(:,3)]);
h = plot(diff(:,1),relInt(:,2),'o--');
h.DisplayName = "(036) Cr2O3";
hold on

relInt = sortrows([NameVal,intensity(:,4)]);
h = plot(diff(:,1),relInt(:,2),'o--');
h.DisplayName = "(048) Cr2O3";
hold on


legend
h.Parent.YScale = "log";
h.Parent.XTick = sort(NameVal);
xlabel("y @VCCS")
ylabel("relative intensity to max peak")
hold off

% subplot(4,1,1);
% h = scatter(NameVal,pos(:,1));
% 
% h.Parent.XTick = sort(NameVal);
% ylabel("difference to literature");
% xlabel("y @VCCS")
% title("(012) Cr_2O_3")
% 
% subplot(4,1,2);
% h = scatter(NameVal,pos(:,2));
% h.Parent.XTick = sort(NameVal);
% ylabel("difference to literature");
% xlabel("y @VCCS")
% title("(024) Cr_2O_3")
% 
% subplot(4,1,3);
% h = scatter(NameVal,pos(:,3));
% h.Parent.XTick = sort(NameVal);
% ylabel("difference to literature");
% xlabel("y @VCCS")
% title("(036) Cr_2O_3")
% 
% subplot(4,1,4);
% h = scatter(NameVal,pos(:,4));
% h.Parent.XTick = sort(NameVal);
% ylabel("difference to literature");
% xlabel("y @VCCS")
% title("(048) Cr_2O_3")
% 
