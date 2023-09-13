
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

forRRR = permute(forRRR, [3 2 1]);

% forRRR = forRRR(nSquares == 117 | nSquares == 108,:,:);

% tAxis = forGPFA.dataStruct.RawData.timeAxis;

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
for tid = 100:100:1400
    fprintf('%d.',tid);
    [beta, mse(cnt), t, mse_t(cnt,:), rsquare(cnt,:)] = rrr([forRRR(:,:,10) choiceV' nSquares], [forRRR(:,:,tid) ],'rank',[ceil(0.7*size(forRRR,1)/10)*10 5]);
    D = forRRR(:,:,tid);
    D = D(:);
    ErrV(cnt) = nanmean([D - nanmean(D)].^2);
    
    hold on
    
    Temp = forRRR;
    Temp = Temp(randperm(size(forRRR,1)),:,:);
    for nS = 1:1
        [beta, mse_s(nS, cnt), t, mse_cnt(cnt,:), rsquare_s(cnt,:)] = rrr([Temp(:,:,10) choiceV' nSquares], [forRRR(:,:,tid)],'rank',[ceil(0.7*size(forRRR,1)/10)*10 5]);
    end
   cnt = cnt + 1;
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