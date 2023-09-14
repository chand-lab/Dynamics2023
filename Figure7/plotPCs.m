function Neurons = plotPCs(Neurons, varargin)
% plotPCs(Neurons)
%
% CC, Shenoylab, March 11th 2014
% CC, Shenoylab, March 12th 2014
% CC, Chandrasekaran Lab, May 11th 2020
%
subtractCCmean = false;
zScore=false;
meanSubtract = true;
useTuning = false;
softNorm = true;
reRun = false;
type = 'coherence';
dimsToShow = [1 2 3 4 5];
assignopts(who,varargin);

expression = '(x <=tStart).*base + (x >tStart).*(base + slope*(x - tStart))';
g = fittype(expression,'coeff',{'tStart','base','slope'},'indep','x');


switch(type)
    case 'coherence'
        
        
        if ~isfield(Neurons.coherence,'pcModel') | reRun
            Neurons.coherence = PCAbyCoherence(Neurons.coherence, 'subtractCCmean', subtractCCmean,...
                'zScore', zScore, 'meanSubtract', meanSubtract, 'useTuning',useTuning, 'softNorm',softNorm);
        end
        model = Neurons.coherence.pcModel;
        params = getParams;
        t = Neurons.coherence.tS;
        I = squeeze(nanmin(Neurons.coherence.RTall,[],2));
        O = nanmedian(I);
        conds = [ 1 2 3 4 5 6 7];
        dimsToShow
        ColVals = repmat([0 0.5 0.55 0.6 0.65 0.72 0.84]',1,3);
        [DistV, dataTable.distance] = plotComponents(model, conds,ColVals,O,'checkerboard','dimsToShow',dimsToShow);
        
        dimsToShow
        
        dataTable.trajectories = plotTrajectories(model, conds,ColVals, 'checkerboard',[1 1],'dimsToShow', dimsToShow);
        
        
        
        fileName = '/net/home/chand/code/Dynamics2023/SourceData/SourceData.xls';
        writetable(dataTable.trajectories,fileName,'FileType','spreadsheet','Sheet','Fig.7a');
        writetable(dataTable.distance,fileName,'FileType','spreadsheet','Sheet','Fig.7b');
        
        
        bV = []; Xv = []; Y = [];
        
        for nX = 1:length(DistV)
            tS = [0:500];
            Y = DistV{nX}(100:600);
            FRv(nX) = Y(end);
            [R,goodness] = fit(tS',squeeze(double(Y)),g,'StartPoint',[150 3 0.2]);
            bV(nX,:) = coeffvalues(R);
            bVe(nX,:,:) = confint(R);
        end
        
        figure('color',[1 1 1]);
        subplot(121);
        Coh = params.coherence;
        errorbar(Coh, bV(:,3),abs(bV(:,3) - bVe(:,1,3)),abs(bV(:,3) - bVe(:,1,3)),'ko-'); hold on;
        yLims = [0 round([1000*1.1*max(bV(:,3))])/1000];
        xLims = [0 100];
        xTicks = [0 floor(Coh)' 100];
        [hP,vP] = getAxesP(xLims, xTicks,1,yLims(1)-0.005,'Coherence (%)',[yLims],[yLims], 0.05, (xLims(1)-.05),'Firing Rate (Hz)',[1 1]);
        set(gca,'visible','off');
        axis square;
        subplot(122);
        Coh = params.coherence;
        plot(Coh, FRv,'ko-'); hold on;
        yLims = [2 6];
        xLims = [0 100];
        xTicks = [0 floor(Coh)' 100];
        [hP,vP] = getAxesP(xLims, xTicks,1,yLims(1)-.5,'Coherence (%)',[yLims],[yLims], 0.05, (xLims(1)-.05),'Firing Rate (Hz)',[1 1]);
        set(gca,'visible','off');
        axis square;
        
        Neurons.coherence.params.bV = bV;
        Neurons.coherence.params.bVe = bVe;
        
        
        
        
end





function [highD, dataTable] = plotComponents(model, conds, cValues, maxValues, alignType, varargin)

dimsToShow = [1 2 3];

assignopts(who, varargin);

tMin = model.tMin;
TrajIn = model.TrajIn;
TrajOut = model.TrajOut;

errTrajIn = []; errTrajOut = [];
if isfield(model,'errTrajIn')
    errTrajIn = model.errTrajIn;
    errTrajOut = model.errTrajOut;
end
bTrajIn = [];
bTrajOut = [];
if isfield(model,'bTrajIn')
    bTrajIn = model.bTrajIn;
    bTrajOut = model.bTrajOut;
end



coeff = model.coeff;
score = model.score ;
latent = model.latent;
tData = model.tData;

params = getParams;
cnt = 1;
figure('color',[1 1 1]);

lineH = [];
Dist = {};
MinMax = [];

X = cumsum(latent./sum(latent));
aX(1) = axes('position',[0.05 0.55 0.22 0.4]);
aX(2) = axes('position',[0.35 0.55 0.22 0.4]);
aX(3) = axes('position',[0.65 0.55 0.22 0.4]);
aX(4) = axes('position',[0.05 0.05 0.22 0.4]);
aX(5) = axes('position',[0.35 0.05 0.22 0.4]);
aX(6) = axes('position',[0.65 0.05 0.22 0.4]);

S = cumsum(latent./sum(latent));

U = abs(diff(S)) < 5e-3;
S2 = latent./sum(latent);


nDim99 = find(X >= 0.9,1,'first')
nDimPlot = 6;
whichDim = [1:nDimPlot];
V = 100*latent./sum(latent);
V(whichDim);

figure;


plot(1:10,S2(1:10)*100,'ko-','markerfacecolor','k','markeredgecolor','none','markersize',12); hold on;
set(gca,'visible','off');
getAxesP([0 10],[0:2:10],-1,-1,'Component',[-1 100],[0 50 100],2,-.5,'Variance(%)',[1 1]);
line([0 10],[1 1],'color','k','linestyle','--');
% line([0 50],[90 90],'color','k','linestyle','--');
axis square; axis tight;


X(nDimPlot)
X(whichDim(end))

% Plot the first few PCs to look at!
distMinMax = [];
conds = 1:11;
dimCnt = 1;
DistAll = [];

for nCoh = 1:length(TrajIn)
    iX(nCoh) = size(TrajIn{nCoh},1);
end

bigD = [];
for nDim = [nDimPlot nDim99 length(X)]
    
    for z= 1:length(TrajIn)
        
        lW = 1;
        if ismember(z,[2 9])
            lW = 2;
        end
        
        if nDim == nDimPlot
            if ismember(z,conds)
                compCnt = 1;
                for f= dimsToShow
                    axes(aX(compCnt));
                    set(gca,'visible','off');
                    if ~isempty(errTrajIn)
                        % [pa, li] = ShadedError(tData{z}*1000', TrajIn{z}(:,f)', errTrajIn{z}(:,f)'); hold on;
                        plot(tData{z}*1000',TrajIn{z}(:,f)','-','color',cValues(z,:));
                        hold on;
                        plot(tData{z}*1000',TrajOut{z}(:,f)'','--','color',cValues(z,:));
                    else
                        li = plot(tData{z}*1000', TrajIn{z}(:,f)'); hold on;
                        set(li,'color',cValues(z,:));
                        li = plot(tData{z}*1000', TrajOut{z}(:,f)'); hold on;
                        set(li,'color',cValues(z,:),'linestyle','--');
                    end
                    %                     plot(tData{z}*1000, TrajIn{z}(:,f), 'linewidth',2, 'color', cValues(z,:));
                    hold on;
                    Temp = [ min([TrajIn{z}(:,f); TrajOut{z}(:,f)]) max([TrajIn{z}(:,f); TrajOut{z}(:,f)])];
                    MinMax(z,compCnt,:) = Temp;
                    compCnt = compCnt + 1;
                    if z==1
                        text(0,-7,sprintf('%3.2f%%',V(dimsToShow(f))));
                    end
                end
            end
            
            Dist{z} = (sqrt(sum([TrajIn{z}(:,whichDim) - TrajOut{z}(:,whichDim)].^2,2)));
            showErr = 0;
            if ~isempty(bTrajIn)
                errDist{z} = squeeze(nanstd(sum(abs(bTrajIn{z}(:,:,[1:nDim]) - bTrajOut{z}(:,:,[1:nDim])),3)));
                showErr = 1;
            end
            if ismember(z,conds)
                axes(aX(6));
                tP = Dist{z};
                %                 tP = tP - nanmean(tP(1:5));
                %                 ShadedError(tData{z}*1000, tP', errDist{z},
                if showErr
                    [pa, li] = ShadedError(tData{z}*1000, tP', errDist{z});
                    set(li,'linewidth',lW, 'color', cValues(z,:));
                else
                    li = plot(tData{z}*1000, tP, '-','color',cValues(z,:));
                end
                
                
                currD = [tData{z}'*1000 tP];
                currD(:,end+1) = z;
                
                bigD = [bigD; currD];
                
                hold on;
                set(gca,'visible','off');
                distMinMax(z,:) = [min(Dist{z}), max(Dist{z})];
                axis tight; axis square;
            end
            cnt = cnt + 1;
        end
        DistAll(dimCnt,z,:) = sum(abs(TrajIn{z}(1:min(iX),[1:nDim]) - TrajOut{z}(1:min(iX),[1:nDim])),2);
    end
    switch(alignType)
        case 'checkerboard'
            %             [r,p] = corr(DistAll(dimCnt,:,end)',params.coherence,'type','kendall');
            %             rValue(dimCnt,1) = r;
            %             rValue(dimCnt,2) = p;
    end
    
    %             [r,p] = corr(DistAll(dimCnt,:,end)',(params.RTpcL + params.RTpcH)/2,'type','kendall');
    %             rValue(dimCnt,1) = r;
    %             rValue(dimCnt,2) = p;
    %             dimCnt = dimCnt +1;
    dimCnt = dimCnt +1;
end

dataTable = array2table(bigD, 'VariableNames',{'time','Dist','Id'});

highD = Dist;


S1 = MinMax(:,:,1);
S1 = S1(:);


S2 = MinMax(:,:,2);
S2 = S2(:);

yLims = [floor(min(S1(:))) ceil(max(S2(:)))];

% Now clean up the axes on it.
for z=1:5
    axes(aX(z));
    %     str1 = sprintf('$$\\tilde{\\mathbf x}_{%d,:}$$', dimsToShow(z));
    str1 = sprintf('Component : %d', dimsToShow(z));
    
    
    switch(alignType)
        case 'move'
            tMax = model.tMax;
            xTicks = [-400:200:-200];
            xLims = [-600 tMax+100];
            strValue = 'Move';
            
        case 'checkerboard'
            tMin = model.tMin;
            xTicks = [tMin*1000  200:200:500];
            xLims = [tMin*1000 ceil(max(maxValues))];
            strValue = 'Check';
    end
    
    
    cTextLabels = getTextLabel(0,{strValue},{'b'});
    
    try
        yTicks = yLims;
        getAxesP(xLims, xTicks, 1, yLims(1), 'Time (ms)', yLims, yTicks, 20, xLims(1)-20, sprintf('X_%d', dimsToShow(z)),[1 1],cTextLabels);
        drawRestrictedLines(0,yLims,'lineStyle','--');
    catch
    end
    axis tight; axis square;
    
    %      plotAxes(xLims, yLims, xTicks, cTextLabels);
    
    axis tight;
    axis square;
end
title(sprintf('%s, %s', model.type, model.align));

axes(aX(6));
yLims = floor([min(distMinMax(:,1))-1 max(distMinMax(:,2))]) ;
% yLims(2) = 10;
yTicks = [yLims(1) 0 yLims(2)/2 yLims(2)];
getAxesP(xLims, xTicks, 1, yLims(1), 'Time (ms)', yLims, yTicks, 20, xLims(1)-20, 'High D Distance',[1 1],cTextLabels);
drawRestrictedLines(0,yLims,'lineStyle','--');
axis tight; axis square;

function computeCorr(model)
%
%
% Chand, 11 May 2018
keyboard
AvDist = [];
for p=1:length(model.tData)
    tTemp = model.tData{p};
    tIx = find(tTemp > -0.1 & tTemp < 0);
    AvDist(p) = nanmean(model.dist{p}(tIx),1);
end
params = getParams;
RT = [params.RTpcL + params.RTpcH]./2;
%figure;
%plot(RT(1:length(AvDist)), AvDist)
[r,p] = corr(RT(1:length(AvDist))', AvDist')




function dataTable = plotTrajectories(model, conds, drawColors, alignType, whichDirections, varargin)
%
%
%
% CC, Shenoylab, March 13, 2014

dimsToShow = [1 3 2];
computeSpeed = false;
do3d = true;
deltaT = 10;
flipDim2 = true;

tPointAfter = 0.25;

assignopts(who, varargin);
tMin = model.tMin;
TrajIn = model.TrajIn;
TrajOut = model.TrajOut;

coeff = model.coeff;
score = model.score ;
latent = model.latent;
tData = model.tData;


figure('color',[1 1 1]);
drawBase = true;
params = getParams;
cohColors = drawColors;

showMarkers = true;
m300size = 12;
dataTable = [];

bigD = [];


for k=conds
    %     tV = find(t > tMin & t < O(z)./1000);
    lW = 2;
    if ismember(k,[2 9])
        lW = 2;
    end
    
    if whichDirections(1)
        X = [1:1:size(TrajIn{k},1)];
        
        S1 = TrajIn{k}(:,dimsToShow(1));
        S2 = TrajIn{k}(:,dimsToShow(2));
        S3 = TrajIn{k}(:,dimsToShow(3));
        
        hold on;
        
        X = [1:deltaT:size(TrajIn{k},1)];
        timePts = model.tData{k};
        tUsed = timePts(1:deltaT:end);
        S = find(timePts >-0.002 & timePts < 0.0,1,'first');
        S300 = find(timePts >=tPointAfter,1,'first')
        
        if do3d
            X = sort([X S300]);
            if flipDim2
                S2 = -S2;
            end
            
            if showMarkers
                marker = 's';
            else
                marker = 'none';
            end
            
            currD1 = [S1 S2 S3];
            currD1(:,end+1) = k;
            currD1(:,end+1) = 1;
            
            plot3(S1,S2,S3,'color',cohColors(k,:),'marker','none', 'linewidth',lW);
            plot3(S1(X),S2(X),S3(X),'color',cohColors(k,:),'MarkerFaceColor', cohColors(k,:),'MarkerEdgeColor','none','marker',marker,'markersize',6, 'linestyle','none');
            if ~isempty(S)
                plot3(S1(S),S2(S),S3(S),'color','r','marker','o','markerFaceColor','r','markersize',m300size);
                
            end
            if ~isempty(S)
                plot3(S1(S300),S2(S300),S3(S300),'color',cohColors(k,:),'marker','d','markerFaceColor',cohColors(k,:),'markersize',m300size);
            end
            
        else
            X = sort([X S300]);
            
            plot(S1(X),S2(X),'color', cohColors(k,:),'marker','d','markersize',4, 'linewidth',lW);
            if ~isempty(S)
                plot(S1(S),S2(S),'color','r','marker','o','markerFaceColor','r','markeredgecolor','none','markersize',m300size);
                
            end
            if ~isempty(S300)
                plot(S1(S300),S2(S300),'color',cohColors(k,:),'marker','o','markerFaceColor',cohColors(k,:),'markersize',m300size);
            end
            
        end
        
        
        
    end
    
    
    if whichDirections(2)
        
        X = [1:1:size(TrajIn{k},1)];
        
        S1 = TrajOut{k}(:,dimsToShow(1));
        S2 = TrajOut{k}(:,dimsToShow(2));
        S3 = TrajOut{k}(:,dimsToShow(3));
        hold on;
        
        
        X = [1:deltaT:size(TrajOut{k},1)];
        timePts = model.tData{k};
        tUsed = timePts(1:deltaT:end);
        S = find(timePts >-0.002 & timePts < 0.0,1,'first');
        S300 = find(timePts >=tPointAfter,1,'first');
        
        
        %         plot3(S1(X),S2(X),S3(X),'color', cohColors(k,:),'marker','s','markersize',4);
        if do3d
            if flipDim2
                S2 = -S2;
            end
            if showMarkers
                marker = 's';
            else
                marker = 'none';
            end
            plot3(S1,S2,S3,'color',cohColors(k,:),'marker','none', 'linewidth',lW,'linestyle','--');
            plot3(S1(X),S2(X),S3(X),'color',cohColors(k,:), 'MarkerFaceColor', cohColors(k,:),'MarkerEdgeColor','none','marker',marker,'markersize',6, 'linestyle','none');
            if ~isempty(S)
                plot3(S1(S),S2(S),S3(S),'color','r','marker','o','markerFaceColor','r','markersize',m300size);
                
            end
            
            currD2 = [S1 S2 S3];
            currD2(:,end+1) = k;
            currD2(:,end+1) = 2;
            
            if ~isempty(S300)
                plot3(S1(S300),S2(S300),S3(S300),'color',cohColors(k,:),'marker','d','markerFaceColor',cohColors(k,:),'markeredgecolor','none','markersize',m300size);
            end
            
        else
            plot(S1(X),S2(X),'color', cohColors(k,:),'marker','s','markersize',4, 'linewidth',lW);
            if ~isempty(S)
                plot(S1(S),S2(S),'color','k','marker','o','markerFaceColor','k','markersize',m300size);
            end
            if ~isempty(S300)
                plot(S1(S300),S2(S300),'color',cohColors(k,:),'marker','o','markerFaceColor',cohColors(k,:),'markersize',m300size);
            end
            
        end
        
        
        
        
    end
    
    bigD = [bigD; currD1; currD2];
    
    
end

dataTable = array2table(bigD, 'VariableNames',{'X','Y','Z','Id','Choice'});

axis tight;

set(gca,'tickdir','out','visible','off', 'CameraPosition', [511.8462 -425.2387 253.8264],'CameraTarget',[19.1727 -7.1407 -3.2937]);
title(sprintf('%s, %s', model.type, model.align));
str1 = sprintf('x%d', dimsToShow(1));
str2 = sprintf('x%d', dimsToShow(2));
str3 = sprintf('x%d', dimsToShow(3));
xlabel(str1);
ylabel(str2);
zlabel(str3);
E = ThreeVector(gca);

ax = gca;
ax.SortMethod = 'ChildOrder';
axis square;

if computeSpeed
    conds = [ 1:11];
    speed = [];
    for k=conds
        %     tV = find(t > tMin & t < O(z)./1000);
        fprintf('%d.',k);
        distance = [];
        if whichDirections(1)
            
            X = [1:1:size(TrajIn{k},1)];
            S1 = smooth(TrajOut{k}(:,dimsToShow(1)),20);
            S2 = smooth(TrajOut{k}(:,dimsToShow(2)),20);
            S3 = smooth(TrajOut{k}(:,dimsToShow(3)),20);
            hold on;
            T = floor(linspace(1,length(X)-300,20));
            
            for tt = 2:length(T)
                distance(tt) = sum(abs([TrajIn{k}(T(tt),:) - TrajIn{k}(T(tt-1),:)]));
            end
            AllS{k} = distance;
            plot(T(2:end),AllS{k}(2:end));
        end
        speed(k) = sum(distance)./(T(end) - T(1));
    end
    keyboard
end



