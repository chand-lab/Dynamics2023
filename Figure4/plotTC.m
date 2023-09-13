figure;

Z = nanmean(N.trialCounts,3);

subplot(221);
errorbar(1:3, nanmean(Z(:,[1 13 11])), nanstd(Z(:,[1 13 11])),'ko-', 'markersize',8,'markerfacecolor','k','markeredgecolor','none')
hold on;
getAxesP([1 3], [1:3], 'Conditions', 20, 1, [20 400],[20:100:400],'Trial Counts',0.75,1,[1 1]);
set(gca,'visible','off');
axis tight;
axis square;

subplot(222);
errorbar(1:11, nanmean(Z(:,[1:11])), nanstd(Z(:,[1:11])),'ko-', 'markersize',8,'markerfacecolor','k','markeredgecolor','none')
hold on;
getAxesP([1 11], [1:11], 'Conditions', -2, 1, [0 400],[0:100:400],'Trial Counts', .5,.5,[1 1]);
set(gca,'visible','off');
axis tight;
axis square;
