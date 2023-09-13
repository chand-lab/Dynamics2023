%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% created by Tian on Dec.1th 2022: predict choice using different reaction time bins 
%%% Choose each condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc

% dirName and path should not change; this code should always
% run on linux workstation or scc

% workstation path:
% dirName = '/net/derived/tianwang/LFADSdata/*.mat';
% path = '/net/derived/tianwang/LFADSdata/';
% scc path: 
% dirName = '/project/chandlab/LFADSdata/*.mat';
% path = '/project/chandlab/LFADSdata/';



% define reaction time bins

% N1 = [200; 325; 350; 375; 400; 425; 450; 475; 500; 525;  500 ];
% N2 = [425; 425; 450; 475; 500; 525; 550; 575; 600; 625; 1000 ];

N1 = [200; 425; 500];
N2 = [425; 500; 1000];
RTBin = [N1 N2];


dirName = '/net/derived/tianwang/LFADSdata/*.mat';
path = '/net/derived/tianwang/LFADSdata/';
savePath = './classifierData';

folder = dir(dirName);

% structure to store results
% classifer should be 58 by 1 struct. In each element, it should be a 
% time * RTBin (90 by 6) matrix
% as for bins with less than 50 left an 50 right trials, put NaN on all of
% the entries 
threshold = 5;


allDecodes = struct;

tic


