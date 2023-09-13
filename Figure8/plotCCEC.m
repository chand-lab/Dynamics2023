function plotCCEC(RT)


err=std(RT,'omitnan')./sqrt(length(RT));


figure;
errorbar(1:2,mean(RT(:,1:2),'omitnan'),2*err(1,1:2), 'g-o', 'LineWidth',3, 'MarkerSize',20,'CapSize',40); hold on;
errorbar(3,mean(RT(:,3),'omitnan'),2*err(1,3), 'r-o', 'LineWidth',3, 'MarkerSize',20,'CapSize',40);
errorbar(4,mean(RT(:,4),'omitnan'),2*err(1,4), 'g-o', 'LineWidth',3, 'MarkerSize',20,'CapSize',40);
plot(3:4,mean(RT(:,3:4),'omitnan'),'-k','LineWidth',3); 



ylabel('RT');xlabel('Trial Outcome');
ymin=floor(min(mean(RT,'omitnan')));
ymax=ceil(max(mean(RT,'omitnan')));
% ymed=median(median(RT,'omitnan'));
drawRestrictedLines(2.5,[ymin ymax]);
axis off
yLims=[ymin-3,ymax+3];
yTicks=ceil(linspace(ymin-3,ymax+3,5));
tg = getTextLabel(1:4,{'C','C','E','C'},{'g','g','r','g'});
xLims=[1, 4];
xTicks= [];
getAxesP(xLims, xTicks,5, min(mean(RT,'omitnan'))-10, 'Trial Outcome', yLims, yTicks, 0.4, 0.8, 'RT',[1 1],tg);
axis square;
axis tight;
end


%statistical analyses

%             figure;
%             histogram(CCEC_RT_filt(:,1)-CCEC_RT_filt(:,2))
%             figure;
%             histogram(CCEC_RT_filt(:,2)-CCEC_RT_filt(:,4))
%ks- test indicates the non-normality of the difference between the two
%distributions
%             [h, p]= kstest(CCEC_RT_filt(:,1)-CCEC_RT_filt(:,2))
%             [h, p]= kstest(CCEC_RT_filt(:,2)-CCEC_RT_filt(:,4))

%             figure;
%             ksdensity(CCEC_RT_filt(:,1)); hold on
%              ksdensity(CCEC_RT_filt(:,2));
%              ksdensity(CCEC_RT_filt(:,3));
%               ksdensity(CCEC_RT_filt(:,4));

%             round(median(CCEC_RT_filt))
%             round(std(CCEC_RT_filt))
%
%             [p,h,stats] = signrank(CCEC_RT_filt(:,1),CCEC_RT_filt(:,2))
%             [p,h,stats] = signrank(CCEC_RT_filt(:,2),CCEC_RT_filt(:,4))





