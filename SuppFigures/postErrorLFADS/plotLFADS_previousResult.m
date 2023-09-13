% plot LFADS trajectories with color representing previous trial results 
function plotLFADS_previousResult(regressions,Trials)

factors = regressions.lfadsR.factors;
data = regressions.raw.dat;
fullData =Trials;

test = reshape(factors, [size(factors,1), size(factors,2)*size(factors,3)])';
[coeff, score, latent] = pca(test);
orthF = [];
for thi = 1 : size(factors, 3)
    orthF(:,:,thi) = (score( (1:180) + (thi-1)*180, :))';
end

%%

[x,idx]=sort([data.GlobalTrialId]);

% LFADS trials sort by globalTrialID
data2=data(idx);

a = [data2.GlobalTrialId];

b = [fullData.GlobalTrialId];

[Lia, Locb] = ismember(a, b);

% fullData with trials same as data2
fullData2 = fullData(Locb);

% correctness of each trial in fullData
correctness = [];
for ii = 1 : length(fullData)
    
    correctness(ii) = fullData(ii).TrialOutcome == "Correct Choice";
%     correctResponse(ii) = a.CorrectResponse;
end

pre_correct = [ 2 correctness(1:end-1)];

pre_correct = pre_correct(Locb);

% correctness of trials in data2
correctness2 = correctness(Locb);

%% plot previous correct or wrong but current correct trials

preC_x = struct;
preC_y = struct;
preC_z = struct;
preW_x = struct;
preC_y = struct;
preW_z = struct;



% define which coherence to plot
coh = [1:7];
isCoh = ismember([data2.condId], coh);

trialId = [data2.trialId];
% extract previoius correct and current correct trials
preCorrectTrials = trialId(pre_correct == 1 & isCoh & correctness2 == 1);
% extract previoius wrong and current correct trials
preWrongTrials = trialId(pre_correct == 0 & isCoh & correctness2 == 1);

% extract previoius correct and current correct trials
preCorrectCurWrongTrials = trialId(pre_correct == 1 & isCoh & correctness2 == 0);
% extract previoius wrong and current correct trials
preWrongCurWrongTrials = trialId(pre_correct == 0 & isCoh & correctness2 == 0);

binWidth = 10;

figure;


portion = 0.3;
% randomly select 30% data of previous correct trials
idx = randperm(length(preCorrectTrials));
extract = sort(idx(1:round(length(idx)*portion)));
preCorrectTrials = preCorrectTrials(extract);

cnt = 1;
% plot previously correct trials for targeted coh (trial sequence same as data)
for id = 1:length(preCorrectTrials)
    trial1 = preCorrectTrials(id);
    if (floor(data(trial1).RT/binWidth) < 120)
        lastPt = 60 + floor(data(trial1).RT/binWidth);
%     else
%         lastPt = 180;
%     end
    
        plot3(orthF(1,40:lastPt,trial1), orthF(2,40:lastPt,trial1),orthF(3,40:lastPt,trial1), 'b');
        hold on
        % stimulus onset
        plot3(orthF(1,60,trial1), orthF(2,60,trial1),orthF(3,60,trial1), 'o', 'markeredgecolor', 'none', 'markerfacecolor', 'b', 'markersize', 8);
        % plot end dot
        plot3(orthF(1,lastPt,trial1), orthF(2,lastPt,trial1),orthF(3,lastPt,trial1), 'd', 'markeredgecolor', 'none', 'markerfacecolor', 'b', 'markersize', 10);    
    
    
        % generate source excel data
        preC_x(cnt).traj = orthF(1,40:lastPt,trial1);
        preC_y(cnt).traj = orthF(2,40:lastPt,trial1);
        preC_z(cnt).traj = orthF(3,40:lastPt,trial1);
        cnt = cnt+1;
    end
end



cnt = 1;
% plot previously wrong trials for targeted coh (trial sequence same as data)
for id = 1:length(preWrongTrials)
    trial1 = preWrongTrials(id);
    if (floor(data(trial1).RT/binWidth) < 120)
        lastPt = 60 + floor(data(trial1).RT/binWidth);
%     else
%         lastPt = 180;
%     end
    
        plot3(orthF(1,40:lastPt,trial1), orthF(2,40:lastPt,trial1),orthF(3,40:lastPt,trial1), 'm');
        hold on
        % stimulus onset
        plot3(orthF(1,60,trial1), orthF(2,60,trial1),orthF(3,60,trial1), 'o', 'markeredgecolor', 'none', 'markerfacecolor', 'm', 'markersize', 8);
        % plot end dot
        plot3(orthF(1,lastPt,trial1), orthF(2,lastPt,trial1),orthF(3,lastPt,trial1), 'd', 'markeredgecolor', 'none', 'markerfacecolor', 'm', 'markersize', 10);    
    
        
        
        % generate source excel data
        preW_x(cnt,:).traj = orthF(1,40:lastPt,trial1);
        preW_y(cnt,:).traj = orthF(2,40:lastPt,trial1);
        preW_z(cnt,:).traj = orthF(3,40:lastPt,trial1);    
        cnt = cnt+1;
    end
    
    
    
    
end


title('Example LFADS Trajectories', 'fontsize', 30);
set(gcf, 'Color', 'w');
axis off; 
axis square;
axis tight;

set(gca, 'LooseInset', [ 0 0 0 0 ]);
xlabel('X_1');
ylabel('X_2');
zlabel('X_3');
axis vis3d;

view([-21,21])

tv = ThreeVector(gca);
tv.axisInset = [0 0]; % in cm [left bottom]
tv.vectorLength = 2; % in cm
tv.textVectorNormalizedPosition = 1.3; 
tv.fontSize = 15; % font size used for axis labels
tv.fontColor = 'k'; % font color used for axis labels
tv.lineWidth = 3; % line width used for axis vectors
tv.lineColor = 'k'; % line color used for axis vectors
tv.update();
rotate3d on;

ax = gca;
ax.SortMethod = 'childorder';

end

