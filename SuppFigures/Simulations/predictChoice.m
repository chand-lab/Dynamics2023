% Created by Tian Wang on Dec.29th 2022: function to predict choice


function [accuracy] = predictChoice(alignState, RT, decision, options, thresholdSide)


rtThreshold = options.rtThreshold;




% decoder to predict choice
accuracy = zeros(size(alignState,2), 1);

% equalize left and right trials
% c1Trials = find(checker.decision == 0 & RT > 500 & RT < 1500 & abs(checker.coherence_bin) <=0.2);
% c2Trials = find(checker.decision == 1 & RT < 500 & RT < 1500 & abs(checker.coherence_bin) <=0.2);

if (strcmp(thresholdSide, 'less'))
    c1Trials = find(decision == 0 & RT < rtThreshold);
    c2Trials = find(decision == 1 & RT < rtThreshold);
end

if (strcmp(thresholdSide, 'greater'))
    c1Trials = find(decision == 0 & RT > rtThreshold);
    c2Trials = find(decision == 1 & RT > rtThreshold);
end


num = min(length(c1Trials), length(c2Trials));

index1 = randperm(length(c1Trials));
extract1 = sort(index1(1:num));
index2 = randperm(length(c2Trials));
extract2 = sort(index2(1:num));

% extract trials feed into classifier
extract = [c1Trials(extract1); c2Trials(extract2)];

train_x = alignState(:, :, extract);
train_y = decision(extract) - 1;
fprintf('\n');


parfor ii = 1 : size(train_x,2)
    
    t1 = [squeeze(train_x(:,ii,:))'];
    
    md1 = fitclinear(t1, train_y, 'learner', 'logistic', 'KFold', 10);
    
    error = kfoldLoss(md1);
    accuracy(ii) = 1 - error;
end


end

