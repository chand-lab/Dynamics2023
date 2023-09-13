function [pcData] = calculatePCs(r,FR,varargin)
%
%
% Chand, April 2023


removeTime = r.metaData.removeTime;
projectFromMean = false;
projectToOutcome = false;
outSpace = [];
nDims = 8;
assignopts(who, varargin);
t = r.metaData.t;
tMin = r.metaData.tMin;
O = r.metaData.RTlims(1,:) - removeTime;

[TinRates, ToutRates] = arrangeData(FR, 'subtractCCmean', r.processingFlags.subtractCCmean);

XallIn = [];
XallOut = [];
tData = {};
Lens = [];
cnt = 1;


for b= r.metaData.whichConds
    tV = find(t > tMin & t < O(b)./1000);
    X = squeeze(TinRates(b,:,tV));
    XallIn = [XallIn; X'];
    X = squeeze(ToutRates(b,:,tV));
    XallOut = [XallOut; X'];
    Lens(cnt) = length(tV);
    tData{cnt} = t(tV);
    cnt = cnt + 1;
end

r.metaData.tMax = max(tData{end});


Ndimensions = 200;
[Data] = preprocessData(XallIn, XallOut, 'zScore', r.processingFlags.zScore, 'tColor', r.processingFlags.tColor);



Ye = Data;
Ye(isnan(Ye)) = nanmean(Ye(:));
[eigenVectors, score,latentActual] = pca(Ye);

if projectFromMean
    eigenVectors = r.signalplusnoise.eigenVectors;
    score = Ye*eigenVectors;
    D = eigenVectors(:,1:nDims);
    trace(D'*cov(Ye)*D)./sum(latentActual(1:nDims))
    sum(latentActual(1:nDims))./sum(latentActual)
end

if projectToOutcome
    % project RT data into outcome space
    reducedOutSpace=outSpace(r.metaData.neuronIdx,1:6);
    scoreProjRT = Ye*reducedOutSpace;
    [TrajInProjRT, TrajOutProjRT] = chopScoreMatrix(scoreProjRT, Lens);
    pcData.TrajInProjRT = TrajInProjRT;
    pcData.TrajOutProjRT = TrajOutProjRT;
end

[TrajIn, TrajOut] = chopScoreMatrix(score, Lens);

pcData.TrajIn = TrajIn;
pcData.TrajOut = TrajOut;
pcData.eigenVectors = eigenVectors;
pcData.score = score;
pcData.latentActual = latentActual;
pcData.varExplained = 100*latentActual./sum(latentActual);
pcData.tData = tData;
pcData.covMatrix = cov(Ye);

end