function TextLabels =  getTextLabel(hTick, textLabels, tickColors)
% TextLabels =  getTextLabel(hTick, textLabels, tickColors)
% Returns a text label structure which is in turn passed to the fancy axes
% that Mark wrote.
% 
% see also plotAxes
TextLabels.hTick = hTick;
TextLabels.textLabel = textLabels;
TextLabels.tickColor = tickColors;
