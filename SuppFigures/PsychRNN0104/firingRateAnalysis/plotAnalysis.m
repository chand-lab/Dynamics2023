% Created by Tian Wang on Dec.29th 2022: plot analysis of pmdPCA.m;
% regressionRT.m and predictChoice.m together 

% aligned to checkerboard
clear all; close all; clc

addpath('/net/derived/tianwang/LabCode');

% On linux work station (for checkerPmd)

% addpath('/net/derived/tianwang/LabCode');
% 



whichModel = 'inputbias2023';
switch(lower(whichModel))
    case 'gainm2023'
        temp = load('~/Downloads/PsychRNN0104/resultData/gainM20230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/gainM20230809.csv");
    case 'delay2023'
        temp = load('~/Downloads/PsychRNN0104/resultData/delay20230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/delay20230809.csv");
    case 'vanilla2023'
        temp = load('~/Downloads/PsychRNN0104/resultData/vanilla20230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/vanilla20230809.csv");
    case 'leftbias2023'
        temp = load('~/Downloads/PsychRNN0104/resultData/leftBias20230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/leftBias20230809.csv");
    case 'inputbias2023'
        temp = load('~/Downloads/PsychRNN0104/resultData/inputBias20230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/inputBias20230809.csv");
    case 'inputbias402023'
        temp = load('~/Downloads/PsychRNN0104/resultData/inputBias4020230809.mat').temp;
        checker = readtable("~/Downloads/PsychRNN0104/resultData/inputBias4020230809.csv");

        
end
        
  

%% only choose trials with 95% RT
sortRT = sort(checker.decision_time);
disp("95% RT threshold is: " + num2str(sortRT(5000*0.95)))
% rtThresh = checker.decision_time <= sortRT(5000*0.95);

rtLower = prctile(sortRT(sortRT > 0),2.5)
% rtLower = 0;
rtUpper = prctile(sortRT(sortRT > 0),97.5)

unitsChosen = 20;
% threshold of fast vs slow RT in prediction choice
rtThres = 50;

before = 200;
after = 500;

rtThresh = checker.decision_time >= rtLower & checker.decision_time < rtUpper;
checker = checker(rtThresh, :);
temp = temp(:,:,rtThresh);

[a, b, c] = size(temp);

%% align data to checkerboard onset (target onset)

% reaction time; targetOn time and checkerOn time
RT = checker.decision_time;
targetOn = checker.target_onset;
checkerOn = checker.checker_onset;

% real RT, targetOn and checkerOn round to 10's digit
RTR = round(RT, -1);
targetOnR = round(targetOn,-1);
checkerOnR = round(checkerOn + targetOn, -1);


% % left & right trials
% right = checker.decision == 1;
% left = checker.decision == 0;
% 
% coh = checker.coherence;

% state activity alignes to checkerboard onset, with 200ms before and 800
% ms after

alignState = [];
for ii = 1 : c
    zeroPt = checkerOnR(ii)./10 + 1;
    alignState(:,:,ii) = temp(:,zeroPt - before/10:zeroPt + after/10, ii);
end

[a, b, c] = size(alignState);

%% plot pca plots: 


% how many units used to regress RT
% options of figure plotting 
options.handle = subplot(1,3,1);
options.span = [-before, after];
options.type = 'RT';
% options.rtBin = 50:50:400;
options.rtThreshold = prctile(RTR,rtThres);

% vanilla: [-111,65];
% multiplicative: [100 -41];
% initial condiiton: [-111,65];
% delay: [-111,65]
options.viewAngle = [100,-42];
options.orthDim = [1 2 3];
% figure handle; before & after; switch between coh and RT pca; RT bins




trajs = generatePCA(alignState, checker, options);


%% plot RT regression

%%%%%%%%%%%%%%%%%%%%%%%% calculate regression every 5 time points
figure;
set(gcf,'position',[1000,1000,2000,600])

% figure handle; 
[r2, r2_coh] = predictRTregress(alignState, checker, unitsChosen);

subplot(1,3,2); hold on

t = linspace(-before, after, length(r2));

% vanilla: [0,0.7];
% multiplicative: [0.2 0.8];
% initial: [0 0.8];
% delay: [0.4 0.8]

yLower = 0.1;
yUpper = 0.6;

ylimit = [yLower, yUpper]
xpatch = [-before -before 0 0];
ypatch = [yLower yUpper yUpper yLower];
p1 = patch(xpatch, ypatch, 'cyan');
p1.FaceAlpha = 0.2;
p1.EdgeAlpha = 0;

% plot(t, bounds', '--', 'linewidth', 5);
plot(t, r2, 'linewidth', 5, 'color', [236 112  22]./255)
yline(r2_coh, '--')

plot([0,0], ylimit, 'color', [0.5 0.5 0.5], 'linestyle', '--', 'linewidth',5)
title('Regression on RT', 'fontsize', 30)


% cosmetic code
hLimits = [-before,after];
hTickLocations = -before:200:after;
hLabOffset = 0.05;
hAxisOffset = yLower-0.01;
hLabel = "Time: ms"; 

vLimits = ylimit;
vTickLocations = [yLower (yLower + yUpper)/2 yUpper];
vLabOffset = 150;
vAxisOffset = -before-20;
vLabel = "R^{2}"; 

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

% 
% save('./resultData/boundAr.mat', 'bounds');
% save('./resultData/r2Ar.mat', 'r2');
% print('-painters','-depsc',['~/Desktop/', 'RTdelayC','.eps'], '-r300');


%% plot decoder results

% figure handle;fast or slow

accuracy_fast = predictChoice(alignState, checker, options, 'less');
accuracy_slow = predictChoice(alignState, checker, options, 'greater');
t = linspace(-before, after, length(accuracy_fast));

% plot fast trials decoding accuracy
subplot(1,3,3); hold on

yLower = 0.4;
yUpper = 1;

xpatch = [yLower yLower -before -before];
ypatch = [yLower yUpper yUpper yLower];
p1 = patch(xpatch, ypatch, 'cyan');
p1.FaceAlpha = 0.2;
p1.EdgeAlpha = 0;

plot(t, accuracy_fast,'linewidth', 3)
yline(0.5, 'k--')
xlabel('Time (ms)')
ylabel('Accuracy')
title('Prediction accuracy')

% plot slow trials decoding accuracy
subplot(1,3,3); hold on
plot(t, accuracy_slow,'linewidth', 3)
yline(0.5, 'k--')
xlabel('Time (ms)')
ylabel('Accuracy')
title('Prediction accuracy')



xline(0, 'color', [0.5 0.5 0.5], 'linestyle', '--')




% cosmetic code
hLimits = [-before,after];
hTickLocations = -before:200:after;
hLabOffset = 0.05;
hAxisOffset =  yLower - 0.01;
hLabel = "Time: ms"; 


vLimits = [yLower,yUpper];
vTickLocations = [yLower (yLower + yUpper)/2 yUpper];


vLabOffset = 150;
vAxisOffset = -before-20;
vLabel = "Accuracy"; 

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




%% store figure

% print('-painters','-depsc',['~/Desktop/', 'gainm20230809','.eps'], '-r300');


%% 

% export source excel data
bigT = [t', r2, r2_coh.*ones(length(r2),1), accuracy_fast, accuracy_slow];

T1 = array2table(bigT, 'VariableNames',{'t','r2','r2_coh','acc_fast','acc_slow'});

bigDL = [];
bigDR = [];
currDL = [];
currDR = [];
for jj = 1:length(trajs)
    
    currDL = [trajs(jj).leftTrajAve];
    currDL(:,end+1) = jj;
    bigDL = [bigDL; currDL];
    
    currDR = [trajs(jj).rightTrajAve];
    currDR(:,end+1) = jj;
    bigDR = [bigDR; currDR];    
end

T2 = array2table(bigDL, 'VariableNames',{'leftx','lefty','leftz', 'rtbin'});
T3 = array2table(bigDR, 'VariableNames',{'rightx','righty', 'rightz', 'rtbin'});

% writetable(T1, '~/Desktop/sourceData/RNN_sim/gainmplot.xlsx');
% writetable(T2, '~/Desktop/sourceData/RNN_sim/gainmLeftTraj.xlsx');
% writetable(T3, '~/Desktop/sourceData/RNN_sim/gainmRightTraj.xlsx');
