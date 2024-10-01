function [] = WaferProberTransfer(FilePfad, PlotAlso)
%WaferProberTransfer(FilePfad) plottet I_d vs. V_g.
%    Falls anderes gegen Vg geplottet werden soll, ergänze zweites input argument


fid = fopen(FilePfad);
NumCol = 6;
DataRaw = textscan(fid,repmat('%f',[1,NumCol]),...
    'headerlines',2,...
    'delimiter','\t');

% create array
n = length(DataRaw{1,1});
Data = zeros(n,NumCol);
for i = 1:NumCol
    Data(:,i) = DataRaw{1,i}; 
end

% create table for readable variables
DataTable = array2table(Data,'VariableNames',...
    {'Vs','Is','Vd','Id','Vg','Ig'});

%% two axis
% yyaxis left
% semilogy(DataTable.Vg,abs(DataTable.Id))
%     xlabel('V_G (volts)')
%     ylabel('I_D (A)')
% yyaxis right
% semilogy(DataTable.Vg,abs(DataTable.Ig))
%     xlabel('V_G (volts)')
%     ylabel('I_G (A)')
% hold off

%% one axis
semilogy(DataTable.Vg,abs(DataTable.Id))
    xlabel('V_G (volts)')
    ylabel('I (A)')
if nargin > 1
    hold on
    PlotAlso = convertStringsToChars(PlotAlso);
    semilogy(DataTable.Vg,abs(eval(['DataTable.',PlotAlso])))
    hold off
    legend("I_D",PlotAlso)
else
    legend("I_D")
end

    
end

