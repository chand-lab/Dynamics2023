classdef PMDdecoding < handle
    %
    %
    %
    %
    %
    properties
        
        lfads
        reg
        dec
        
        dataTable
        
    end
    
    methods
        function D = PMDdecoding(regressions)
            
            D.lfads=InitLFADS(D,regressions);
            D.reg=InitReg(D,regressions);
            D.dec=InitDec(D,regressions);
            
        end
        
        function lfads=InitLFADS(D,regressions)
            
            %LFADS variables
            factors = regressions.lfadsR.factors;
            test = reshape(factors, [size(factors,1), size(factors,2)*size(factors,3)])';
            
            [~, score, ~] = pca(test);
            
            orthF = [];
            for thi = 1 : size(factors, 3)
                orthF(:,:,thi) = (score( (1:180) + (thi-1)*180, :))';
            end
            
            trials_data = regressions.raw.dat;
            temp = struct2table(trials_data);
            
            % RT LFADS
            
            % choose the 30% fast and slow reaction
            percentile = 30;
            
            % choose condition num
            cond = 1;
            selectedRT = temp.RT(temp.condId == cond, :);
            sortedRT = sort(unique(selectedRT));
            
            % 20% RT
            fastPoint = sortedRT(round(length(sortedRT)*percentile/100));
            
            % 80% RT
            slowPoint = sortedRT(round(length(sortedRT)*(100 - percentile)/100));
            
            % trials that belong to fast 20% (label 1) and slow 20% (label 2)
            label1 = (temp.condId == cond) & (temp.RT <= fastPoint);
            label2 = (temp.condId == cond) & (temp.RT >= slowPoint);
            
            % store each trial reaction time
            lfads.label1RT = temp.RT(label1);
            lfads.label2RT = temp.RT(label2);
            
            % extract slow and fast trajectories
            lfads.fast_traj = orthF(1:3,:,label1);
            lfads.slow_traj = orthF(1:3,:,label2);
            
            % Choice LFADS
            
            % define percentage of all trials plotted
            portion = 0.5;
            
            % define the conditions plotted
            condition = [1,8];
            
            for id = 1 : length(condition)
                cond = condition(id);
                
                % extract the RT and trajs with target condition
                trajs = orthF(1:3,:,temp.condId == cond);
                trajRT = temp.RT(temp.condId == cond, :);
                
                % randomly select 50% data
                idx = randperm(size(trajRT,1));
                extract = sort(idx(1:round(length(idx)*portion)));
                
                % update trajs and corresponding RT
                trajs = trajs(:,:,extract);
                trajRT = trajRT(extract);
                
                % store the data into a struct
                lfads.Traj(id).cond = cond;
                lfads.Traj(id).trajs = trajs;
                lfads.Traj(id).trajRT = trajRT;
                
            end
        end
        
        
        function reg=InitReg(D,regressions)
            linreg=regressions.linreg;
            
            % define session number
            s = 40;
            
            % choice 1
            bounds1 = linreg(s).shuffledBoundC1R2;
            r21 = linreg(s).c1R2;
            
            % choice 2
            bounds2 = linreg(s).shuffledBoundC2R2;
            r22 = linreg(s).c2R2;
            
            % combine choices
            reg.SessBounds = (bounds1 + bounds2)./2;
            reg.SessR2 = (r21 + r22)./2;
            
            
            reg.AvgR2 = [];
            for ip2 = 1 : length(linreg)
                reg.AvgR2(:,ip2) = (linreg(ip2).c1R2 + linreg(ip2).c2R2)./2 ;
            end
            
        end
        
        
        function dec=InitDec(D,regressions)
            classifier=regressions.classifier;
            
            % define session number
            s = 40;
            dec.SessBounds = classifier(s).shuffled_bound_accuracy;
            dec.SessAcc = classifier(s).accuracy;
            
            dec.AvgAcc = [];
            for ip2 = 1 : length(classifier)
                dec.AvgAcc(:,ip2) = classifier(ip2).accuracy;
            end
            
        end
        
        
        
        function plotRTLFADS(D)
            
            label1RT=D.lfads.label1RT;
            label2RT=D.lfads.label2RT;
            
            fast_traj= D.lfads.fast_traj;
            slow_traj= D.lfads.slow_traj;
            binWidth = 10;
            
            
            figure;
            bigData = [];
            for ii = 1 : size(fast_traj,3)
                
                % endPoint
                lastPt = 60 + round(label1RT(ii)/binWidth);
                
                % plot trajectories from -200 of stimulus onset
                plot3(fast_traj(1,40:lastPt,ii), fast_traj(2,40:lastPt,ii),fast_traj(3,40:lastPt,ii), 'color', [0,0,1]);
                hold on
                
                % stimulus onset
                plot3(fast_traj(1,60,ii), fast_traj(2,60,ii),fast_traj(3,60,ii), 'bo', 'markerfacecolor', 'b', 'markersize', 8);
                
                % end dot
                plot3(fast_traj(1,lastPt,ii), fast_traj(2,lastPt,ii),fast_traj(3,lastPt,ii), 'd', 'markeredgecolor', 'none', 'markerfacecolor', 'b', 'markersize', 10);
                
                currData = squeeze(D.lfads.fast_traj(:,40:lastPt,ii));
                currData(4,:) = ii;
                currData(5,:) = 1;
                bigData = [bigData; currData'];
            end
            
            
            
            
            nFast = size(fast_traj,3);
            
            
            for ii = 1 : size(slow_traj,3)
                
                % endPoint
                lastPt = 60 + round(label2RT(ii)/binWidth);
                
                % plot trajectories from -200 of stimulus onset
                plot3(slow_traj(1,40:lastPt,ii), slow_traj(2,40:lastPt,ii), slow_traj(3,40:lastPt,ii), 'color', [1,0,0]);
                hold on
                
                % stimulus onset
                plot3(slow_traj(1,60,ii), slow_traj(2,60,ii),slow_traj(3,60,ii), 'ro', 'markerfacecolor', 'r', 'markersize', 8);
                
                % end dot
                plot3(slow_traj(1,lastPt,ii), slow_traj(2,lastPt,ii),slow_traj(3,lastPt,ii),'d', 'markeredgecolor', 'none', 'markerfacecolor', 'r', 'markersize', 10);
                
                currData = squeeze(D.lfads.slow_traj(:,40:lastPt,ii));
                currData(4,:) = ii + nFast;
                currData(5,:) = 2;
                bigData = [bigData; currData'];
            end
            
            
            Y1 = repmat({'Fast'},sum(bigData(:,5)==1),1);
            Y2 = repmat({'Slow'},sum(bigData(:,5)==2),1);
            Y = [Y1; Y2];
            D.dataTable.Fig6a = table(bigData(:,1), bigData(:,2), bigData(:,3),...
                bigData(:,4), Y, 'VariableNames',{'X','Y','Z','TrialId','Type'});
            
            set(gcf, 'Color', 'w');
            axis off;
            axis square;
            axis tight;
            
            set(gca, 'LooseInset', [ 0 0 0 0 ]);
            xlabel('X_1');
            ylabel('X_2');
            zlabel('X_3');
            axis vis3d;
            
            view([-18,16])
            try
                tv = ThreeVector(gca);
                tv.axisInset = [0.2 0.2]; % in cm [left bottom]
                tv.vectorLength = 2; % in cm
                tv.textVectorNormalizedPosition = 1.8;
                tv.fontSize = 15; % font size used for axis labels
                tv.fontColor = 'k'; % font color used for axis labels
                tv.lineWidth = 2; % line width used for axis vectors
                tv.lineColor = 'k'; % line color used for axis vectors
                tv.update();
                rotate3d on;
            catch
            end
            
            ax = gca;
            ax.SortMethod = 'childorder';
        end
        
        function plotChoiceLFADS(D)
            
            binWidth = 10;
            
            % plot cond 1
            trajs = D.lfads.Traj(1).trajs;
            trajRT = D.lfads.Traj(1).trajRT;
            
            figure;
            
            bigData = [];
            
            for ii = 1 : size(trajs,3)
                
                % endPoint
                lastPt = 60 + round(trajRT(ii)/binWidth);
                
                % plot trajectories from -200 of stimulus onset
                plot3(trajs(1,40:lastPt,ii), trajs(2,40:lastPt,ii),trajs(3,40:lastPt,ii), 'color', [0.5,0,1]);
                hold on
                
                % stimulus onset
                plot3(trajs(1,60,ii), trajs(2,60,ii),trajs(3,60,ii), 'o', 'markeredgecolor', 'none', 'markerfacecolor', [0.5,0,1], 'markersize', 8);
                
                % plot end dot
                plot3(trajs(1,lastPt,ii), trajs(2,lastPt,ii),trajs(3,lastPt,ii), 'd', 'markeredgecolor', 'none', 'markerfacecolor', [0.5,0,1], 'markersize', 10);
                
                currData = squeeze(trajs(:,40:lastPt,ii));
                currData(4,:) = ii;
                currData(5,:) = 1;
                bigData = [bigData; currData'];
            end
            
            nL1 =  size(trajs,3);
            % plot cond 8
            trajs = D.lfads.Traj(2).trajs;
            trajRT = D.lfads.Traj(2).trajRT;
            
            for ii = 1 : size(trajs,3)
                % endPoint
                lastPt = 60 + round(trajRT(ii)/binWidth);
                
                % plot trajectories from -200 of stimulus onset
                plot3(trajs(1,40:lastPt,ii), trajs(2,40:lastPt,ii),trajs(3,40:lastPt,ii), 'color', [0,0.7,0.2]);
                hold on
                
                % stimulus onset
                plot3(trajs(1,60,ii), trajs(2,60,ii),trajs(3,60,ii), 'o', 'markeredgecolor', 'none', 'markerfacecolor', [0,0.7,0.2], 'markersize', 8);
                
                % plot end dot
                plot3(trajs(1,lastPt,ii), trajs(2,lastPt,ii),trajs(3,lastPt,ii), 'd', 'markeredgecolor', 'none', 'markerfacecolor', [0,0.7,0.2], 'markersize', 10);
                
                currData = squeeze(trajs(:,40:lastPt,ii));
                currData(4,:) = ii + nL1;
                currData(5,:) = 2;
                bigData = [bigData; currData'];
            end
            
            Y1 = repmat({'Left'},sum(bigData(:,5)==1),1);
            Y2 = repmat({'Right'},sum(bigData(:,5)==2),1);
            Y = [Y1; Y2];
            D.dataTable.Fig6b = table(bigData(:,1), bigData(:,2), bigData(:,3),...
                bigData(:,4), Y, 'VariableNames',{'X','Y','Z','TrialId','Type'});
            
            
            % title('Choice LFADS Trajectories', 'fontsize', 30);
            set(gcf, 'Color', 'w');
            axis off;
            axis square;
            axis tight;
            
            set(gca, 'LooseInset', [ 0 0 0 0 ]);
            xlabel('X_1');
            ylabel('X_2');
            zlabel('X_3');
            axis vis3d;
            view([131, 37])
            
            try
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
            catch
            end
            
            ax = gca;
            ax.SortMethod = 'childorder';
        end
        
        function exportData(D)
           
            f = fieldnames(D.dataTable);
            for nF=1:length(f)
                writetable(D.dataTable.(f{nF}),...
                    '../SourceData/SourceData.xls','FileType',...
                    'spreadsheet','Sheet',f{nF});
            end
            
            
        end
        
        
        function plotR2(D)
            
            %Session R2 plot
            figure;
            subplot(1,2,1); hold on
            
            %time
            t = linspace(-580,1200,90);
            
            ylimit = ceil(max(D.reg.SessR2)*100)+5;
            xpatch = [-300 -300 0 0];
            ypatch = [0 1 1 0].*ylimit;
            p1 = patch(xpatch, ypatch, 'cyan');
            p1.FaceAlpha = 0.2;
            p1.EdgeAlpha = 0;
            
            plot(t, D.reg.SessBounds(1,:)'*100, '--', 'linewidth', 2,'Color',[0 255 109]./255);
            plot(t, D.reg.SessBounds(2,:)'*100, '--', 'linewidth', 2,'Color',[231 0 212]./255);
            plot(t, D.reg.SessR2*100, 'linewidth', 2, 'color', [236 112  22]./255)
            plot([-600,1200], [12,12], 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            
            
            plot([0,0], [0,1].*ylimit, 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            
            D.dataTable.Fig6c = table(t', D.reg.SessBounds(1,:)'*100,...
                D.reg.SessBounds(2,:)'*100, D.reg.SessR2*100,'VariableNames',...
                {'Time','Lower','Upper','AvgR2'});
            
            
            
            % cosmetic code
            hLimits = [-600,1200];
            hTickLocations = -600:300:1200;
            hLabOffset = 5;
            hAxisOffset =  -0.014;
            hLabel = "Time (ms)";
            
            vLimits = [0,ylimit];
            vTickLocations = [0 ylimit/2 ylimit];
            vLabOffset = 180;
            vAxisOffset =  -650;
            vLabel = "R^{2} (%)";
            title('LFADS session')
            
            plotAxis = [10 10];
            
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
            text(1220,12,sprintf('%3.0f%%',12),'Color',[0 0 0]);
            text(1220,5,'99 perc. shuff.','Color',[231 0 212]./255);
            text(1220,1,'1 perc. shuff.','Color',[0 255 109]./255);
            
            % Avg R2 plot
            subplot(1,2,2); hold on
            
            ylimit = 40;
            xpatch = [-300 -300 0 0];
            ypatch = [0 1 1 0].*ylimit;
            p1 = patch(xpatch, ypatch, 'cyan');
            p1.FaceAlpha = 0.2;
            p1.EdgeAlpha = 0;
            
            
            lineColor = [236 112  22]./255;
            areaColor=[243 169 114]./255;
            AvgR2 =D.reg.AvgR2'*100;
            semAvgR2=std(AvgR2)/sqrt(size(AvgR2,1));
            ShadedError6(t,mean(AvgR2),semAvgR2,lineColor,areaColor);
            
            D.dataTable.Fig6e = table(t', mean(AvgR2)', semAvgR2',...
                'VariableNames',{'Time', 'AvgR2','SEM'});
            
            
            plot([0,0], [0,1].*ylimit, 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            
            % line for variance explained by coherence
            plot([-600,1200], [6.32,6.32], 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            
            plot([0,0], [0,1].*ylimit, 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            
            % cosmetic code
            hLimits = [-600,1200];
            hTickLocations = -600:300:1200;
            hLabOffset = 2.5;
            hAxisOffset =  -0.011;
            hLabel = "Time (ms)";
            
            vLimits = [0,ylimit];
            vTickLocations = [0 ylimit/2 ylimit];
            vLabOffset = 180;
            vAxisOffset =  -650;
            vLabel = "R^{2} (%)";
            title('Average across sessions')
            
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
            text(1220,6.32,sprintf('%3.2f%%',6.32),'Color',[0 0 0]);
            
            
            
        end
        
       
        
        function plotAcc(D)
            
            %Session Acc plot
            figure;
            subplot(1,2,1); hold on
            t = linspace(-580,1200,90);
            ylimit = 40;
            xpatch = [-300 -300 0 0];
            ypatch = [ylimit 100 100 ylimit];
            p1 = patch(xpatch, ypatch, 'cyan');
            p1.FaceAlpha = 0.2;
            p1.EdgeAlpha = 0;
            
            plot(t, D.dec.SessBounds(1,:)'*100, '--', 'linewidth', 2,'Color',[0 255 109]./255);
            plot(t, D.dec.SessBounds(2,:)'*100, '--', 'linewidth', 2,'Color',[231 0 212]./255);
            plot(t, D.dec.SessAcc*100, 'linewidth', 2, 'color', [236 112  22]./255)
            plot([0,0], [ylimit,100], 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            yline(50, 'k--', 'linewidth', 2);
            
            D.dataTable.Fig6d = table(t', D.dec.SessBounds(1,:)'*100, ...
                D.dec.SessBounds(2,:)'*100,...
                D.dec.SessAcc*100, 'VariableNames',...
                {'Time', 'SessBounds_1','SesBounds_2','Acc'});
            
            
            % cosmetic code
            hLimits = [-600,1200];
            hTickLocations = -600:300:1200;
            hLabOffset = 5;
            hAxisOffset =  ylimit;
            hLabel = "Time (ms)";
            
            vLimits = [ylimit,100];
            vTickLocations = [ylimit ylimit+30 100];
            vLabOffset = 180;
            vAxisOffset =  -650;
            vLabel = "Accuracy (%)";
            
            plotAxis = [10 10];
            
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
            text(1220,50,sprintf('%3.0f%%',50),'Color',[0 0 0]);
            text(1220,53.5,'99 perc. shuff.','Color',[231 0 212]./255);
            text(1220,46.5,'1 perc. shuff.','Color',[0 255 109]./255);
            title('Single session accuracy')
            
            % Avg Acc plot
            
            subplot(1,2,2); hold on
            
            yLower = 40;
            yUpper = 80;
            xpatch = [-300 -300 0 0];
            ypatch = [yLower yUpper yUpper yLower];
            p1 = patch(xpatch, ypatch, 'cyan');
            p1.FaceAlpha = 0.2;
            p1.EdgeAlpha = 0;
            
            
            
            lineColor = [236 112  22]./255;
            areaColor=[243 169 114]./255;
            AvgAcc =D.dec.AvgAcc'*100;
            semAvgAcc=std(AvgAcc)/sqrt(size(AvgAcc,1));
            ShadedError6(t,mean(AvgAcc),semAvgAcc,lineColor,areaColor);
            
            D.dataTable.Fig6f = table(t', mean(AvgAcc)', semAvgAcc',...
                'VariableNames',{'Time','Average','SEM'});
            
            
            plot([0,0], [yLower,yUpper], 'color', [0 0 0], 'linestyle', '--', 'linewidth',2)
            yline(50, 'k--', 'linewidth', 2);
            
            % cosmetic code
            hLimits = [-600,1200];
            hTickLocations = -600:300:1200;
            hLabOffset = 3;
            hAxisOffset =  yLower - 1;
            hLabel = "Time (ms)";
            
            vLimits = [yLower,yUpper];
            vTickLocations = [yLower (ylimit + yUpper)/2 yUpper];
            vLabOffset = 180;
            vAxisOffset =  -650;
            vLabel = "Accuracy (%)";
            
            plotAxis = [10 10];
            
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
            text(1220,50,sprintf('%3.0f%%',50),'Color',[0 0 0]);
            title('Across session accuracy')
        end
        
        
    end
end