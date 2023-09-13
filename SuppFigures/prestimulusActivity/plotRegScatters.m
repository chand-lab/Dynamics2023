
function plotRegScatters(regressions)

classifier = regressions.classifier;
regression = regressions.linreg;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% Regression Plots
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get average data
r2 = [];
shuffledR2 = [];

for ip2 = 1 : length(regression)
    r2(:,ip2) = (regression(ip2).c1R2 + regression(ip2).c2R2)./2 ;
    shuffledR2(:,:,ip2) = (regression(ip2).shuffledC1R2 + regression(ip2).shuffledC2R2)./2;
end

meanR2 = mean(r2,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate p-value 
trueMean = mean(r2(1:30,:),1);
shuffledMean = squeeze(mean(shuffledR2(:,1:30,:),2));
alpha = 0.05/length(regression);

% plot 99 percentile shuffleMean 
subplot(1,2,1); hold on

line([0 0.4*100],[0 0.4*100],'color', 'k', 'linewidth', 5, 'linestyle', '--');
plot(prctile(shuffledMean,99)*100, trueMean*100, 'mo', 'markersize', 15, 'markerfacecolor', 'm','MarkerEdgeColor',[0.1 0.1 0.1]);
%title('Population Summary', 'fontsize', 30)

% cosmetic code
hLimits = [0 0.4*100];
hTickLocations = 0:0.1*100:0.4*100;
hLabOffset = 0.02*100;
hAxisOffset =  -0.01*100;
hLabel = "Shuffled R^{2} (%)"; 

vLimits = [0 0.4]*100;
vTickLocations = 0:0.1*100:0.4*100;
vLabOffset = 0.04*100;
vAxisOffset =  -0.01*100;
vLabel = "Real R^{2} (%)"; 

plotAxis = [1 1];

[hp,vp] = getAxesP(hLimits,...
    hTickLocations,...
    hLabOffset,...
    hAxisOffset,...
    hLabel,...
    vLimits,...
    vTickLocations,...
    vLabOffset,...
    vAxisOffset,...
    vLabel, plotAxis);

set(gcf, 'Color', 'w');
axis off; 
axis square;
axis tight;


% % export to excel source data
% r2_data = [prctile(shuffledMean,99); trueMean];


%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% Choice Plots
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mean accuracy
accuracy = [];
shuffledAcc = [];
for ip2 = 1 : length(classifier)
    accuracy(:,ip2) = classifier(ip2).accuracy;
    shuffledAcc(:,:,ip2) = classifier(ip2).shuffled_accuracy;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate p-value 

trueMean = mean(accuracy(1:30,:),1);
shuffledMean = squeeze(mean(shuffledAcc(:,1:30,:),2));

% plot 99 percentile shuffleMean 
subplot(1,2,2); hold on

line([0.45 0.6]*100,[0.45 0.6]*100,'color','k', 'linewidth', 5, 'linestyle', '--');
plot(prctile(shuffledMean,99)*100, trueMean*100, 'mo', 'markerfacecolor', 'm', 'markersize', 15,'MarkerEdgeColor',[0.1 0.1 0.1]);
%title('Population Summary', 'fontsize', 30)

% cosmetic code
hLimits = [0.45 0.6]*100;
hTickLocations = 0.45*100:0.05*100:0.6*100;
hLabOffset = 0.01*100;
hAxisOffset =  0.45*100 - 0.005*100;
hLabel = "Shuffled Accuracy (%)"; 

vLimits = [0.45 0.6]*100;
vTickLocations = 0.45*100:0.05*100:0.6*100;
vLabOffset = 0.02*100;
vAxisOffset =  0.45*100 - 0.005*100;
vLabel = "Real Accuracy (%)"; 

plotAxis = [1 1];

[hp,vp] = getAxesP(hLimits,...
    hTickLocations,...
    hLabOffset,...
    hAxisOffset,...
    hLabel,...
    vLimits,...
    vTickLocations,...
    vLabOffset,...
    vAxisOffset,...
    vLabel, plotAxis);

set(gcf, 'Color', 'w');
axis off; 
axis square;
axis tight;


% set display size
set(gcf,'Units','inches','Position',[10 10 40 20])
set(gca,'LooseInset',get(gca,'TightInset'));

% % export to excel source data
% acc_data = [prctile(shuffledMean,99); trueMean];
end




