function [ Data, directions, params ] = preprocessData(XallIn, XallOut, varargin )
%
%
% CC, March 12th 2014
% CC, June 30th 2015
meanSubtract = false;
softNorm = true;
zScore = false;
tColor = 'blue';
verbose = false;
Mu = [];
Sigma = [];
assignopts(who, varargin);
directions = [];




if meanSubtract
    fprintf('\n Centering --- ');
    % cprintf(tColor, '\n Centering Data ...');
    Data = [XallIn; XallOut];
    if isempty(Mu)
        Mu = nanmean(Data);
    else
        
    end
    
    Data = [Data - repmat(Mu,[size(Data,1) 1])];
    params.Mu = Mu;
    if verbose
        fprintf('Centering Data');
    end
else
    fprintf('\n');
    
end

if softNorm
    fprintf('Using Softnorm');
    Data = [XallIn; XallOut];
    
    
  
    if isempty(Mu)
        Mu = nanmean(Data);
    else
        fprintf(' .... Using Existing Mu for bootstrap');
    end
    Data = [Data - repmat(Mu,[size(Data,1) 1])];
    
    if isempty(Sigma)
        Sigma = sqrt(prctile(abs(Data),99)+2);
    end
    
    Data = [Data]./repmat(Sigma, size(Data,1),1);
 
    directions.Left = [Data(1:size(XallIn,1),:)];
    directions.Right = [Data(size(XallIn,1)+1:end,:)];
    params.Mu = Mu;
    params.Sigma = Sigma;
end

if zScore
    %     cprintf(tColor, '\n Variance Normalization ....');
    if verbose
        fprintf('Variance Normalization ');
    end
    Data = [XallIn; XallOut];
    Data = sqrt(Data);
    if isempty(Mu)
        Mu = nanmean(Data);
    else
        
    end
    
    if isempty(Sigma)
        Sigma = nanstd(Data);
    end
    Data = [Data - repmat(Mu,[size(Data,1) 1])];
    Data = [Data]./repmat(Sigma,[size(Data,1) 1]);
    params.Mu = Mu;
    params.Sigma = Sigma;
end


end

