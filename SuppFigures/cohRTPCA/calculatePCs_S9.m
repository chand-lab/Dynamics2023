% calculate the PC for S9
function [pcData]=calculatePCs_S9(data)

t=linspace(-0.6,1.2,1801);
tMin = -0.4;
orgRTs=data.CohRTbinRTs(:);
data.medRTs=cellfun(@median,orgRTs);
O = repmat([300,425,600],[1,3]);

subtractCCmean=false;
S=permute(data.FR_CohRT4D_trunc,[3 4 2 1]);

if subtractCCmean
    fprintf('\n Subtracting Cross Condition Mean ... ');
    Sb = nanmean(nanmean(S));
    Snew = S - repmat(Sb,[size(S,1) size(S,2) 1 1]);
else
    Snew = S;
end

TinRates = squeeze(Snew(:,1,:,:));
ToutRates = squeeze(Snew(:,2,:,:));

XallIn = [];
XallOut = [];
tData = {};
Lens = [];
cnt = 1;


for b=1:9 % r.metaData.whichConds
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
[Data] = preprocessData(XallIn, XallOut, 'meanSubtract', false, 'zScore', false, 'tColor', 'blue');

Ye = Data;
Ye(isnan(Ye)) = nanmean(Ye(:));
[eigenVectors, score,latentActual] = pca(Ye);
[TrajIn, TrajOut] = chopScoreMatrix(score, Lens);

pcData.TrajIn = TrajIn;
pcData.TrajOut = TrajOut;
pcData.eigenVectors = eigenVectors;
pcData.score = score;
pcData.latentActual = 100*latentActual;
pcData.varExplained = 100*latentActual./sum(latentActual);
pcData.tData = tData;
pcData.tMin=tMin;

params=getParams();
cVs = params.posterColors(1:11,:);
pcData.cValues = [cVs(1,:) 1; cVs(6,:) 1; cVs(11,:) 1; cVs(1,:) 0.4; cVs(6,:) 0.4; cVs(11,:) 0.4; cVs(1,:) 0.1; cVs(6,:) 0.1; cVs(11,:) 0.1];


end


             