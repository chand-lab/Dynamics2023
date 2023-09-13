function plotComponents_S9(pcData)

tData=pcData.tData;
TrajIn= pcData.TrajIn;
TrajOut = pcData.TrajOut;
cValues= pcData.cValues;
tMin = pcData.tMin;
tMax=.6;

% plot the trajectories for S9
dimsToShow = [1:5];
whichDim = [1:15];
lW = 2;

f = figure('units','normalized','position',[0.2049 0.1292 0.6026 0.6394],'color',[1 1 1]);
aX(1) = axes('position',[0.05 0.55 0.22 0.4]);
aX(2) = axes('position',[0.35 0.55 0.22 0.4]);
aX(3) = axes('position',[0.65 0.55 0.22 0.4]);
aX(4) = axes('position',[0.05 0.09 0.22 0.4]);
aX(5) = axes('position',[0.35 0.09 0.22 0.4]);
aX(6) = axes('position',[0.65 0.09 0.22 0.4]);


MinMax = [];




for z=1:9
    compCnt = 1;

    for f= dimsToShow
        axes(aX(compCnt));
        set(gca,'visible','off');

        li = plot(tData{z}*1000', TrajIn{z}(:,f)'); hold on;
        set(li,'color',cValues(z,:),'linestyle','-');

        li = plot(tData{z}*1000', TrajOut{z}(:,f)'); hold on;
        set(li,'color',cValues(z,:),'linestyle','--');
        hold on;
        Temp = [ min([TrajIn{z}(:,f); TrajOut{z}(:,f)]) max([TrajIn{z}(:,f); TrajOut{z}(:,f)])];
        MinMax(z,compCnt,:) = Temp;
        compCnt = compCnt + 1;

    end

    Dist{z} = sqrt(sum([TrajIn{z}(:,whichDim) - TrajOut{z}(:,whichDim)].^2,2));
    axes(aX(6));
    hold on;
    li = plot(tData{z}*1000, Dist{z});
    set(li,'color',cValues(z,:));
end

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
    xTicks = [tMin*1000  200:200:500];
    xLims = [tMin*1000 tMax*1000];
    strValue = 'Cue';

    text(20,yLims(2)-0.5,sprintf('%3.2f%%',pcData.varExplained(z)));

    cTextLabels = getTextLabel(0,{strValue},{'b'});

    try
        yTicks = linspace(yLims(1),yLims(2),5);
        drawRestrictedLines(0,yLims,'lineStyle','--');
        if z == 4 || z == 5
            getAxesP(xLims, xTicks, 8.5, yLims(1), 'Time (ms)', yLims, yTicks, 90, xLims(1)-20, sprintf('X_%d', dimsToShow(z)),[1 1],cTextLabels);
        else
            getAxesP(xLims, xTicks, 2, yLims(1), '', yLims, yTicks, 90, xLims(1)-20, sprintf('X_%d', dimsToShow(z)),[1 1],cTextLabels);
        end
    catch
    end
    axis tight; axis square;
end


hold on;
set(gca,'visible','off');
distMinMax = [min(vertcat(Dist{:})), max(vertcat(Dist{:}))];
axis tight; axis square;

axes(aX(6));
yLims = floor([min(distMinMax(:,1))-1 max(distMinMax(:,2))]) ;
yTicks = [yLims(1) yLims(2)];
getAxesP(xLims, xTicks, 12.5, yLims(1), 'Time (ms)', yLims, yTicks, 100, xLims(1)-20, 'High D Distance',[1 1],cTextLabels);
drawRestrictedLines(0,yLims,'lineStyle','--');
axis tight; axis square;
set(gca,'visible','off');

end