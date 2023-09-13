clear all; close all; clc

% add path 
addpath('./LabCode');
% load data
classifier = load('~/code/tianwangrotation/JulPaperFigures/classifierData/classifier500SE.mat').classifier(8:end);
regression = load('~/code/tianwangrotation/JulPaperFigures/regressionData/regression500S.mat').regression(8:end);

load regressions.mat


classifier = regressions.classifier;
regression = regressions.linreg;

%%
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


line([0 0.4],[0 0.4],'color', 'k', 'linewidth', 5, 'linestyle', '--');
plot(prctile(shuffledMean,99), trueMean, 'mo', 'markersize', 15, 'markerfacecolor', 'm');
title('Population Summary', 'fontsize', 30)

% cosmetic code
hLimits = [0 0.4];
hTickLocations = 0:0.1:0.4;
hLabOffset = 0.02;
hAxisOffset =  -0.01;
hLabel = "Shuffled R^{2}"; 

vLimits = [0 0.4];
vTickLocations = 0:0.1:0.4;
vLabOffset = 0.04;
vAxisOffset =  -0.01;
vLabel = "Real R^{2}"; 

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


% export to excel source data
r2_data = [prctile(shuffledMean,99); trueMean];


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

line([0.45 0.6],[0.45 0.6],'color','k', 'linewidth', 5, 'linestyle', '--');
plot(prctile(shuffledMean,99), trueMean, 'mo', 'markerfacecolor', 'm', 'markersize', 15);
title('Population Summary', 'fontsize', 30)

% cosmetic code
hLimits = [0.45 0.6];
hTickLocations = 0.45:0.05:0.6;
hLabOffset = 0.02;
hAxisOffset =  0.45 - 0.005;
hLabel = "Shuffled Accuracy"; 

vLimits = [0.45 0.6];
vTickLocations = 0.45:0.05:0.6;
vLabOffset = 0.028;
vAxisOffset =  0.45 - 0.005;
vLabel = "Real Accuracy"; 

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

% export to excel source data
acc_data = [prctile(shuffledMean,99); trueMean];

% save figure
% set(gcf,'PaperUnits','inches','PaperPosition',[10 10 40 20])
% print -djpeg ./resultFigure/RT.jpg -r300
% print('-painters','-depsc',['./resultFigure/', 'Combined7','.eps'], '-r300');



