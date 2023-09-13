%%
function [modelToUse,choiceV,RTs,trainError,testError,st,st1,tAxis,whichT]=populationTCA(whichCV)
monkeys = {'o','t'};
r = [];
cnt = 1;
st = [];
st1 = [];
trainError = [];
testError = [];

whichT = 1:50:1200;
verbose = false;


<<<<<<< HEAD
whichCV = 'soft';
=======
%whichCV = 'hard';
>>>>>>> 3d4da735f0714f55186aab74612980aba1b43e0b

if whichCV == 'hard'
    cprintf('magenta','Using Hard Cross Validation');
else
    cprintf('yellow','Using soft Cross Validation');
end

rng(20);
for m = 2


    monkey = monkeys{m};

    switch(monkey)

        case 'o'
            olafV = [13 24:26 30 33 36 38 41 43 45 46 47 49 52 53 54 55 56 61 70];
            whichSess = olafV;
            [Sessions, remoteDir, remoteScratch] = validOlafSessions('PMd');
        case 't'

            whichSess = setdiff(52:75, 57);

            [Sessions, remoteDir, remoteScratch] = validSessions('PMd');
            whichSess = 52;
    end


    for sId = whichSess
        fprintf('\n %d',sId);

        [forTCA,nL, nR] = getTCAdata(sId, 'monkey',monkey,'reMake',0);
        forRRR = cat(3, forTCA.dataStruct.RawData.Left, forTCA.dataStruct.RawData.Right);
        RTs = [forTCA.dataStruct.Info.Left.goodRTs'; forTCA.dataStruct.Info.Right.goodRTs'];
        nSquares = [forTCA.dataStruct.Info.Left.nSquares'; forTCA.dataStruct.Info.Right.nSquares'];
        nSquares = abs([nSquares-(225-nSquares)]./225);
        choiceV = [ones(1, forTCA.nL) 2*ones(1,forTCA.nR)];
        tAxis = forTCA.dataStruct.RawData.timeAxis;

        tValues = tAxis < 0;
        Y = forRRR(whichT,:,:);
        Y = permute(Y,[2 1 3]);

        Yt = tensor(Y);
        Yr = ones(size(Yt));

        switch(whichCV)
            case 'hard'
                for n=1:size(Yr,3)
                    whichNeuron = [randi(size(Yr,1),1,1)];
                    if rand < .25
                        Yr(whichNeuron,:,n) = 0;
                    end
                end
            case 'soft'
                Yr = rand(size(Yt));
                Yr(Yr > 0.25) = 1;
                Yr(Yr <=0.25) = 0;
        end


        rTemp = [];
        dId = 1;
        localTrainError = [];
        localTestError = [];
        for d = [1:4]

            [model, U0,out] = cp_wopt(Yt, Yr, d,'verbosity',0);

            if sId == 52 & monkey == 't' & d == 4
                %  [model, U0, out] = cp_als(Yt, 4);
                modelToUse = model;
                %                 viz_ktensor(model, ...
                %                     'Plottype', {'bar', 'line', 'scatter'}, ...
                %                     'Modetitles', {'neurons', 'time', 'trials'})
            end

            fullData = full(model);
            fullData = fullData.data(find(Yr));
            Ydata = Yt.data(find(Yr));

            localTrainError(dId) = 1 - norm(fullData - Ydata,'fro').^2/norm(Ydata - mean(Ydata),'fro').^2;
            RCs(cnt,dId, 1) = norm(fullData - Ydata, 'fro')./norm(Ydata,'fro');

            fullData = full(model);
            fullData = fullData.data(find(~Yr));
            Ydata = Yt.data(find(~Yr));

            localTestError(dId) = 1 - norm(fullData - Ydata,'fro').^2/norm(Ydata - mean(Ydata),'fro').^2;
            RCs(cnt,dId, 2) = norm(fullData - Ydata, 'fro')./norm(Ydata,'fro');


            Yproj = [];
            X1 = model.u;
            ix = [1:d];
            for dX = 1:d
                Yproj(dX,:,:) = X1{3}(:,ix(dX)).*X1{2}(:,ix(dX))';
            end
            tAll = tAxis(whichT);
            [rTemp,p] = corr(model.u{3}, RTs, 'type','spearman');
            [~,~,~,~,st(cnt,dId,:)] = regress(RTs, [nanmean(Yproj(:,:,tAll < 0),3)' nSquares ones(size(RTs,1),1)]);
            [~,~,~,~,stR(cnt,dId,:)] = regress(RTs(randperm(length(RTs))), [nanmean(Yproj(:,:,tAll < 0),3)' nSquares ones(size(RTs,1),1)]);
            [b,bi,c,ci,st1(cnt,dId,:)] = regress(RTs, [nSquares ones(size(RTs,1),1)]);


            sessStats(cnt,:) = [sId size(Yt)];
            dId = dId + 1;


        end
        trainError(cnt,:) = localTrainError;
        testError(cnt,:) = localTestError;

        if verbose
            cprintf('red',sprintf('\n Train Error: %3.3f, \n test Error: %3.3f, \n R2: %3.3f', trainError(cnt,:), testError(cnt,:), st(cnt,:)));
        end
        cnt = cnt + 1;


    end
end


%%
tAll = tAxis(whichT);
classifydata = nanmean(Yproj(:,:,tAll < 0),3)';
groups = choiceV';


for i=1:10
    allData = randperm(length(groups));
    trainIdx = allData(1:ceil(0.7*length(allData)));
    testIdx = setdiff(allData, trainIdx);

    classPred = classify(classifydata(testIdx,:), classifydata(trainIdx,:), groups(trainIdx,:));
    actual(i) = nanmean(classPred == groups(testIdx));
end
nanmean(actual(i))

groups = choiceV(randperm(length(groups)))';
for nS=1:100
    groups = choiceV(randperm(length(groups)))';
    classPred = classify(classifydata(testIdx,:), classifydata(trainIdx,:), groups(trainIdx,:));
    acc(nS) = nanmean(classPred == groups(testIdx));
end

%%
oldTestError = testError;


%%
M1 = nanmean(trainError);
M1e = nanstd(trainError)./sqrt(size(trainError,1));
M2 = nanmean(testError);
M2e = nanstd(testError)./sqrt(size(testError,1));

TCAtable.TCA = array2table([(1:4)' M1' M1e' M2' M2e'],'VariableNames',{'Rank', 'TrainError','TrainE','TestError','TestE'});

M1 = nanmean(st(:,:,1)*100);
M1e = nanstd(st(:,:,1)*100)./sqrt(sum(~isnan(testError)))
TCAtable.TCAregress =  array2table([(1:4)' M1' M1e'],'VariableNames',{'Rank','R2','R2e'});

%%

sId = 52;
[forTCA,nL, nR] = getTCAdata(sId, 'monkey',monkey,'reMake',0);
forRRR = cat(3, forTCA.dataStruct.RawData.Left, forTCA.dataStruct.RawData.Right);
RTs = [forTCA.dataStruct.Info.Left.goodRTs'; forTCA.dataStruct.Info.Right.goodRTs'];
nSquares = [forTCA.dataStruct.Info.Left.nSquares'; forTCA.dataStruct.Info.Right.nSquares'];
nSquares = abs([nSquares-(225-nSquares)]./225);
choiceV = [ones(1, forTCA.nL) 2*ones(1,forTCA.nR)];
tAxis = forTCA.dataStruct.RawData.timeAxis;
end



% %%
% 
% 
% 
% if whichCV == 'hard'
%     cprintf('magenta','Using Hard Cross Validation');
% 
%         cprintf('yellow','Using soft Cross Validation');
%     fileName = '/net/home/chand/code/Dynamics2023/SourceData/FigS12.xls'
%     cprintf('yellow','\nFigure S12');
% 
% 
%     writetable(TCAtable.TCA, fileName,'FileType','spreadsheet','Sheet','Fig.S12d-bottom');
%     writetable(TCAtable.TCAregress, fileName,'FileType','spreadsheet','Sheet','Fig.S12e-bottom');
% else
%     cprintf('yellow','Using soft Cross Validation');
%     fileName = '/net/home/chand/code/Dynamics2023/SourceData/FigS12.xls'
%     cprintf('yellow','\nFigure S12');
% 
% 
%     writetable(TCAtable.Neurons, fileName,'FileType','spreadsheet','Sheet','Fig.S12b-left');
%     writetable(TCAtable.Time, fileName,'FileType','spreadsheet','Sheet','Fig.S12b-middle');
%     writetable(TCAtable.Trials, fileName,'FileType','spreadsheet','Sheet','Fig.S12b-right');
% 
%     writetable(TCAtable.Trajectories, fileName,'FileType','spreadsheet','Sheet','Fig.S12c');
% 
% 
%     writetable(TCAtable.TCA, fileName,'FileType','spreadsheet','Sheet','Fig.S12d-top');
%     writetable(TCAtable.TCAregress, fileName,'FileType','spreadsheet','Sheet','Fig.S12e-top');
% 
% 
% end