function [NeuronsC] = PCAbyCoherence(NeuronsC, varargin)
% PCAbyCoherence - Computes PCA on the basis of the different neurons
% organized by the coherence of the central checkerboards
%
%
%
%
%
% CC, Shenoylab, February 2014
useTuning = true;
meanSubtract = true;
zScore = false;
softNorm = false;
subtractCCmean = false;
assignopts(who, varargin);

params = getParams;
t = NeuronsC.tS;
I = squeeze(nanmin(NeuronsC.RTall,[],2));
O = nanmedian(I)
% O = 400*ones(1,size(I,2));
cnt = 1;
bAll = [1:size(NeuronsC.FR,1)];
XallIn = [];
XallOut = [];
Lens = [];

tMin = -0.4;

if useTuning
    if ~isfield(NeuronsC,'TinRates');
        NeuronsC = returnTunedSpikes(NeuronsC);
    end
    TinRates = NeuronsC.TinRates;
    ToutRates = NeuronsC.ToutRates;
    % TallRates = [TinRates; ToutRates];
    % TinRates = TinRates - repmat(nanmean(TallRates),[size(TinRates,1) 1 1]);
    % ToutRates = ToutRates - repmat(nanmean(TallRates),[size(TinRates,1) 1 1]);
else
    [TinRates, ToutRates] = arrangeData(NeuronsC.FR);
end

% Make a PCA matrix for all the conditions.
for b= bAll
    
    tV = find(t > tMin & t < (O(b)-25)./1000);
    X = squeeze(TinRates(b,:,tV));
    XallIn = [XallIn; X'];
    X = squeeze(ToutRates(b,:,tV));
    tData{cnt} = t(tV);
    XallOut = [XallOut; X'];
    Lens(cnt) = length(tV);
    tData{cnt} = t(tV);
    cnt = cnt + 1;
end

disp('Running Stim PCA');

% Actual Heavy Lifting

Ndimensions = 11;
Data = preprocessData(XallIn, XallOut, 'meanSubtract',meanSubtract, 'zScore', zScore, 'softNorm', softNorm);
% [C, ss, M, score,Ye] = ppca_mv(Data,Ndimensions,1);
Ye = Data;
Ye(isnan(Ye)) = nanmean(Ye(:));


[coeff, score,latent] = pca(Ye);

[TrajIn, TrajOut] = chopScoreMatrix(score, Lens);



NeuronsC.pcModel.tMin = tMin;
NeuronsC.pcModel.align = 'checkerboard';
NeuronsC.pcModel.TrajIn = TrajIn;
NeuronsC.pcModel.TrajOut = TrajOut;
NeuronsC.pcModel.tData = tData;
NeuronsC.pcModel.coeff = coeff;
NeuronsC.pcModel.score = score;
NeuronsC.pcModel.latent = latent;
NeuronsC.pcModel.type = 'coherence';
NeuronsC.pcModel.meanSubtract = meanSubtract;
NeuronsC.pcModel.zScore = zScore;
NeuronsC.pcModel.subtractCCmean = subtractCCmean;
NeuronsC.pcModel.t = t;


NeuronsC.pcModel.tData = tData;
NeuronsC.pcModel.rawData.all = Ye;
NeuronsC.pcModel.rawData.Left = Ye(1:sum(Lens),:);
NeuronsC.pcModel.rawData.Right = Ye(sum(Lens)+1:end,:);
NeuronsC.pcModel.Lens = Lens;
