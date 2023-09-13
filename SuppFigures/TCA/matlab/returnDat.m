function [dat,nL, nR] = returnDat(dataStruct)
%
%   Builds a structure which can be used with GPFA code
% 
%   CC - Shenoylab, 2014
%   CC - Chandlab, 2020

datL = buildDat(dataStruct, 'Left',0);
nL = length(datL);
datR = buildDat(dataStruct, 'Right',nL);
dat = [datL datR];
nR = length(datR);


function dat = buildDat(dataStruct, filter, startId)
%
%   systematically adds all the data into one long time series that is
%   suitable for GPFA analysis.
%   
if strcmp(filter,'Left')==1
    choice = 1;
else
    choice = 2;
end

% Create a fake id
X = dataStruct.binned.(filter);
dat(1).trialId = startId+1;
dat(1).spikes = squeeze(X(:,:,1))';
dat(1).RT = dataStruct.Info.(filter).goodRTs(1);
dat(1).delay = dataStruct.Info.(filter).Delay(1);
dat(1).Cue = dataStruct.Info.(filter).nSquares(1);
dat(1).GlobalTrialId = dataStruct.Info.(filter).GlobalTrialId(1);
dat(1).choice = choice;

for tId = 1:size(X,3)
    dat(tId).trialId = tId + startId;
    dat(tId).spikes = squeeze(X(:,:,tId))';
    dat(tId).RT = dataStruct.Info.(filter).goodRTs(tId);
    dat(tId).delay = dataStruct.Info.(filter).Delay(tId);
    dat(tId).Cue = dataStruct.Info.(filter).nSquares(tId);
    dat(tId).GlobalTrialId = dataStruct.Info.(filter).GlobalTrialId(tId);
    dat(tId).choice = choice;
end



