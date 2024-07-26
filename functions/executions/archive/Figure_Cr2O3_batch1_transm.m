addpath(genpath("DataAnalysis"))

dontAskUser = 1;
figure1 = figure;


% --- 1st plot ---
% subplot(2,1,1)

Specs_Transmission.plotVis = true;
Specs_Transmission.idx = 1;
Specs_Transmission.property1 = 'Batch';
Specs_Transmission.value1 = 'Cr2O3_initial';
Specs_Transmission.property2 = '';
Specs_Transmission.value2 = '';
plotTransmission

%%

for i = 1:numel(H)
    Y = H(i).YData*0.01; % percent to number
    Y(Y<=0)=nan;
    H(i).YData = log(Y) / (SampleData.d(i)); % log() / nm
end
delete(P);
ylabel("log(T) \times d^{-1} (nm^{-1})")
ylim([-0.08 0]);
xlim([250 1000]);
legend("Location","southeast")
FIT = polyfit(x(x>300&x<400),y(x>300&x<400),1);
F = plot(x(x>300&x<400),polyval(FIT,x(x>300&x<400)));
F.LineWidth = 2;
F.LineStyle = ":";
F.Color = [.2 .2 .8];
F.DisplayName = "linear fit "+num2str(FIT(1));
title("Absorption coefficient");