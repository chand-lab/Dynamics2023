
scnt = 1;
AllRsquare = [];
AllRsquare_s = [];
SIds = [];
subCCmean = logical(0);

monkeys = {'o','t'};

for m = 1:2
    
    
    monkey = monkeys{m};
    
    switch(monkey)
        
        case 'o'
            %    olafV = [13 24:26 30 33 36 38 40 41 43 44 45 46 47 48 49 50 52 53 54 55 56 61 62 63 70];
            
            olafV = [13 24:26 30 33 36 38 41 43 45 46 47 49 52 53 54 55 56 61 70];
            
            whichSess = olafV;
            [Sessions, remoteDir, remoteScratch] = validOlafSessions('PMd');
        case 't'
            
            whichSess = setdiff(52:75, [57 65]);
            [Sessions, remoteDir, remoteScratch] = validSessions('PMd');
    end
    
    
    for sId = whichSess
        fprintf('\n %d',sId);
        
        [forGPFA,nL, nR] = getGPFAdata(sId, 'monkey',monkey,'reMake',0);
        
        forRRR = cat(3, forGPFA.dataStruct.binned.Left, forGPFA.dataStruct.binned.Right);
        forRRR = cat(3, forGPFA.dataStruct.RawData.Left, forGPFA.dataStruct.RawData.Right);
        choiceV = [ones(1, forGPFA.nL) 2*ones(1,forGPFA.nR)];
        nSquares = [forGPFA.dataStruct.Info.Left.nSquares'; forGPFA.dataStruct.Info.Right.nSquares'];
        nSquares = abs([nSquares-(225-nSquares)]./225);
        RTs = [forGPFA.dataStruct.Info.Left.goodRTs'; forGPFA.dataStruct.Info.Right.goodRTs'];
        forRRR = permute(forRRR, [3 2 1]);
        tAxis = forGPFA.dataStruct.RawData.timeAxis;
        if subCCmean
            forRRR = forRRR - repmat(nanmean(forRRR),[size(forRRR,1) 1 1]);
        end
        
        
        try
            mse = [];
            mse_s = [];
            mse_cnt = [];
            mse_t = [];
            ErrV = [];
            cnt = 1;
            rsquare = [];
            rsquare_s = [];
            
            betaA = [];
            
            whichTimePoint = 100;
            timeValues = setdiff([200:100:1600],[whichTimePoint]);
            
            for tid = timeValues
                fprintf('%d.',tid);
                [betaA(cnt,:,:), mse(cnt), t, mse_t(cnt,:), rsquare(cnt,:), yPred] = rrr([forRRR(:,:,whichTimePoint) ], [forRRR(:,:,tid) ],'rank',[ceil(0.75*size(forRRR,1)/10)*10 5]);
                
                
                
                D = forRRR(:,:,tid);
                D = D(:);
                ErrV(cnt) = nanmean([D - nanmean(D)].^2);
                
                hold on
                
                Temp = forRRR;
                %                 Temp = Temp(randperm(size(forRRR,1)),randperm(size(forRRR,2)),randperm(size(forRRR,3)));
                Temp = Temp(randperm(size(forRRR,1)),:,:);
                %             Temp = Temp(:,randperm(size(forRRR,2)),:);
                %             Temp = repmat(nanmean(Temp),[size(forRRR,1) 1 1]);
                cV = choiceV(randperm(size(forRRR,1)));
                
                
                for nS = 1:1
                    [beta, mse_s(nS, cnt), t, mse_cnt(cnt,:), rsquare_s(cnt,:)] = rrr([Temp(:,:,whichTimePoint) ], [forRRR(:,:,tid)],'rank',[ceil(0.75*size(forRRR,1)/10)*10 5]);
                end
                cnt = cnt + 1;
            end
            
            %             figure(1);
            %             plot(tAxis(timeValues), max(rsquare,[],2));
            %             hold on;
            %             plot(tAxis(timeValues), max(rsquare_s,[],2));
            %             hold on;
            %             reflinecc(0);
            %             drawRestrictedLines(0,[-0.05 0.3]);
            %             drawnow;
            
            AllRsquare(scnt,:) = max(rsquare,[],2);
            AllRsquare_s(scnt,:) = max(rsquare_s,[],2);
            SIds(scnt,:) = [sId size(forRRR,2) size(forRRR,1)];
            
            scnt = scnt + 1;
        catch
            sId
        end
        
        %     AllRsquare(abs(AllRsquare) > 2) = NaN;
        %     AllRsquare(AllRsquare < -0.2) = NaN;
        %     AllRsquare_s(abs(AllRsquare_s) > 2) = NaN;
        
        
        figure(2);
        cla;
        plot(nanmean(AllRsquare));
        hold on
        plot(nanmean(AllRsquare_s));
        %         ylim([-.05 0.05]);
        drawnow;
        
    end
end

%%
% AllRsquare(abs(AllRsquare) > 2) = NaN;
% AllRsquare(AllRsquare < 0) = NaN;
% AllRsquare_s(abs(AllRsquare_s) > 2) = NaN;
ix = find(~(sum(AllRsquare < 0 | AllRsquare > 1,2)));
Sv = squeeze(nanmean(AllRsquare(ix,:)));
Sve = squeeze(nanstd(AllRsquare(ix,:)))./sqrt(size(AllRsquare,1));
% Sve = nanstd(bootstrp(1000,@nanmean,AllRsquare(ix,:)));



ShadedError(tAxis(timeValues), squeeze(Sv),Sve);
% plot(tAxis(timeValues), prctile(AllRsquare,[5 95]));
hold on
ix = find(~(sum(AllRsquare_s < 0 | AllRsquare_s > 1,2)));
plot(tAxis(timeValues), squeeze(nanmean(AllRsquare_s(ix,:))),'ko-')

drawLines(0);
drawLines(tAxis(whichTimePoint));