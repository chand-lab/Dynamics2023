function [FR, FRc, RT, tNew,nNeuronsOut]=simulatePMdneurons(whichType,kernel,nNeurons,nTrials)

time = [0:1:200]/100;


FRsim = [];
binSize = 0.05;
RT = [200+100*gamrnd(5,0.5,nTrials,1)]./1000;

baseline = 5;

% baseline firing rate of 2 choices
nF = 5 + 7*rand(1,nNeurons);
nF2 = 2 + 1*rand(1,nNeurons);
spikes = [];

tStart = 0.6;
% Latency
tLatency = 0.1;
CISmult = 15;
%kernel = 0.02;

%whichType = 'RT';
%assignopts(who,varargin);

cprintf('cyan',sprintf('-----------------------------------------------\n Simulating %d Neurons from %s, %d trials per neuron \n', nNeurons, whichType, nTrials));

parfor_progress(nNeurons);
parfor neuronId = 1:nNeurons
    if rand < 0.2
        baseFR = 3*rand+2;
        baseline = 0;
    else
        baseFR = 0;
        baseline = 5;
    end
    parfor_progress;
    spikes = [];
    for nChoice = 1:2
        for nTrials = 1:length(RT)
            tLag = tStart + tLatency + 0.2*RT(nTrials);
            rate = [];
            switch(whichType)
                case 'RT'
                    switch(nChoice)
                        case 1
                            rate = baseline  + ((baseFR)./RT(nTrials) + nF(neuronId)*max((time-tLag)./(RT(nTrials)),0) + max(CISmult*(time-tLag),0));
                        case 2
                            rate = baseline +  (baseFR)./RT(nTrials) - nF2(neuronId)*max((time-tLag)./((RT(nTrials))),0) + max(CISmult*(time-tLag),0);
                            rate(rate < 0) = 0;
                    end
                    
                case 'BiasedChoice'
                    
                    switch(nChoice)
                        case 1
                            rate = baseline + 4*rand + max(CISmult*(time-tLag),0) + nF(neuronId)*max((time-tLag)./RT(nTrials),0);
                        case 2
                            rate = baseline + 2*rand + max(CISmult*(time-tLag),0)- nF2(neuronId)*max((time-tLag)./RT(nTrials),0);
                            rate(rate < 0) = 0;
                    end
                    
                case 'UnbiasedChoice'
                    
                    switch(nChoice)
                        case 1
                            rate = baseline + max(CISmult*(time-tLag),0) + nF(neuronId)*max((time-tLag)./RT(nTrials),0);
                        case 2
                            rate = baseline + max(CISmult*(time-tLag),0)- nF2(neuronId)*max((time-tLag)./RT(nTrials),0);
                            rate(rate < 0) = 0;
                    end
                    
                    
            end
            
            
            spikes(nTrials).times = generateInhomRenewal(time,rate,'process','poisson');
        end
        
        [~,t,~,RR] = psthcc(spikes, kernel, 'n',[0 1.6],2,[0:.001:1.6]);
        FRsim(neuronId, :,nChoice, :) = RR;
    end
end

parfor_progress(0);
fprintf('\n Done');
FRsim2 = FRsim;

%% Create perimovement neurons
FR2 = [];
baseline = 5;
parfor_progress(50);

for neuronId = 1:50
    OnsetTime = 20*rand-10;
    
    if rand > 0.5
        mult = [100 50];
    else
        mult = [50 100];
    end
    parfor_progress;
    spikes = [];
    for nChoice=1:2
        for nTrials = 1:length(RT)
            rate = baseline*ones(1,length(time));
            onsetTime = floor(ceil([tStart + RT(nTrials)])*100-OnsetTime);
            
            rate(onsetTime-20:onsetTime+20) = baseline + mult(nChoice)*normpdf(-20:1:20,0,2);
            rate = rate(1:length(time));
            spikes(nTrials).times = generateInhomRenewal(time,rate,'process','poisson');
        end
        [~,t,~,RR] = psthcc(spikes, kernel, 'n',[0 2],2,[0:.001:1.6]);
        FR2(neuronId, :,nChoice, :) = RR;
    end
end
parfor_progress(0);



%% Combine neurons into one big FR matrix.

% Creates decreased neurons
nNeuronsOut = size(FRsim2,1);
FRtemp = max(10-FRsim2(1:nNeuronsOut/2,:,:,:),0);
FR = [];
FR = cat(1, FRsim2, FRtemp);
FR = cat(1, FR, FR2);

% FR: firing rate of 3 combined simulated neurons
FR = FR(:,:,:,100:end);
tNew = t(100:end) - tStart;


nNeurons2 = size(FR,1);
FRc = [];
FRc(1:2:nNeuronsOut,:,:,:) = FR(1:2:nNeuronsOut,:,[2 1],:);
FRc(2:2:nNeuronsOut,:,:,:) = FR(2:2:nNeuronsOut,:,[1 2],:);

end
