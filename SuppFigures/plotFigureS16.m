
% load data for S16c
load regressions.mat
load 'decoderbyRTBins.mat'

% S16a, b
plotRegScatters(regressions)

% S16c
plotAccByBin(classifier);