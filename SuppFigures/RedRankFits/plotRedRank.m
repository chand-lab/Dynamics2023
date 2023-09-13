%% Figure plotting
function plotRedRank(AllRsquare, AllRsquare_s,alignAngles,tAxis,timeValues,whichTimePoint,AllAngles)
subplot(221);
Sv = squeeze(AllRsquare(21,:))*100;
plot(tAxis(timeValues)*1000, Sv,'mo-')
hold on;
Svs = squeeze(AllRsquare_s(21,:))*100;
plot(tAxis(timeValues)*1000, Svs,'ko-')
hold on;


drawRestrictedLines(0,[10 50]);
drawRestrictedLines(tAxis(whichTimePoint)*1000,[10 50]);

set(gca,'visible','off');
getAxesP([-600 1000],-600:200:1000,5,5,'Time (ms)',[10 50],10:10:50,250,-625,'R^2 (%)');
axis square;
axis tight;


rrrData.single = array2table([tAxis(timeValues)'*1000 Sv' Svs'],'VariableNames',{'Time','Real','Shuffled'});



subplot(222);
ix = find(~(sum(AllRsquare < 0 | AllRsquare > 1,2)));
Sv = squeeze(mean(AllRsquare(ix,:),'omitnan'))*100;
Sve = squeeze(std(AllRsquare(ix,:),'omitnan'))*100./sqrt(size(AllRsquare,1));

ShadedError(tAxis(timeValues)*1000, squeeze(Sv),Sve);

hold on
ix = find(~(sum(AllRsquare_s < 0 | AllRsquare_s > 1,2)));
plot(tAxis(timeValues)*1000, squeeze(mean(AllRsquare_s(ix,:),'omitnan'))*100,'ko-')

drawRestrictedLines(0,[20 40]);
drawRestrictedLines(tAxis(whichTimePoint)*1000,[20 40]);
set(gca,'visible','off');
getAxesP([-600 1000],-600:200:1000,2,19,'Time (ms)',[20 40],20:5:40,250,-625,'R^2 (%)');
axis square;
axis tight;

text(-400,22,sprintf('%d sessions',size(AllRsquare(ix,:),1)));
S = real(squeeze(mean(AllRsquare_s(ix,:),'omitnan'))*100);
rrrData.average = array2table([tAxis(timeValues)'*1000 Sv' Sve' S'],'VariableNames',{'Time','Real','RealE','Shuffled'});


subplot(223)

tNew = tAxis(timeValues)*1000;

alignAngle = squeeze(mean(alignAngles(:,2:end,:)*180/pi,'omitnan'));
alignAngleE = squeeze(std(alignAngles(:,2:end,:)*180/pi,'omitnan')/sqrt(size(alignAngles,1)));

errorbar(tNew(2:end), alignAngle(:,1), alignAngleE(:,1));
hold on

errorbar(tNew(2:end), alignAngle(:,2), alignAngleE(:,2));
hold on

drawRestrictedLines(0,[10 90]);
l = refline([0 90]);
l.Parent.XLim = [-600 1000];
l.LineStyle = '--';
set(gca,'visible','off');
getAxesP([-600 1000],-600:200:1000,5,10,'Time (ms)',[10 95],10:20:90,250,-625,'R^2 (%)');
axis square;
axis tight;

rrrData.angle = array2table([tNew(2:end)' alignAngle alignAngleE],'VariableNames',{'Time','Angle','AngleS','Error','ErrorS'});


subplot(224);

Xangle = rad2deg(AllAngles);

plot(Xangle(:,1), Xangle(:,2),'o','markerfacecolor','k',...
    'markeredgecolor','none','markersize',8,'linestyle','none');
set(gca,'visible','off');
xlim([0 90]);
ylim([0 90]);
hold on;
r1 = refline([1 0]);
r1.LineStyle = '--';
r1.Color = [0 0 0];
getAxesP([0 90],0:20:90,7,-7,'Time (ms)',[0 90],0:20:90,10,-7,'R^2 (%)');
axis tight;
axis square;

end