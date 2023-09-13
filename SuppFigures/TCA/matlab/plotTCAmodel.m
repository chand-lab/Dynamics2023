function plotTCAmodel(modelToUse,tAxis,whichT)

model = modelToUse;
fullData = full(model);
Xticks = {[1:5:size(fullData,1)],[tAxis(whichT)],[1:100:size(fullData,3)]};
[Info, dataV] = viz_ktensor(model, ...
    'Plottype', {'bar', 'line', 'scatter'}, ...
    'Modetitles', {'neurons', 'time', 'trials'},'PlotColors',{[0.1 0.1 .9],[1 0 0],[0.2 .8 0.2]});

set(Info.FactorAxes(2,4),'Xtick',[1:4:length(whichT)],'XTickLabel',tAxis(whichT(1:4:length(whichT))),'box','off');
ax = Info.FactorAxes(2,4);
axes(ax);
drawLines(13);

fNames = {'Neurons','Time','Trials'};

vNames = {'ID1','D1','ID2','D2','ID3','D3','ID4','D4'};

for nF = 1:3
    currD = [dataV(nF).Factors];
    TCAtable.(fNames{nF}) =  array2table(horzcat(currD.V), 'VariableNames',vNames);
end

end