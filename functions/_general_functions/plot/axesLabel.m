function output = axesLabel(input)
load("PLOTCONSTANT.mat","LABELS_TEX")
if isempty(find(LABELS_TEX(:,1)==input))
    output = input;
    return
end

output = LABELS_TEX(find(LABELS_TEX(:,1)==input),2);
end

