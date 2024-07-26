function [] = createText(Text)
% createText(Text) erzeugt einfach eine Fläche 400x400 welche Text enthält

if (isstring(Text)||ischar(Text)||iscellstr(Text)) == false
    disp("ERROR: Input zu createText muss String oder char sein!")
    return
end

FONTSIZE = 25;
FIGURESIZE = [400 400];

% Create a figure without axes
hFig = figure('NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', 'DockControls', 'off', 'Resize', 'off');

% Create an axes object with no labels, ticks, or other decorations
hAx = axes('Parent', hFig, 'Position', [0 0 1 1]);
axis(hAx, 'off');

% Add the Text to the center of the figure
text('String', Text, 'Parent', hAx, 'FontSize', FONTSIZE,...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle',...
    'Position', [0.5, 0.5]);

% Adjust the figure size to fit the text
figPos = get(hFig, 'Position');
% textPos = get(hAx, 'Position');
figPos(3:4) = FIGURESIZE;
set(hFig, 'Position', figPos);
end