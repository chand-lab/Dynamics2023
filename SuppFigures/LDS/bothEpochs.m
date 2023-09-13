
function bothEpochs(files)

%%
step = 100;

fileList = [1:length(files)];


sStats = [];

dualPeriod = [];

for timeperiods = 1:2
    R2actual = [];
    R2shuffle = [];
    
    Rall = [];
    Rorig = [];
    rv = [];
    
    stC = [];
    stO = [];
    stSimple = [];
    
    
    for n=fileList
        currFileName = fullfile(files(n).folder, files(n).name);
        
        load(currFileName);
        
        
        forRRR = cat(3, forGPFA.dataStruct.RawData.Left, forGPFA.dataStruct.RawData.Right);
        RTs = [forGPFA.dataStruct.Info.Left.goodRTs'; forGPFA.dataStruct.Info.Right.goodRTs'];
        C = forGPFA.dataStruct.Info.Left.nSquares;
        C = abs(C-(225-C))./225;
        
        forRRR = forGPFA.dataStruct.RawData.Left;
        RTs = forGPFA.dataStruct.Info.Left.goodRTs';
        
        tAxis = [-600:1199]./1000;
        
        
        
        if size(forRRR,2) > 10
            fprintf('\n %s', currFileName);
            
            X1 = forRRR(1:step:end,:,:);
            tV = tAxis(1:step:end);
            if timeperiods == 2
                whichTs = tV > -0.05;
                selectT = tV > 0.1 & tV < 0.4;
            else
                whichTs = tV <= 0;
                selectT = tV <= -0.1;
            end
            
            
            R2 = [];
            
            dims = [2:2:10]
            stC = []; stO = [];
            for di = dims
                [R2(end+1), A1,origData, predData, RTv, trialIds] = summarizeLDS(X1(whichTs,:,:),di,1,RTs, tV);
                [b,bi,c,ci,stC(end+1,:)] = regress(RTv', [squeeze(nanmean(predData(:,selectT,:),2)) C(trialIds)' ones(size(RTv,2),1)]);
                
            end
            X1t = permute(X1, [3 1 2]);
            [b,bi,c,ci,stO] = regress(RTv', [squeeze(nanmean(X1t(trialIds,selectT,:),2)) C(trialIds)' ones(size(RTv,2),1)]);
            [b,bi,c,ci,stSimple] = regress(RTv', [C(trialIds)' ones(size(RTv,2),1)]);
            
            
            % if n==40
            %     figure(40)
            % 
            %     subplot(2,1,timeperiods);
            %     cla;
            %     tOrig = tV(whichTs);
            %     tPred = tOrig(2:end);
            %     plot(tOrig, squeeze(origData(1:10:end,:,1))','-','color',[0.2 .8 0.4 0.4]);
            %     hold on;
            %     plot(tPred, squeeze(predData(1:10:end,:,1))','-','color',[0.8 0 0.8 0.4],'linewidth',2)
            % 
            % 
            %     %         [rv(end+1),pv] = corr(RTv', nanmean(predData(:,tV < 0,1),2),'type','spearman');
            %     tLims = [tOrig(1) tPred(end)];
            %     set(gca,'visible','off');
            %     set(gcf,'renderer','painters');
            %     getAxesP(tLims, tLims(1):.2:tLims(end), 'Time (s)', -110, 2, [-100 250], [-100:50:250],'X_1',tLims(1)-0.1, 0.1);
            %     axis tight;
            % 
            %     %         plot(tPred, rv.^2,'r-');
            %     %         drawnow;
            % end
            
            Xs = [];
            Xall = [];
            R1v = [];
            
            fprintf('\n %d.', n);
            X2 = [];
            for k=1:size(X1,3)
                X2(:,:,k) = X1(:,randperm(size(X1,2)),k);
            end
            trialRandom = randperm(size(X2,3));
            trialRandom = 1:size(X2,3);
            X2 = X2(:,:,trialRandom);
            
            for di = dims
                [R1v(end+1), A1, origData,predData,RT2] = summarizeLDS(X2(whichTs,:,:),di,1,RTs(trialRandom), tV);
            end
            
            [b,bi,c,ci,sts] = regress(RT2', [squeeze(nanmean(predData(:,selectT,:),2)) ones(size(RT2,2),1)]);
            
            
            
            R2actual(end+1,:) = R2*100;
            R2shuffle(end+1,:) = R1v*100;
            
            figure(2);
            subplot(221);
            cla
            plot(nanmean(R2actual),'ro-');
            hold on;
            plot(nanmean(R2shuffle),'ko-');
            
            
            Rall(end+1,:) = [stC(:,1)']
            Rorig(end+1,:) = [stO(1)' stSimple(1)']
            sStats(end+1,:) = size(forRRR);
            subplot(222);
            plot(nanmean(Rall));
            drawnow;
            
        end
    end
    dualPeriod(timeperiods).DynamicsToRT = Rall;
    dualPeriod(timeperiods).FullToRT = Rorig;
    dualPeriod(timeperiods).R2actual = R2actual;
    dualPeriod(timeperiods).R2shuffle = R2shuffle;
    
end
%%
figure;
types = {'pre','post'};
for n=1:2
    R2actual = dualPeriod(n).R2actual;
    R2shuffle = dualPeriod(n).R2shuffle;
    
    
    subplot(2,2, n);
    errorbar(dims, nanmean(R2actual), nanstd(R2actual)./sqrt(size(Rall,1)),'mo-','markersize',8, 'markeredgecolor','none','markerfacecolor','m')
    hold on
    errorbar(dims, nanmean(R2shuffle), nanstd(R2shuffle)./sqrt(size(Rall,1)),'ko-','markersize',8,  'markeredgecolor','none','markerfacecolor','k')
    ax = gca; ax.Visible = 'off';
    ax.XLim = [2 10];
    hold on;
    getAxesP([2 10], 2:2:10,3,18,'Dimensionality',[20 50],20+[0:10:30],1,1,'Cross-validated R^2 (%)')
    axis square;
    axis tight;
    
    subplot(2,2,n+2);
    Rall = dualPeriod(n).DynamicsToRT;
    Rorig = dualPeriod(n).FullToRT;
    
    hold on;
    errorbar(dims, nanmean(100*Rall), nanstd(100*Rall)./sqrt(size(Rall,1)),'mo-','markeredgecolor','none','markerfacecolor','m')
    ax = gca; ax.Visible = 'off';
    ax.XLim = [2 10];
    
    line(ax.XLim, nanmean(Rorig(:,1)*100)*ones(1,2), 'color','k','linestyle','--');
    line(ax.XLim, nanmean(Rorig(:,2)*100)*ones(1,2), 'color','k','linestyle','--');
    
    hold on;
    % getAxesP([2 10],[2:2:10],'Dimensions',-1,1,[0 40],[0:10:40],'Variance (%)',1,1,[1 1]);
    getAxesP([2 10], 2:2:10,3,-2,'Dimensionality',[0 40],[0:10:40],1,1,'RT R^2 (%)',[1 1])

    axis square;
    axis tight;
    
    
    dataV = [nanmean(R2actual)' nanstd(R2actual)'./sqrt(size(Rall,1)) nanmean(R2shuffle)' nanstd(R2shuffle)'./sqrt(size(R2shuffle,1))];
    dataV = [dataV nanmean(100*Rall)' nanstd(100*Rall)'./sqrt(size(Rall,1)) ];
    dataV(:,end+1) = nanmean(Rorig(:,1));
    dataV(:,end+1) = nanmean(Rorig(:,2));
    varNames = {'R2','R2e','R2s','R2se','R2RT','R2RTe','R2full','R2coh'};
    ldsTable.(types{n}) = array2table(dataV,'VariableNames',varNames);
    
    
end
%%

% tV = tAxis(1:step:end);
% whichTv = tV > -0.05;
% tOrig = tV(whichTv);
% tPred = tOrig(2:end);
% 
% [R1, A1, origDataX1, predDataX1, RTv] = summarizeLDS(X1(whichTv,:,:),[4],1,RTs, tV);
% R1
% 
% %%
% figure;
% subplot(221);
% plot(tOrig, squeeze(origDataX1(2:10:end,:,1))','g-')
% hold on;
% plot(tPred, squeeze(predDataX1(2:10:end,:,1))','m-')
% 
% subplot(222);
% 
% 
% Xref = corr(RTv', nanmean(origDataX1(:,:,1),2),'type','spearman')
% plot(corr(RTv', origDataX1(:,:,1)),'r-');
% Xorig = corr(RTv', origDataX1(:,:,1))';
% hold on;
% plot(Xall','k-');

end

% %%
% cprintf('yellow','\nFigure S13');
% baseDir = '/net/home/chand/code/Dynamics2023/'
% fileName = fullfile(baseDir, 'SourceData/FigS13.xls');
% writetable(ldsTable.pre,fileName,'FileType','spreadsheet','Sheet','fig.S13b');
% writetable(ldsTable.post,fileName,'FileType','spreadsheet','Sheet','fig.S13c');
