
% cd to inside ./DryadData/DryadDataSupp/FigureS14
lfadsR = load('Tsess1.mat');
folder=dir('*.mat');

% S14a
plotLFADSFR(lfadsR);

% S14b
lfadsSingleTrialVarianceExplained(folder);

% S14c
lfadsFR_RT_regression(folder);

