function dataTable = plotKinet(r, varargin)
%
%   plots the results from the KiNeT analysis developed in the Jazayeri Lab
%   uses the kinet results computed previously in the class constructor.
%
% Chand, March 30th 2022
% 

faceAlpha = .5;
assignopts(who,varargin)

figure('color',[1 1 1]);

whichConds = r.metaData.whichConds;


V = squeeze(nanmean(r.kinet.V+r.metaData.tMin)*1000);
Ve = squeeze(nanstd(r.kinet.V+r.metaData.tMin)*1000);

tVect = r.kinet.tVect + r.metaData.tMin;
rawData = r.kinet.V + r.metaData.tMin;
tIdx = find(tVect>=-0.1,1,'first');

X = r.metaData.RTlims(:, r.metaData.whichConds);
X = nanmean(X);
[rCorr,pCorr] = corr(squeeze(X)', squeeze(nanmean(rawData(:,tIdx,:))))


distancesAll = -squeeze(nanmean(r.kinet.distancesAll));
distancesE = squeeze(nanstd(r.kinet.distancesAll));
tSpeed = r.kinet.tSpeed;
speed = squeeze(nanmean(r.kinet.speed));
speedE = squeeze(nanstd(r.kinet.speed));

[rDist, pDist] = corr(squeeze(X)',squeeze(distancesAll(tIdx,:))')




subplot(2,3,4);
pa = [];
li = [];
vNames1 = {};
vNames2 = {};
for n=1:size(V,2)
    [pa(n), li(n)] = ShadedError([tVect]*1000, squeeze(V(:,n))', squeeze(Ve(:,n)'));
    hold on;
    vNames1{n} = sprintf('RTbin%d',n);
    vNames2{n} = sprintf('RTbinE%d',n);
end


dataTable.velocity = array2table([tVect'*1000 V Ve],'VariableNames',['time' vNames1 vNames2]);


setLineColors(li);
set(pa,'FaceAlpha',faceAlpha);
set(gca,'visible','on');
drawRestrictedLines(0,[-400 500]);
line([-400 400],[0 0],'color','k','linestyle','--');
hold on;
getAxesP([-0.4 0.4]*1000,[-0.4:0.2:0.4]*1000,100,-420,'t_{Ref} (ms)',[-0.4 0.5]*1000,[-0.4:0.2:0.5]*1000,120,-420,'t (ms)',[1 1]);
set(gca,'visible','off');
axis square;
axis tight;
if ~r.processingFlags.useNonOverlapping
    text(-300,300,sprintf('r=%3.2f, p=%3.4e',rCorr, pCorr));
end


subplot(2,3,1);
RTl = r.metaData.RTlims(1,whichConds);
RTh = r.metaData.RTlims(2,whichConds);
params = getParams;

pa = [];
li = [];

for n=1:size(V,2)
    [pa(n), li(n)] = ShadedError([tVect]*1000, squeeze(distancesAll(:,n))', squeeze(distancesE(:,n))');
    hold on;
end

dataTable.distance = array2table([tVect'*1000 distancesAll distancesE],'VariableNames',['time' vNames1 vNames2]);


setLineColors(li);
set(pa,'FaceAlpha',faceAlpha);

% X = plot(1000*[tVect], squeeze(distancesAll));
% setLineColors(X);
set(gca,'visible','on');
line([-400 400],[0 0],'color','k','linestyle','--');
set(gca,'visible','off');
hold on;
drawRestrictedLines(0,[-30 30]);
getAxesP([-0.4 0.4]*1000,[-0.4:0.2:0.4]*1000,5,-30,'t (s)',[-30 30],[-30:10:30],100,-420,'Euclidean distance',[1 1]);
axis square;
axis tight;
if ~r.processingFlags.useNonOverlapping
    text(-300,20,sprintf('r=%3.2f, p=%3.2f',rDist, pDist));
end




subplot(2,3,5);


speedS = squeeze(nanmean(nanmean(r.kinet.speed(:,tSpeed > -400 & tSpeed < 0,:),2)))
speedSE = squeeze(nanstd(nanmean(r.kinet.speed(:,tSpeed > -400 & tSpeed < 0,:),2)))

[rSpeed,pSpeed] = corr(speedS, squeeze(X)')
plot([RTl+RTh]/2, speedS,'k-');
for n=1:length(speedS)
    hold on;
    eF = errorbar([RTl(n)+RTh(n)]/2, speedS(n), speedSE(n),'o-','markersize',12,'markerfacecolor',params.posterColors(n,:),'markeredgecolor','none','color',params.posterColors(n,:));
    sData(n,:) = [[RTl(n)+RTh(n)]/2  speedS(n)  speedSE(n)];
end
hold on
dataTable.speed = array2table(sData,'VariableNames',{'RT','Speed','SpeedE'});

hold on
set(gca,'visible','off');
getAxesP([300 800],[300:200:800],4,29,'RT (ms)',[0.3 0.6]*100,[0.3:0.1:0.6]*100,50,290,'Speed (spks/s/s)',[1 1]);
axis tight;


RTlimA = [RTl+RTh]/2;
axis square;
axis tight;

subplot(2,3,2)
angleS = squeeze(nanmean(r.kinet.spaceAngle))*180/pi;
angleSE = squeeze(nanstd(r.kinet.spaceAngle))*180/pi;
[pa,li] = ShadedError(tVect*1000, angleS, angleSE);
pa.FaceAlpha = faceAlpha;

drawRestrictedLines(0,[0 180]);
line([tVect(1) tVect(end)]*1000,[90 90],'color','k','linestyle','--');
axis square;
axis tight;
ylim([0 180]);
hold on;
set(gca,'visible','off');
getAxesP([-0.4 0.5]*1000,[-0.4:0.2:0.5]*1000,10,-.1,'t (ms)',[0 180],[0 90 180],100,-420,'Angle',[1 1]);

dataTable.subspace = array2table([tVect'*1000 angleS' angleSE'],'VariableNames',{'time','Angle','AngleSEM'});



subplot(2,3,3)
angleS = squeeze(nanmean(r.kinet.meanVectorAngle))*180/pi;
angleSE = squeeze(nanstd(r.kinet.meanVectorAngle))*180/pi;
[pa,li] = ShadedError(tVect*1000, angleS, angleSE);
pa.FaceAlpha = faceAlpha;
  
line([tVect(1) tVect(end)]*1000,[90 90],'color','k','linestyle','--');
drawRestrictedLines(0,[0 180]);
line(get(gca,'xlim'),[0 0],'color','k','linestyle','--');
axis square;
axis tight;
ylim([0 180]);
set(gca,'visible','off');

dataTable.align = array2table([tVect'*1000 angleS' angleSE'],'VariableNames',{'time','Angle','AngleSEM'});
getAxesP([-0.4 0.5]*1000,[-0.4:0.2:0.5]*1000,10,-.1,'t (ms)',[0 180],[0 90 180],100,-420,'Angle',[1 1]);





subplot(2,3,6);
for p=1:size(speed,2)
    [pa(p), L(p)] = ShadedError(tSpeed, squeeze(speed(:,p))', squeeze(speedE(:,p))');
    set(pa(p),'FaceAlpha',0.5);
    hold on
end
setLineColors(L);
set(gca,'visible','off');
hold on;
drawRestrictedLines(0,[0 400]);
getAxesP([-0.4 0.5]*1000,[-0.4:0.2:0.5]*1000,50,-.1,'t (ms)',[0 4]*100,[0:4]*100,100,-420,'Speed (spks/s/s)',[1 1]);
axis square;
axis tight;


end