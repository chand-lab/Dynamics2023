
% cd to inside ./DryadData/DryadDataSupp/LFADSdata
files=dir('*.mat');

% S13a
singleSessionLDS(files);

% S13b-c
bothEpochs(files);
