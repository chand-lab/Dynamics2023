%%
% summarizeLDSsingle is identical to summarizeLDS except we do every other
% trial. Only for the stats do we hold out one trial and fit on all
% other trials.

%files = dir('/home/eyebeast/Code/DryadData/DryadDataSupp/LFADSdata/*.mat');
function singleSessionLDS(files)

sessionId = 40;
step = 100;
titles = {'Before Checkerboard Onset', 'After Checkerboard Onset'};
loc = [-590 10];

for timeperiods = 1:2

    fprintf('\n %s', titles{timeperiods});

    currFileName = fullfile(files(sessionId).folder, files(sessionId).name);
    load(currFileName);


    forRRR = cat(3, forGPFA.dataStruct.RawData.Left, forGPFA.dataStruct.RawData.Right);
    RTs = [forGPFA.dataStruct.Info.Left.goodRTs'; forGPFA.dataStruct.Info.Right.goodRTs'];
    C = forGPFA.dataStruct.Info.Left.nSquares;
    C = abs(C-(225-C))./225;

    forRRR = forGPFA.dataStruct.RawData.Left;
    RTs = forGPFA.dataStruct.Info.Left.goodRTs';

    tAxis = [-600:1199]./1000;

    

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

    dims = [2:2:10];
    stC = []; stO = [];
    for di = dims
        [R2(end+1), A1,origData, predData, RTv, trialIds] = summarizeLDSsingle(X1(whichTs,:,:),di,1,RTs, tV);
    end


    figure(40)

    subplot(2,1,timeperiods);
    cla;
    tOrig = tV(whichTs)*1000;
    tPred = tOrig(2:end);
    
    Xo = squeeze(origData(1:10:end,:,1));
    Yp = squeeze(predData(1:10:end,:,1));

    plot(tOrig, Xo','-','color',[0.4 .4 0.4 0.4]);
    hold on;
    plot(tPred, Yp','-','color',[1 .6 0.1 0.4],'linewidth',2)

    tLims = [tOrig(1) tPred(end)];
    set(gca,'visible','off');
    set(gcf,'renderer','painters');
    getAxesP(tLims, tLims(1):200:tLims(end),30,-110,'Time (ms)',[-100 250], -100:50:250,60,tLims(1),'X_1')

    axis square

    text(loc(timeperiods), 250, titles{timeperiods}); 

    dataV = [Xo Yp];
    tV = [tOrig tPred];
    dataV = [tV' cat(1, ones(size(Xo,2),1), 2*ones(size(Yp,2),1))  dataV'];
    
    vNames = {'Time', 'Cond'};
    for nT = 1:size(Xo,1)
        vNames{nT+2} = sprintf('Trial%d',nT);
    end
    
    ldsTable.(sprintf('data%d',timeperiods)) = array2table(dataV, 'VariableNames',vNames);
end

end
% %%
% baseDir = '/net/home/chand/code/Dynamics2023/'
% fileName = fullfile(baseDir, 'SourceData/FigS13.xls');
% writetable(ldsTable.data1,fileName,'FileType','spreadsheet','Sheet','fig.S13a-left');
% writetable(ldsTable.data2,fileName,'FileType','spreadsheet','Sheet','fig.S13a-right');