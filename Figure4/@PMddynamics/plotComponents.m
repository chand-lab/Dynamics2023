function [dataTable] = plotComponents(r, varargin)
% plots specified components and also euclidean distance for choice
%
% Chand, 30 Mar 2022
TrajIn = r.signalplusnoise.TrajIn;
TrajOut = r.signalplusnoise.TrajOut;
tData = r.signalplusnoise.tData;
project=0;
assignopts(who,varargin)
cValues = r.metaData.condColors;
dimsToShow = [1:5];
whichDim = [1:r.metaData.nDims];
lW = 2;

f = figure('units','normalized','position',[0.2049 0.1292 0.6026 0.6394],'color',[1 1 1]);
aX(1) = axes('position',[0.05 0.55 0.22 0.4]);
aX(2) = axes('position',[0.35 0.55 0.22 0.4]);
aX(3) = axes('position',[0.65 0.55 0.22 0.4]);
aX(4) = axes('position',[0.05 0.09 0.22 0.4]);
aX(5) = axes('position',[0.35 0.09 0.22 0.4]);
aX(6) = axes('position',[0.65 0.09 0.22 0.4]);

V = r.signalplusnoise.varExplained;
MinMax = [];



bigData = [];
bigDist = [];

vNames = {'time'};
for z=1:length(tData)
    compCnt = 1;
    
    for f= dimsToShow
        axes(aX(compCnt));
        set(gca,'visible','off');
        li = plot(tData{z}*1000', TrajIn{z}(:,f)'); hold on;
        set(li,'color',cValues(z,:));
        li = plot(tData{z}*1000', TrajOut{z}(:,f)'); hold on;
        set(li,'color',cValues(z,:),'linestyle','--');
        hold on;
        Temp = [ min([TrajIn{z}(:,f); TrajOut{z}(:,f)]) max([TrajIn{z}(:,f); TrajOut{z}(:,f)])];
        MinMax(z,compCnt,:) = Temp;
        compCnt = compCnt + 1;
        %                     if z==1
        %                         text(20,12.5,sprintf('%3.2f%%',V(f)));
        %                     end
        if z==1
            vNames{compCnt} = sprintf('Dim%d',f);
            
        end
    end
    
    currData1 = [tData{z}' TrajIn{z}(:,dimsToShow)];
    currData1(:,end+1) = z;
    currData1(:,end+1) = 1;
    
    
    currData2 = [tData{z}' TrajIn{z}(:,dimsToShow)];
    currData2(:,end+1) = z;
    currData2(:,end+1) = 2;
    
    
    bigData = [bigData; currData1; currData2];
    
    
    
    DistV = r.distance(z).V;
    DistV(DistV > 300) = NaN;
    
    axes(aX(6));
    hold on;
    [pa,li] = ShadedError(tData{z}*1000, nanmean(DistV), nanstd(DistV));
    set(li,'color',cValues(z,:));
    
    tempT = tData{z}*1000;
    tIds = tempT > 125 & tempT < 375;
    
    dVal(z) = nanmean(nanmean(DistV(:,tIds)),2);
    
    Dist{z} = nanmean(DistV);
    
    currD = [Dist{z}' tData{z}'];
    currD(:,end+1) = z;
    
    bigDist = [bigDist; currD];
    distMinMax(z,:) = [min(Dist{z}), max(Dist{z})];
end
vNames{end+1} = 'Id';
vNames{end+1} = 'Choice';



dataTable.components = array2table(bigData, 'VariableNames',vNames);
dataTable.distance = array2table(bigDist, 'VariableNames',{'time','Distance','Id'});


[rV,pV, rL, rU] = corrcoef(nanmean(r.metaData.RTlims(:,r.metaData.whichConds))', dVal');

fprintf('\n %3.2f (%3.2f - %3.2f), p = %3.4e', rV(1,2), rL(1,2), rU(1,2), pV(1,2));


S1 = MinMax(:,:,1);
S1 = S1(:);


S2 = MinMax(:,:,2);
S2 = S2(:);

yLims = [floor(min(S1(:))) ceil(max(S2(:)))];

maxValues = 0;
% Now clean up the axes on it.
for z=1:5
    axes(aX(z));
    str1 = sprintf('Component : %d', dimsToShow(z));
    tMin = r.metaData.tMin;
    xTicks = [tMin*1000  200:200:500];
    xLims = [tMin*1000 r.metaData.tMax*1000];
    strValue = 'Check';
    
    if project ==0
    text(20,yLims(2)-0.5,sprintf('%3.2f%%',V(z)));
    else
        %
    end
    
    cTextLabels = getTextLabel(0,{strValue},{'b'});
    
    try
        yTicks = yLims;
        drawRestrictedLines(0,yLims,'lineStyle','--');
        if z == 4 || z == 5
            getAxesP(xLims, xTicks, 8.5, yLims(1), 'Time (ms)', yLims, yTicks, 0, xLims(1)-20, sprintf('X_%d', dimsToShow(z)),[1 1],cTextLabels);
        else
            getAxesP(xLims, xTicks, 2, yLims(1), '', yLims, yTicks, 0, xLims(1)-20, sprintf('X_%d', dimsToShow(z)),[1 1],cTextLabels);
        end
    catch
    end
    axis tight; axis square;
end


hold on;
set(gca,'visible','off');


axis tight; axis square;

axes(aX(6));
yLims = floor([min(distMinMax(:,1))-1 max(distMinMax(:,2))]) ;
yTicks = [yLims(1) yLims(2)];
getAxesP(xLims, xTicks, 12.5, yLims(1), 'Time (ms)', yLims, yTicks, 100, xLims(1)-20, 'High D Distance',[1 1],cTextLabels);
drawRestrictedLines(0,yLims,'lineStyle','--');
axis tight; axis square;
set(gca,'visible','off');

end
