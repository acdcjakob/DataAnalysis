function [] = plotSingleMeasurementMultipleSamples(thisBatch,Messung)
%plotSingleMeasurementMultipleSamples(thisBatch,Messung)

% Finde alle Samples des Batches
sampleNames = searchSamples("Batch",thisBatch);

% Iteriere durch alle Samples
for idx = 1:length(sampleNames)

    % Ordnername des Samples
    pathSample = ".\"+sampleNames(idx);

    % Existieren schon Messungen?
    if isfolder(pathSample) == 0
        disp(pathSample+" existiert nicht")
        continue
    
    % Existiert die gewollte Messung?
    elseif isfolder(pathSample+"\"+Messung) == 0
        % check if there is a measurement folder
        disp("in "+pathSample+" gibt es keine Messungen")
        continue


    else
        % Erzeuge die Titelfolie für diese Messung
        createText(sampleNames(idx))
        exportgraphics(gcf,...
               ".\Batch_" ...
                   +thisBatch ...
                   +"_" ...
                   +string( datetime("now",'Format','yy-MM-dd(HH.mm)')) ...
                   +".pdf",...
               'Append',true)
        axes

        % Alle Messungen dieser Art für dieses Sample
        FileNames = getFileNamesFromFolder(pathSample+"\"+Messung);
        
        % Iteriere durch alle Einzelmessungen
        for idx2 = 1:length(FileNames)
           currentFileName = pathSample+"\"+Messung+"\"+FileNames(idx2); 
           
           % Funktion plottet das aktuelle File
           eval(Messung,'(',currentFileName,')')
           
           % Verleiht dem Plot den Titel des Filenames
           [~, NAME, ~] = fileparts(currentFileName);
           title(sampleNames(idx)+": "+NAME,'Interpreter','none')
           
           % Füge den Plot ein
           exportgraphics(gcf,...
               ".\Batch_" ...
                   +thisBatch ...
                   +"_" ...
                   +string( datetime("now",'Format','yy-MM-dd(HH.mm)')) ...
                   +".pdf",...
               'Append',true)

        end
    end
       
end
end

