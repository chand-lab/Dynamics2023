function [slopeV, bV, cohValues, forBigCorr, metaData, dataTable] = calcInputsAndIC(r, varargin)
% calcInputsAndIC calculates the effect of inputs and initial conditions on
% the choice-related dynamics.
%
% r is the object with the data and metadata
%
% Chand, April 2023
%

numDim = 6;
assignopts(who, varargin);
NewTraj = [];

figure;

expression = '(x <=tStart).*base + (x >tStart).*(base  + slope1*(x-tStart).^2)';
g = fittype(expression,'coeff',{'tStart','base','slope1'},'indep','x');


slopeV = [];
bV = [];
bVI = [];
FitQuality = [];
Loc = [];
cnt = 1;
nDim = numDim;

bigD = [];
for n=1:7
    if ismember(n,[1 3 7])
        subplot(3,2,2*cnt-1);
        plotData = true;
        cnt = cnt + 1;
    else
        plotData = false;
    end
    li = [];
    for m=1:length(r.perCoh(n).pcaData.TrajIn)
        
        Loc(n,m,:) = [nanmean(r.perCoh(n).pcaData.TrajIn{m}(100:400,1:nDim)) nanmean(r.perCoh(n).pcaData.TrajOut{m}(100:400,1:nDim))];
        dist{m} = sqrt(sum([r.perCoh(n).pcaData.TrajIn{m}(:,1:nDim) - r.perCoh(n).pcaData.TrajOut{m}(:,1:nDim)].^2,2));
        hold on;
        Y = dist{m};
        
        tV = r.perCoh(n).pcaData.tData{m};
        iX = find(tV > 0.125 & tV < 0.375);
        
        if plotData
            li(m) = plot(tV*1000, dist{m},'-');
            
            currD = [tV'*1000 dist{m}];
            currD(:,end+1) = n;
            currD(:,end+1) = m;
            
            
            
        end
        
        bigD = [bigD; currD];
        
        slopeV(n,m) = nanmean(Y(iX(1:10:end)));
        
        
        tS = r.perCoh(n).pcaData.tData{m}*1000;
        tVals = (tS > -100 & tS < 375);
        [R,goodness] = fit(tS(tVals)',squeeze(double(Y(tVals))),g,'StartPoint',[100 3 0.0001]);
        if plotData & n==1
            hold on
            
            
            
            
        end
        
        FitQuality(n,m) = goodness.rsquare;
        bV(n,m,:) = coeffvalues(R);
        bVI(n,m,:,:) = confint(R);
        
        
    end
    if plotData
        setLineColors(li);
        
        yLims = [0 100];
        xLims = [-400 500];
        xTicks = [-400 200 400];
        cTextLabels = getTextLabel(0,{'Cue'},{'b'});
        yTicks = [yLims(1):25:yLims(2)];
        getAxesP(xLims, xTicks, 12.5, yLims(1), 'Time (ms)', yLims, yTicks, 100, xLims(1)-20, 'High D Distance',[1 1],cTextLabels);
        drawRestrictedLines(0,yLims,'lineStyle','--');
        axis tight; axis square;
        set(gca,'visible','off');
        
        
    end
    
end

dataTable.distances = array2table(bigD, 'VariableNames', {'time','distance','id_coh','id_rt'});

%%
figure;
X = [];
Y = [];
idV = [];
Ylatency = [];
Yslope = [];
cnt = 1;
RTv = mean(r.metaData.RTlims);
id = [];
RTbin = [];
cohValues = [11 45 67 78 90 101 108];
cohValues = abs(cohValues - (225-cohValues))./225;
for n=1:size(Loc,1)
    for m=[1:size(Loc,2)]
        X(cnt,1:size(Loc,3)) = squeeze(Loc(n,m,:));
        idV(cnt) = cohValues(n);
        id(cnt) = n;
        RTbin(cnt) = RTv(m);
        Yave(cnt) = slopeV(n,m);
        Yslope(cnt) = bV(n,m,3);
        Ylatency(cnt) = bV(n,m,1);
        Y2(cnt) = bV(n,m,3);
        cnt = cnt + 1;
    end
end
X2 = X;
X2(:,end+1) = 1;

%%
figure;
subplot(311)
X(:,end+1) = 1;
X = X-repmat(nanmean(X),[size(X,1) 1]);
[P,F, V1] = pca(X(:,1:nDim*2));
X1 = [];
X1(:,1) = F(:,1);
X1(:,2) = idV;
X1(:,3) = F(:,1).*idV';
X1(:,4) = 1;
Y = Yave;
[bRegress,bi,c,ci,st] = regress(Y',X1);
li = [];
p = getParams;
ColVals = repmat([0 0.5 0.55 0.6 0.65 0.72 0.84]',1,3);

D = floor(linspace(1,size(p.posterColors,1),length(r.perCoh(1).pcaData.TrajIn)));


forBigCorr = F(:,1);
forBigCorr(:,2) = Yave;
forBigCorr(:,3) = Ylatency;
forBigCorr(:,4) = Yslope;
forBigCorr(:,5) = idV;

rawData = [];
for b=[1 3 5 7]
    a1 = F(id==b,1);
    a2 = Y(id==b);
    plot(F(id==b,1), Y(id==b),'-','color',ColVals(b,:),'linewidth',2);
    hold on
    for k=1:length(a1)
        plot(a1(k),a2(k),'o','markerfacecolor',p.posterColors(D(k),:), 'markersize',12,'markeredgecolor','none');
    end
    hold on
    rawData = [rawData; a1 a2' b*ones(length(a1),1)];
    
    
end

dataTable.avgSel = array2table(rawData,'VariableNames',{'IC','AvgSel','Id'});

set(gca,'visible','off');
% setLineColors(li);
hold on;
getAxesP([-20 20],[-20 0 20],6,-2,'Initial Condition',[0 60],[0:15:60],2,-22,'Average',[1 1]);
axis square;
axis tight;
text(-10,70,'Average Rate');

[r1,p1] = partialcorr(Yave',X1(:,1),X1(:,2));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r1,p1);
text([-10],50,S1);
fprintf('\n For Average Rate: Initial Conditions %s', S1);


[r2,p2] = partialcorr(Yave',X1(:,2),X1(:,1));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r2,p2);
text([-10],10,S1);
fprintf(' \n For Average Rate: Coherence %s', S1);

metaData.avgSel.rIC = r1;
metaData.avgSel.rCoh = r2;

subplot(3,1,2);
li = [];
rawData = [];
for b=[1 3 5 7]
    a1 = F(id==b,1);
    a2 = Ylatency(id==b);
    li(b) = plot(F(id==b,1), Ylatency(id==b),'-','color',ColVals(b,:),'linewidth',2);
    hold on
    for k=1:length(a1)
        plot(a1(k),a2(k),'o','markerfacecolor',p.posterColors(D(k),:), 'markersize',12,'markeredgecolor','none');
    end
    hold on
    
     rawData = [rawData; a1 a2' b*ones(length(a1),1)];
    
end

dataTable.avgLatency = array2table(rawData,'VariableNames',{'IC','Latency','Id'});

set(gca,'visible','off');
% setLineColors(li);
hold on;
getAxesP([-20 20],[-20 0 20],20,-2,'Initial Condition',[0 250],[0:62.5:250],5,-22,'Latency (ms)',[1 1]);
axis square;
axis tight;

[r1,p1] = partialcorr(Ylatency',X1(:,1),X1(:,2));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r1,p1);
fprintf('\n For Latency: Initial Conditions %s', S1);

text([-10],250,S1);


[r2,p2] = partialcorr(Ylatency',X1(:,2),X1(:,1));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r2,p2);
text([-10],10,S1);
fprintf(' \n For Latency: Coherence %s', S1);
metaData.latency.rIC = r1;
metaData.latency.rCoh = r2;


subplot(3,1,3);
li = [];

rawData = [];
for b=[1 3 5 7]
    a1 = F(id==b,1);
    a2 = Yslope(id==b);
    li(b) = plot(F(id==b,1), Yslope(id==b),'-','color',ColVals(b,:),'linewidth',2);
    hold on
    for k=1:length(a1)
        plot(a1(k),a2(k),'o','markerfacecolor',p.posterColors(D(k),:), 'markersize',12,'markeredgecolor','none');
    end
    hold on
    
    rawData = [rawData; a1 a2' b*ones(length(a1),1)];
end
set(gca,'visible','off');
% setLineColors(li);
hold on;
getAxesP([-20 20],[-20 0 20],0.0005,-0.0005,'Initial Condition',[0 0.003],[0:0.001:0.003],5,-22,'Slope  (ms)',[1 1]);
axis square;
axis tight;

dataTable.avgSlope  = array2table(rawData,'VariableNames',{'IC','AvgSel','Id'});

[r1,p1] = partialcorr(Yslope',X1(:,1),X1(:,2));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r1,p1);
fprintf('\n For Average Slope: Initial Conditions %s', S1);
text([-10],.003,sprintf('Corr:%3.2f( p = %3.2f)',r1,p1));

[r2,p2] = partialcorr(Yslope',X1(:,2),X1(:,1));
S1 = sprintf('Corr:%3.2f( p = %3.2e)',r2,p2);
fprintf(' \n For Average Slope: Coherence %s', S1);
text([-10],.0005,S1);


metaData.slope.rIC = r1;
metaData.slope.rCoh = r2;


