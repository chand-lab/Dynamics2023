function plotTCAvar(testError,trainError,st,st1)
testError(testError < 0) = NaN;
figure;
subplot(221);
hold on
trainColor = [.1 0.4 0.5];
testColor = [0.8 0.3 0];
errorbar(1:4, mean(trainError*100,"omitnan"), std(trainError*100,"omitnan")./sqrt(sum(~isnan(trainError))),'o-','color',trainColor,'markerfacecolor',trainColor,'markeredgecolor','none','markersize',12);
errorbar(1:4, mean(testError*100,"omitnan"), std(testError*100,"omitnan")./sqrt(sum(~isnan(testError))),'o-','color',testColor,'markerfacecolor',testColor,'markeredgecolor','none','markersize',12);
set(gca,'visible','off');
getAxesP([1 4],1:4,4,20,'Rank',[0.2 .5]*100,[0.2:0.10:0.5]*100,0.55,0.85,'Firing rate R^2 (%)',[1 1]);
axis square;
axis tight;


subplot(222);
hold on
errorbar(1:4, mean(st(:,:,1)*100,"omitnan"), std(st(:,:,1)*100,"omitnan")./sqrt(sum(~isnan(testError))),'o-','color','k','markerfacecolor','k','markeredgecolor','none','markersize',12);
set(gca,'visible','off');
getAxesP([1 4],1:4,4,5,'Rank',[.05 0.4]*100,[0.05:0.10:0.4]*100,0.55,0.85,'RT R^2 (%)',[1 1]);
axis square;
axis tight;
base = mean(st1(:,1,1),"omitnan")*100;
line([1 4],[base base],'color','k','linestyle','--','linewidth',1)
end