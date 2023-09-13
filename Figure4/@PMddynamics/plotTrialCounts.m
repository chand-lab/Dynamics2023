function dataTable = plotTrialCounts(r)
%
%
% CC, Aug 1 2023
figure;

Z = nanmean(r.trialCounts,3);
params = getParams;
pC = params.posterColors;


subplot(121);
errorbar(1:3, nanmean(Z(:,[1 13 11])), nanstd(Z(:,[1 13 11])),'ko-', 'markersize',8,'markerfacecolor','k','markeredgecolor','none')
hold on;
getAxesP([1 3], [1:3], 'Conditions', 20, 1, [20 400],[20:100:400],'Trial Counts',0.75,1,[1 1]);
set(gca,'visible','off');
axis square;
axis tight;

RT1 = r.metaData.RTlims(:,[1 13 11],:)';
dataTable.nonOverlappping = array2table(horzcat(RT1, nanmean(Z(:,[1 13 11]))', nanstd(Z(:,[1 13 11]))'),'VariableNames',{'RTl','RTr','Mean','SD'});

subplot(122);
for n=1:11
    hold on
    errorbar(n, nanmean(Z(:,[n])), nanstd(Z(:,[n])),'o-', 'color',pC(n,:),'markersize',8,'markerfacecolor',pC(n,:),'markeredgecolor','none')
end

hold on;
getAxesP([1 11], [1:11], 'Conditions', -2, 1, [0 400],[0:100:400],'Trial Counts', .5,.5,[1 1]);
set(gca,'visible','off');
axis square;
axis tight;
RT1 = r.metaData.RTlims(:,[1:11])';
dataTable.Overlappping = array2table(horzcat(RT1, nanmean(Z(:,[1:11]))', nanstd(Z(:,[1:11]))'),'VariableNames',{'RTl','RTr','Mean','SD'});