for condId = [1:7]
    classifier = struct;
    accuracy = [];




    % loop through folder 
    for id = 1:length(folder)
        
        fullName = [path folder(id).name];
        data = load(fullName).forGPFA;
        
        
        % temp: table containing behavior data
        % trials: 3D matrix of spike counts
        trials_data = data.dat;
        temp = struct2table(trials_data);
        % whichConds: make the coherence to be the target condId
        whichConds = ismember(temp.condId,[condId condId+7]);
        
        % spike counts with a bin size
        bin_size = 20;
        interval = 20;
        % seq = getSeq(trials_data, bin_size);
        seq = slideBins(trials_data,bin_size, interval);
        
        trials = [];
        for ii = 1 : length(seq)
            trials(ii,:,:)= seq(ii).y;
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% Only choose trials with targeted condition
        temp = temp(whichConds,:);
        trials = trials(whichConds,:,:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % decoder to predict choice (#time by #bins)
        accuracy = zeros(size(trials,3), size(RTBin, 1));
        % total shuffled accuracy (#shuffle #time by #bins)
        totalShuffledAccuracy = zeros(500, size(trials,3), size(RTBin, 1));
        % total shuffled bound (2 by #time by #bins)
        totalBounds = zeros(2, size(trials,3), size(RTBin, 1));
        
        % loop through RT Bins
        for idx = 1:size(RTBin, 1)
            
            RT_selection = temp.RT >= RTBin(idx, 1) & temp.RT < RTBin(idx, 2);
            % equalize left and right trials
            c1Trials = find(temp.choice == 1 & RT_selection);
            c2Trials = find(temp.choice == 2 & RT_selection);
            num = min(length(c1Trials), length(c2Trials));
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%% debug use: print length of each choice
            %     disp(['trial # ' num2str(id)])
            %     length(c1Trials)
            %     length(c2Trials)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%% if not enough trials (50 left and 50 right min), ignore that
            %%%%%% bin nad put all NaN in that column
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if (length(c1Trials) < threshold | length(c2Trials) < threshold)
                accuracy(:,idx) = NaN;
                totalShuffledAccuracy(:,:,idx) = NaN;
                totalBounds(:,:,idx) = NaN;
            else
                
                % randomly select 50% total data
                index1 = randperm(length(c1Trials));
                extract1 = sort(index1(1:num));
                index2 = randperm(length(c2Trials));
                extract2 = sort(index2(1:num));

                % extract trials feed into classifier
                extract = [c1Trials(extract1); c2Trials(extract2)];
                train_x = trials(extract, :, :);
                train_y = temp.choice(extract) - 1;

                % loop through time
                    for trainId = 1 : size(train_x,3)

                        t1 = squeeze(train_x(:,:,trainId));
                        md1 = fitclinear(t1, train_y, 'learner', 'logistic', 'KFold', 5);

                        error = kfoldLoss(md1);
                        accuracy(trainId, idx) = 1 - error;
                    end
                
                
                
                %             % create shuffled accuracy range: shuffle 500 times
                %             shuffled_accuracy = zeros(500, size(trials,3));
                %             for sIdx = 1 : 500
                %
                %                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %                 %%%%%%% this cannot be trials, it should shuffle only train_x
                %                 R = randperm(size(train_x,1));
                %
                %                 train_y_p = train_y(R);
                %
                %                 for ii = 1 : size(train_x,3)
                %
                %                     t1 = squeeze(train_x(:,:,ii));
                %                     md1 = fitclinear(t1, train_y_p, 'learner', 'logistic', 'KFold', 5);
                %
                %                     error = kfoldLoss(md1);
                %                     shuffled_accuracy(sIdx, ii) = 1 - error;
                %                 end
                %
                %             end
                %
                %
                %             % calculate bound accuracy
                %             bounds = zeros(2, size(trials,3));
                %             percentile = 1;
                %             for ib = 1 : size(trials,3)
                %                 test = shuffled_accuracy(:,ib);
                %                 bounds(1, ib) = prctile(test,percentile);
                %                 bounds(2, ib) = prctile(test, 100 - percentile);
                %             end
                %
                %
                %             totalShuffledAccuracy(:,:,idx) = shuffled_accuracy;
                %             totalBounds(:,:,idx) = bounds;
                %
                %
                %
            end
            
            
            
            
            
            
            
            
        end
        
        
        
        
        % store the results in a struct
        classifier(id).name = fullName;
        classifier(id).accuracy = accuracy;
        %     classifier(id).totalShuffledAccuracy = totalShuffledAccuracy;
        %     classifier(id).totalBounds = totalBounds;
        
        % update process bar
        disp(['Session ' num2str(id) ' finished.']);

        allAccuracy(id,condId,:,:) = accuracy;        
        if id > 2
            figure(2);
            subplot(7,1,condId);
            plot(squeeze(nanmean(allAccuracy(:,condId,:,:))));
            drawnow;
        end
    end
    
    allDecodes(condId).classifier = classifier;

end

toc


% save(['decoderbyRTBinsAllCoh.mat'], 'allDecodes');




%% plot the results

% load the data generated by code above
% allDecodes = load('decoderbyRTBinsAllCoh.mat').allDecodes;
cc = [
   0.6091    0.2826    0.7235;
    0.1412    0.7450    0.8863;
    0.8980    0.4155    0.1647
];

% cc = [
%    0.6091    0.2826    0.7235;
%     0.4279    0.3033    0.6875;
%     0.2588    0.3136    0.6353;
%     0.2510    0.4118    0.6980;
%     0.1765    0.6312    0.8588;
%     0.1412    0.7450    0.8863;
%     0.3686    0.7490    0.5491;
%     0.8941    0.7764    0.1530;
%     0.8980    0.6548    0.1686;
%     0.8863    0.5295    0.1608;
%     0.8980    0.4155    0.1647
% ];

% time 
t = linspace(-600,1200,90);


for ic = 7:7
easy = allDecodes(ic).classifier;

totalAccuracy = [];
for im = 1:length(easy)
    totalAccuracy(:,:,im) = easy(im).accuracy;
end


for ip = 1:3
    % extract decoding results of 1 RT bin
    oneAcc = squeeze(totalAccuracy(:,ip,:));

    % remove all nans 
    nonNanAcc = oneAcc(:,find(all(~isnan(oneAcc),1)));


    options.x_axis = t;
    options.alpha      = 0.5;
    options.line_width = 5;
    options.error      = 'sem';
    options.handle     = figure(ic);
    options.color_area = cc(ip,:);    
    options.color_line = cc(ip,:);

    % plot error bar; generate source excel data
    [data_mean(ip,:), upperBd(ip,:), lowerBd(ip,:)]= plot_areaerrorbar(nonNanAcc', options);

end



ylimit = 0.4;
yUp = 0.8;
xpatch = [-600 -600 ylimit ylimit];
ypatch = [ylimit yUp yUp ylimit];
p1 = patch(xpatch, ypatch, 'cyan');
p1.FaceAlpha = 0.1;
p1.EdgeAlpha = 0;

plot([0,0], [ylimit,yUp], 'color', [0 0 0], 'linestyle', '--', 'linewidth',3)
yline(0.5, 'k--', 'linewidth', 3);



hLimits = [-600,1200];
hTickLocations = -600:300:1200;
hLabOffset = 0.05;
hAxisOffset =  ylimit - 0.015;
hLabel = "Time (ms)"; 

vLimits = [ylimit,yUp];
vTickLocations = linspace(ylimit, yUp, 3); 
vLabOffset = 180;
vAxisOffset =  -650;
vLabel = "Accuracy (%)"; 

title(['Easiest coherence (90%) ' num2str(ic)], 'fontsize', 20)

plotAxis = [1 1];

[hp,vp] = getAxesP(hLimits,...
    hTickLocations,...
    hLabOffset,...
    hAxisOffset,...
    hLabel,...
    vLimits,...
    vTickLocations,...
    vLabOffset,...
    vAxisOffset,...
    vLabel, plotAxis);

set(gcf, 'Color', 'w');
axis off; 
axis square;
axis tight;

end


% ax = gca;
% ax.SortMethod = 'childorder';
% print('-painters','-depsc',['~/Desktop/', 'predictChoiceRTBinsCoh7','.eps'], '-r300');
% 
