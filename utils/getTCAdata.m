function [forTCA, nL, nR, remoteDir, remoteScratch] = getTCAdata(sessionId, varargin)
%
%
% getGPFAdata(sessionId) gets the data from the session specified by
% sessionId
%
%   returns
%         dat
%         nL
%         nR
%         remoteDir
%         remoteScratch
%
%
% See also: getBinnedSpikesAllChannels, returnDat
%
% Chand, April 28th 2020

monkey = 'tiberius';
reMake = false;
filter = 'g';
binSize = 50;
alignType = 'g';

assignopts(who,varargin);

baseDir = '/net/derived/chand/TCAdata/';

switch(monkey)
    case {'t','tiberius'}
        [Sessions, remoteDir, remoteScratch] = validSessions;
    case {'o','Olaf'}
        [Sessions, remoteDir, remoteScratch] = validOlafSessions;
end
dataStructName = sprintf([baseDir '%s_dataStructs.mat'],Sessions(sessionId).name);

% If the dataStructure does not exist, then remake it from scratch.
% Otherwise load the existing data
saveTags = Sessions(sessionId).saveTags;
cprintf('green','Using existing directory: %s \n', dataStructName);
load(dataStructName,'dataStruct','dat');
[dat, nL, nR] = returnDat(dataStruct);

% add some nice metadata which might be very helpful for identifying the
% sessions etc.

forTCA.dataStruct = dataStruct;

forTCA.dat = dat;
forTCA.nL = nL;
forTCA.nR = nR;
forTCA.identifier = [monkey '_' Sessions(sessionId).name '_' sprintf('%d',Sessions(sessionId).saveTags{1})];
forTCA.metaData.monkey = monkey;
forTCA.metaData.sessionId = sessionId;
forTCA.metaData.sessionName = Sessions(sessionId).name;
forTCA.metaData.saveTags = Sessions(sessionId).saveTags{1};

