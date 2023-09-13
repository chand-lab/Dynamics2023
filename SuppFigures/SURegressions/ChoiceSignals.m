function ChoiceSignals(allFastHardCoh, allSlowHardCoh,justHardRTsigmap,allRTsigmap)
figure;
subplot(223);
tV = [-600:1200];
idx = 1:10:length(tV);

SE1 = nanstd(bootstrp(1000,@nanmean,allFastHardCoh(:,idx,1)))*100;
Mu1 = squeeze(nanmean(allFastHardCoh(:,idx,1)))*100;
[pa,li] = ShadedError(tV(idx), Mu1,2*SE1);
set(li,'color','b');
set(pa,'facecolor',[0 0 1],'FaceAlpha',0.5);
hold on

Mu2 = squeeze(nanmean(allSlowHardCoh(:,idx,1)))*100;
SE2 = nanstd(bootstrp(1000,@nanmean,allSlowHardCoh(:,idx,1)))*100;
[pa, li] = ShadedError(tV(idx), Mu2 ,2*SE2);
drawRestrictedLines(0,[0 50]);
set(li,'color','r');
set(pa,'facecolor',[1 0 0],'FaceAlpha',0.5);
hold on

Mu3 = squeeze(nanmean(justHardRTsigmap(:,idx,1)))*100;
SE3 = nanstd(bootstrp(1000,@nanmean,justHardRTsigmap(:,idx,1)))*100;
[pa, li] = ShadedError(tV(idx), Mu3,2*SE3);
set(li,'color','y');
set(pa,'facecolor',[1 1 0],'FaceAlpha',0.5);
hold on;


set(gca,'visible','off');
getAxesP([-600 1200],[-600 -300 300:300:1200],0.1*50,-1,'Time (ms)',[0 50],[0:10:50],0.1*1800,-625,'Significant (%)',[1 1]);
axis tight;
axis square;
xlim([-600 1200]);
refline([0 1]);

text([-600],50,'Hard Coherences, 2 RT bins');

choiceTable = array2table([tV(idx)' Mu1' Mu2' Mu3' SE1' SE2' SE3' ],'VariableNames',{'Time','AllFastChoice','AllSlowChoice','HardRT','FastE','SlowE','HardRTe'});

%%
subplot(2,2,4);
Mu4 = squeeze(nanmean(allRTsigmap(:,idx,1)))*100;
SE4 = nanstd(bootstrp(1000,@nanmean,allRTsigmap(:,idx,1)))*100;
[pa, li] = ShadedError(tV(idx), Mu4,2*SE4);
set(li,'color','g');
set(pa,'facecolor',[0 1 0],'FaceAlpha',0.5);
hold on;

Mu5 = squeeze(nanmean(allRTsigmap(:,idx,2)))*100;
SE5 = nanstd(bootstrp(1000,@nanmean,allRTsigmap(:,idx,2)))*100;
[pa,li] = ShadedError(tV(idx), Mu5,2*SE5);
set(li,'color',[.87 .63 .87]);
set(pa,'facecolor',[.87 .63 .87],'FaceAlpha',0.5);
hold on;
drawRestrictedLines(0,[0 100]);


set(gca,'visible','off');
getAxesP([-600 1200],[-600 -300 300:300:1200],0.1*100,-1,'Time (ms)',[0 100],[0:20:100],0.1*1800,-625,'Significant (%)',[1 1]);
axis tight;
axis square;
xlim([-600 1200]);
refline([0 1]);

text(-600,100,'All Coherences, RT and Choice');

allCoh = array2table([tV(idx)' Mu4' Mu5'  SE4' SE5'],'VariableNames',{'Time','RT','Choice','RTe','ChoiceE'});
end
%%
%cprintf('yellow','\nFigure S17');
%fileName = '../../SourceData/FigS17.xls'
%writetable(choiceTable,fileName,'FileType','spreadsheet','Sheet','Fig.S17c');
%writetable(allCoh,fileName,'FileType','spreadsheet','Sheet','Fig.S17d');