function cm = linePainterName(name,n)

if strcmp(name,"greenPink")
    cm = linePainterMap([.2 .7 .2],[.8 .2 .6],n);
elseif strcmp(name,"pinkGreen")
    cm = linePainterMap([.8 .2 .6],[.2 .7 .2],n);
elseif strcmp(name,"redBlue")
    cm = linePainterMap([.8 .2 .2],[.2 .1 .7],n);
end

end

