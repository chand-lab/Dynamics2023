
forRRR = [];
for k=1:length(seqTrain)
    forRRR(k,:,:) = seqTrain(k).y;
    if mod(k,100) == 0
        fprintf('.');
    end
end

%%

forRRR = cat(3, forGPFA.dataStruct.binned.Left, forGPFA.dataStruct.binned.Right);
forRRR = cat(3, forGPFA.dataStruct.RawData.Left, forGPFA.dataStruct.RawData.Right);
choiceV = [ones(1, forGPFA.nL) 2*ones(1,forGPFA.nR)];
nSquares = [forGPFA.dataStruct.Info.Left.nSquares'; forGPFA.dataStruct.Info.Right.nSquares'];
nSquares = abs([nSquares-(225-nSquares)]./225);
RTs = [forGPFA.dataStruct.Info.Left.goodRTs'; forGPFA.dataStruct.Info.Right.goodRTs'];
forRRR = permute(forRRR, [3 2 1]);

% forRRR = forRRR(nSquares == 117 | nSquares == 108,:,:);

tAxis = forGPFA.dataStruct.RawData.timeAxis;

forRRR = forRRR - repmat(nanmean(forRRR),[size(forRRR,1) 1 1]);
%%
mse = [];
mse_s = [];
mse_cnt = [];
mse_t = [];
ErrV = [];
cnt = 1;
rsquare = [];
rsquare_s = [];

betaA = [];

whichTimePoint =  400;
timeValues = setdiff([100:50:1400],whichTimePoint);

for tid = timeValues
    fprintf('%d.',tid);
    [betaA(cnt,:,:), mse(cnt), t, mse_t(cnt,:), rsquare(cnt,:), yPred] = rrr([forRRR(:,:,whichTimePoint)  choiceV' nSquares], [forRRR(:,:,tid) ],'rank',[ceil(0.75*size(forRRR,1)/10)*10 5]);
    
    
        
    D = forRRR(:,:,tid);
    D = D(:);
    ErrV(cnt) = nanmean([D - nanmean(D)].^2);
    
    hold on
    
    Temp = forRRR;
    Temp = Temp(randperm(size(forRRR,1)),:,:);
    cV = choiceV(randperm(size(forRRR,1)));
    
    for nS = 1:1
        [beta, mse_s(nS, cnt), t, mse_cnt(cnt,:), rsquare_s(cnt,:)] = rrr([Temp(:,:,whichTimePoint) choiceV' nSquares], [forRRR(:,:,tid)],'rank',[ceil(0.75*size(forRRR,1)/10)*10 5]);
    end
   cnt = cnt + 1;
end

%%
plot(tAxis(timeValues), max(rsquare,[],2));
hold on;
plot(tAxis(timeValues), max(rsquare_s,[],2));
hold on;
reflinecc(0);
drawRestrictedLines(0,[-0.05 0.3]);


rawData = [ones(size(forRRR,1),1) forRRR(:,:,whichTimePoint) choiceV' nSquares];
% projData = rawData*betaV';

[beta1,~,~,~,st1] = rrr([rawData(:,2:end-1) rawData(:,end)], RTs, 'rank',[ceil(0.8*size(forRRR,1)/10)*10 5])
[~,~,~,~,st2] = rrr(rawData(:,end), RTs, 'rank',[ceil(0.7*size(forRRR,1)/10)*10 5])
% [~,~,~,~, st2] = regress(RTs, [rawData(:,end) ones(size(RTs,1),1)]);

reflinecc([0 st1(1)-st2(1)]);

%%
t1 = betaA(:,:,2:end-2);
t2 = beta1(:,2:end-2);

rValues = [];
rValuesS = [];
for tV=1:size(t1,1)
   rValues(tV,:) = corr(squeeze(t1(tV,:,:))', t2','type','spearman'); 
   for nS = 1:100
        rValuesS(tV,nS,:) = corr(squeeze(t1(tV,:,randperm(size(t1,3))))', t2','type','spearman'); 
   end
end

%%
forRR = [];
forRR_tOut = [];
for k = 1:length(N.signalplusnoise.TrajIn)
    forRR(k,:,:) = double(N.signalplusnoise.TrajIn{k}(1:650,1:6)');
    forRR_tOut(k,:,:) = double(N.signalplusnoise.TrajOut{k}(1:650,1:6)');
end


mse = [];
mse_s = [];
ErrV = []
cnt = 1;
for tV=50:10:size(forRR,3)
    [beta, mse(cnt), t] = rrr(squeeze(forRR(:,:,48)), squeeze(forRR(:,:,tV)));
    D = forRR(:,:,tV);
    D = D(:);
    ErrV(cnt) = nanmean([D - nanmean(D)].^2);
    
    [beta, mse_s(cnt), t] = rrr(squeeze(forRR(:,:,48)), squeeze(forRR_tOut(:,:,tV)));
     cnt = cnt + 1;
 end
%%

% forRRR2 = double(squeeze(M.rt.FR(1:11,1,:,:)));
% forRRR2(isnan(forRRR2)) = nanmean(forRRR2(:));
% 
% 
% mse = [];
% cnt = 1;
% for tV=301:800
%     [beta, mse(cnt), t] = rrr(squeeze(forRRR2(:,1:20:end,100)), squeeze(forRRR2(randperm(11),1:20:end,tV)),'rank',4);
%     cnt = cnt + 1;
% end