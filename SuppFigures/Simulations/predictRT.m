% Created by Tian Wang on Jan.10th 2023: function to predict RT 


function [r2] = predictRT(alignState, RT, decision, options)

side = options.side;

% input:
%     alignState: the stateActivity data: #units * #timestep * #trials
%     RT: reaction time: # trials * 1 
%     decision: decision made by each trial
%
%
% output:
%     r2: R^2 of the regression



% predict left RT
if (strcmp(side, 'left') == 1)

    alignState = alignState;
    % left & right trials
    right = decision == 1;
    left = decision == 0;

    trials1 = alignState(:,:,left);
    trials2 = alignState(:,:,right);

    % decoder to predict RT on choice 1 (without using predictRT function)
    r2 = zeros(size(trials1,2), 1);

    train_x = trials1;
    train_y = RT(left);

    for ii = 1 :size(train_x,2)
        fprintf('%d.',ii);
        t1 = [squeeze(train_x(:,ii,:))'];
    %     t1 = [squeeze(train_x(:,ii,:))'];
    %     t1 = coh(left);
        md1 = fitrlinear(t1, train_y, 'learner', 'leastsquares');
        label = predict(md1, t1);
        R = corrcoef(label, train_y);
        R2 = R(1,2).^2;
        r2(ii) = R2;
    end

    
end

















% predict right RT


if (strcmp(side, 'right') == 1)

    alignState = alignState;
    RT = checker.decision_time;
    % left & right trials
    right = checker.decision == 1;
    left = checker.decision == 0;

    coh = abs(checker.coherence);

    trials1 = alignState(:,:,left);
    trials2 = alignState(:,:,right);

    % decoder to predict RT on choice 1 (without using predictRT function)
    r2 = zeros(size(trials2,2), 1);

    train_x = trials2;
    train_y = RT(right);

    for ii = 1 :size(train_x,2)
        fprintf('%d.',ii);
        t1 = [squeeze(train_x(:,ii,:))', coh(right)];
    %     t1 = [squeeze(train_x(:,ii,:))'];
    %     t1 = coh(left);
        md1 = fitrlinear(t1, train_y, 'learner', 'leastsquares');
        label = predict(md1, t1);
        R = corrcoef(label, train_y);
        R2 = R(1,2).^2;
        r2(ii) = R2;
    end


end


% 
% tic
% % shuffled r2 of choice 1    
% shuffled_r2 = zeros(100, size(trials,2));
% 
% for sIdx = 1 : 100
% 
%     R = randperm(size(trials,3));
%     train_x = trials;
%     temp = RT;
%     train_yS = temp(R);
%     
%     for ii = 1 : size(train_x,2)
% 
%         t1 = [squeeze(train_x(:,ii,:))', coh];
%         md1 = fitrlinear(t1, train_yS, 'learner', 'leastsquares');
% 
%         label = predict(md1, t1);
%         R = corrcoef(label, train_yS);
%         R2 = R(1,2).^2;
%         shuffled_r2(sIdx, ii) = R2;    
%     end 
% 
% end
% bounds = zeros(2, size(trials,2)); 
% percentile = 100/size(shuffled_r2,1);
% 
% % calculate bound accuarcy
% bounds(1,:) = prctile(shuffled_r2, percentile, 1);
% bounds(2,:) = prctile(shuffled_r2, 100 - percentile, 1);

end

