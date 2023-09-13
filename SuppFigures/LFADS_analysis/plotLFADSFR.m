% created by Tian on Mar.16th, 2023. Plot some units and lfads FRs of 
% Oct14th, 2014 session 

function plotLFADSFR(lfadsR)



rates = lfadsR.rates;
validInds = lfadsR.validInds;
validRates = rates(:,:,validInds);
validRT = lfadsR.RT(validInds);
validChoice = lfadsR.choice(validInds);
validId = lfadsR.conditionIds(validInds);


raster = lfadsR.rawCounts;
% testPSTH: raw raster plot of recording
testPSTH = raster(:,:,validInds);

g = normpdf([-0.1:0.001:0.1], 0, 0.02);
psth = [];
% generate psth: convolve data
for ii = 1:size(testPSTH,1)
    for jj = 1:size(testPSTH,3)
        temp = squeeze(testPSTH(ii,:,jj));
        psth(ii,:,jj) = conv(temp, g, 'same');
    end
end

psth = psth(:,1:10:(end-2),:);
%%

% only choose left trials
validRates = validRates(:,:,validChoice == 1);
psth = psth(:,:,validChoice == 1);

t = linspace(-600,1200,size(rates,2));


psthAll = [];
psthMean = [];
ratesAll = [];
ratesMean = [];


figure; 
cnt = 1;
gt = getTextLabel(0,{'Cue'},{'b'});
for unit = [1,6,10,11]
    subplot(4,1,cnt);
    hold on
    plot(t, squeeze(psth(unit,:,1:5:end)),'color', [200 200 200]./255)
    plot(t, mean(squeeze(psth(unit,:,:)),2), 'color', [150 150 150]./255, 'linewidth', 3);

    plot(t, squeeze(validRates(unit,:,1:5:end)),'color', [243 169 114]./255)
    plot(t, mean(squeeze(validRates(unit,:,:)),2), 'color', [236 112 22]./255, 'linewidth', 3);
    hold on
    set(gca,'visible','off');
    getAxesP([-600 1200], setdiff(-600:200:1200,0),20,0,'Time (ms)',[0 150], 0:50:150,75,-625,'FR (Spks/s)',[1 1], gt);
    axis tight;
    drawRestrictedLines(0,[-5 150]);
    
    % generate source excel data
    % psthAll = [psthAll; [squeeze(psth(unit,:,1:5:end)), unit.*ones(size(psth,2),1),t']];
    % psthMean = [psthMean; mean(squeeze(psth(unit,:,:)),2)];
    % 
    % ratesAll = [ratesAll; squeeze(validRates(unit,:,1:5:end))];
    % ratesMean = [ratesMean; mean(squeeze(validRates(unit,:,:)),2)];
    % 
    
    
    cnt = cnt + 1;

    
end



%% 


LFADSFR = [psthAll, psthMean, ratesAll ratesMean];

end

% save('~/Desktop/sourceData/LFADS_analysis/LFADSFR.mat', 'LFADSFR');
