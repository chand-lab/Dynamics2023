function [TinRates, ToutRates] = arrangeData(S, varargin  )


subtractCCmean = false;
assignopts(who, varargin);

if subtractCCmean
    fprintf('\n Subtracting Cross Condition Mean ... ');
    Sb = nanmean(nanmean(S));
    Snew = S - repmat(Sb,[size(S,1) size(S,2) 1 1]);
else
    Snew = S;
end

TinRates = squeeze(Snew(:,1,:,:));
ToutRates = squeeze(Snew(:,2,:,:));


end

