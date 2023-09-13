function calcKinetStatistics(r)
% calculates shuffled distributsion for KiNeT analysis.
%
% calculates the shuffled distributions for KiNeT analysis to finally get p
% values associated with the KiNeT analysis and quantify the
% representational geometry in our PMd data
%
% CC, March 30th 2022

sX = [];
for k=1:100
    
    
    ix = randperm(size(r.rtFR,1));
    
    [shuffleX] = r.calculatePCs(r.rtFR(ix,:,:,:));
    
    fprintf('... Shuffle %d',k);
    
    K = r.calcSpeed(shuffleX);
    shuffle.speed(k,:,:) = K.V;
    shuffle.distance(k,:,:) = K.distancesAll;
    
end
shuffle.tVect = K.tVect;
r.kinet.shuffle = shuffle;

end
