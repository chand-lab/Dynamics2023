function spikes = generateInhomRenewal(time, rate, varargin)
% spikes = generateInhomPoisson(time, rate)
%
% generates spike times from a time-dependent rate function
% as an inhomogeneous Poisson/Renewal process.
% rate function is linearly interpolated between the samples
%
% inputs:
%   time    -   array (N,1), time stamps for the rate samples
%   rate    -   array (N,1), rate samples
% output:
%   spikes  -   spike times

% default inputs
% Create input parser class
p = inputParser;
defaultProcess = 'poisson';
validProcesses = {'poisson', 'gamma'};
checkProcess = @(x) any(validatestring(x,validProcesses));

defaultShape = 1;
defaultScale = 1/1;


addRequired(p,'time',@isvector);
addRequired(p,'rate',@isvector);
addOptional(p,'process',defaultProcess, checkProcess);
addOptional(p,'shape',defaultShape);
addOptional(p,'scale',defaultScale);

parse(p,time, rate,varargin{:});


% check dimensions and parse inputs to make sure they actually reflect the
% correct dimensions. Should be easy enough to implement.
if (size(time,2)~=1)
    time = time';
    if (size(time,2)~=1)
        error('Time should be an Nx1 array.');
    end;
end;
if (size(rate,2)~=1)
    rate = rate';
    if (size(rate,2)~=1)
        error('Rate should be an Nx1 array.');
    end;
end;

if (all(size(time)~=size(rate)))
    error('Dimensions of time and rate vectors should be the same');
end;


% calculate cumulative rate
deltaT = time(2:end)-time(1:end-1);
r = [cumsum( rate(1:end-1).*deltaT )];
deltaR = r(2:end)-r(1:end-1);

% generate 1.5 as many spikes as expected on average for exponential distribution with rate 1
numX = ceil( 4*r(end) );

% generate exponential distributed spikes with the average rate 1
notEnough = true;
x = [];
xend = 0;
while (notEnough)
    switch(lower(p.Results.process))
        case {'poisson'}
            x = [ x; xend+cumsum(exprnd(1.0, numX, 1) )];
        case {'gamma'}
            % fprintf('..');
            x = [ x; xend+cumsum(gamrnd(p.Results.shape,p.Results.scale, numX, 1) )];
    end
    % check that we generated enough spikes
    xend = x(end);
    notEnough = xend<r(end);
end
% trim extra spikes
x(x>r(end)) = [];


 
try
% for each x find index of the last rate which is s  maller than x
indJ = arrayfun(@(y) find(r<y,1,'last'), x);
% This line sometimes barfs when there is no r < x(1)
% compute rescaled spike times
spikes = time(indJ) + (x-r(indJ)).*deltaT(indJ)./deltaR(indJ);

catch
   
    spikes = [];
    currR = [];
    for n=1:length(x)
        currInd = find(r < x(n),1,'last');
        % fprintf('\n %3.4f %3.4f %3.4f %3.4f %3.4f',x(n), time(currInd),(x(n)-r(currInd)).*deltaT(currInd)./deltaR(currInd), deltaT(currInd), deltaR(currInd));
        
        if ~isempty(currInd)
            spikes = [spikes; time(currInd) + (x(n)-r(currInd)).*deltaT(currInd)./deltaR(currInd)];
            currR = [currR r(currInd)];
            
        end
        
    end

    %%
    if 0
        figure(12);
        clf;
        subplot(4,4,[1:4]);
        
        plot(time, rate,'r-');
        xlim([-0.15 .7])
        hold on;
        set(gca,'visible','off');
        getAxesP([0 0.7],[0:0.1:0.7],'Time (s)',-0.5,1,[0 80],[0:20:80],'Firing Rate (spks/s)', -0.15,0.15,[1 1]);
        
        subplot(4,4,[5:16]);
        plot(spikes, -0.1,'marker','o','markersize',12,'markerfacecolor','r');
        line([spikes'; spikes'],[-0.2*ones(1,length(currR)); currR],'color',[0.3 0.3 0.3]);
        line([-0.1*ones(1,length(currR)); spikes'],[x'; x'],...
            'color',[0.3 0.3 0.3]);
        hold on;
        plot(-0.1, x,'marker','o','markersize',12,'markerfacecolor','r');
        plot(time(1:end-1), r,'m-','linewidth',2);
        xlim([-0.15 time(end)]);
        set(gca,'visible','off');
        getAxesP([0 0.7],[0:0.1:0.7],'Spike Time (s)',-0.5,1,[0 12],[0:2:12],'Rescaled Time (s)', -0.15,0.15,[1 1]);
    end
    
    
end

end
