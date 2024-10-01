originFolder = pwd;
cd("C:\Users\acdcj\Documents\_MasterThesis\DataAnalysis");

m_plot = 2;
n_plot = 2;
%% --- c sapphire ---
A1 = subplot(m_plot,n_plot,1);
%%
%time to dock
%save cuts in file
cuts = [0 32;46 77;94 130];
filename = "temp"+date+".mat";
save(filename,"cuts");
    
plotXRD_v3
delete(filename);
title("CuO c-Sapphire")
A1.XGrid = "on";
legend(A1);
n = numel(A1.Children);
for i = 1:n
    A1.Children(i).Color = ...
        [1-i/n 1-i/(2*n) i/n];
end


%% --- m sapphire ---
A2 = subplot(m_plot,n_plot,2);
%%
cuts = [0 43;45 58; 72 140];
filename = "temp"+date+".mat";
save(filename,"cuts");

plotXRD_v3
delete(filename);
title("CuO m-Sapphire")
A2.XGrid = "on";
legend(A2);
n = numel(A2.Children);
for i = 1:n
    A2.Children(i).Color = ...
        [1-i/n 1-i/(2*n) i/n];
end

%% --- r sapphire ---
A3 = subplot(m_plot,n_plot,3);
%%
cuts = [0 22;28 42; 57 75; 86 112];
filename = "temp"+date+".mat";
save(filename,"cuts");

plotXRD_v3
delete(filename);
title("CuO r-Sapphire")
A3.XGrid = "on";
legend(A3);
n = numel(A3.Children);
for i = 1:n
    A3.Children(i).Color = ...
        [1-i/n 1-i/(2*n) i/n];
end

%% --- a sapphire ---
A4 = subplot(m_plot,n_plot,4);
%%
cuts = [0 27; 41 70; 85 115; 125 135];
filename = "temp"+date+".mat";
save(filename,"cuts");

plotXRD_v3
delete(filename);
title("CuO a-Sapphire")
A4.XGrid = "on";
legend(A4);
n = numel(A4.Children);
for i = 1:n
    A4.Children(i).Color = ...
        [1-i/n 1-i/(2*n) i/n];
end

sgtitle("Cr_2O_3:CuO (varying Laser Position during PLD)")