
% load data for S17
load('ChoicePerRTbin_hardCoh.mat');
load('RTandChoice_hardCoh.mat')
load('RTandChoice_allCoh.mat');
load('decoderbyRTBinsAllCoh.mat')

% S17a
plotDecodeByBin(allDecodes,1)

% S17b
plotDecodeByBin(allDecodes,7)

% S17c,d
ChoiceSignals(allFastHardCoh, allSlowHardCoh,justHardRTsigmap,allRTsigmap)