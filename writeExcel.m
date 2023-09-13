%% Write data to excel files


%%
fileName = 'SourceData/Fig2.xls'
cprintf('yellow','\n Figure 2');
writetable(forExcelT.tablePsych,fileName,'FileType','spreadsheet','Sheet','fig.2d-top');
writetable(forExcelO.tablePsych,fileName,'FileType','spreadsheet','Sheet','fig.2d-bottom');
writetable(forExcelT.tableChrono,fileName,'FileType','spreadsheet','Sheet','fig.2e-top');
writetable(forExcelO.tableChrono,fileName,'FileType','spreadsheet','Sheet','fig.2e-bottom');
writetable(TT, 'SourceData/fig.2f-top.csv');
writetable(TO, 'SourceData/fig.2f-bottom.csv');


%% Figure 4

fileName = 'SourceData/Fig4.xls'
cprintf('yellow','\n Figure 4');
writetable(dataTable.components,fileName,'FileType','spreadsheet','Sheet','Fig.4a');
writetable(dataTable.trajectories,fileName,'FileType','spreadsheet','Sheet','Fig.4b');
writetable(dataTable.kinet.distance,fileName,'FileType','spreadsheet','Sheet','Fig.4c');
writetable(dataTable.kinet.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.4d');
writetable(dataTable.kinet.align,fileName,'FileType','spreadsheet','Sheet','Fig.4e');
writetable(dataTable.kinet.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.4f');
writetable(dataTable.kinet.speed,fileName,'FileType','spreadsheet','Sheet','Fig.4g');
writetable(dataTable.distance,fileName,'FileType','spreadsheet','Sheet','Fig.4h');


%% Figure S7
cprintf('yellow','\nFigure S7');
fileName = 'SourceData/FigS7.xls'
writetable(dataTable.trajectories,fileName,'FileType','spreadsheet','Sheet','Fig.S7');


%% Figure 5

fileName = 'SourceData/Fig5.xls'
cprintf('yellow','\n Figure 5');
writetable(dataTable.noTraj, fileName,'FileType','spreadsheet','Sheet','Fig.5a');
writetable(dataTable.noKinet.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.5b');
writetable(dataTable.noKinet.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.5c');
writetable(dataTable.noKinet.distance,fileName,'FileType','spreadsheet','Sheet','Fig.5d');
writetable(dataTable.noKinet.align,fileName,'FileType','spreadsheet','Sheet','Fig.5e');


%% Figure 6
cprintf('yellow','\n Figure 6');
fileName = 'SourceData/Fig6.xls'
f = fieldnames(F.dataTable);
f = f([6 3 4 1 5 2]);
for nF=1:length(f)
    writetable(F.dataTable.(f{nF}),...
        fileName,'FileType',...
        'spreadsheet','Sheet',f{nF});
end


%% Figure 7
fileName = 'SourceData/Fig7.xls'
cprintf('yellow','\n Figure 7');
writetable(dataTable.trajectories1,fileName,'FileType','spreadsheet','Sheet','Fig.7c-1');
writetable(dataTable.trajectories2,fileName,'FileType','spreadsheet','Sheet','Fig.7c-2');
writetable(dataTable.trajectories3,fileName,'FileType','spreadsheet','Sheet','Fig.7c-3');

writetable(inputsAndIC.distances, fileName,'FileType','spreadsheet','Sheet','Fig.7d');
writetable(inputsAndIC.avgSel, fileName,'FileType','spreadsheet','Sheet','Fig.7e');
writetable(inputsAndIC.avgLatency, fileName,'FileType','spreadsheet','Sheet','Fig.7f');
writetable(inputsAndIC.avgSlope, fileName,'FileType','spreadsheet','Sheet','Fig.7g');



writetable(nonOverlapping.distances, fileName,'FileType','spreadsheet','Sheet','Fig.7h');
writetable(nonOverlapping.avgSel, fileName,'FileType','spreadsheet','Sheet','Fig.7i');
writetable(nonOverlapping.avgLatency, fileName,'FileType','spreadsheet','Sheet','Fig.7j');
writetable(nonOverlapping.avgSlope, fileName,'FileType','spreadsheet','Sheet','Fig.7k');



%% Figure S5

cprintf('yellow','\nFigure S5');
fileName = '../SourceData/FigS5.xls'
writetable(dataTable.varExplained,fileName,'FileType','spreadsheet','Sheet','Fig.S5a');
writetable(dataTable.var15ms,fileName,'FileType','spreadsheet','Sheet','Fig.S5b');
writetable(dataTable.var50ms,fileName,'FileType','spreadsheet','Sheet','Fig.S5c');

%% Figure S6
fileName = 'SourceData/FigS6.xls'
cprintf('yellow','\nFigure S6');
writetable(dataTable.trialCounts.nonOverlappping, fileName,'FileType','spreadsheet','Sheet','Fig.S6a');
writetable(dataTable.trialCounts.Overlappping, fileName,'FileType','spreadsheet','Sheet','Fig.S6b');


%% Figure S10
cprintf('yellow','\nFigure S10');
fileName = 'SourceData/FigS10.xls'
writetable(dataTable.SUtrajectories, fileName,'FileType','spreadsheet','Sheet','Fig.S10a');
writetable(dataTable.SUKinet.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.S10b');
writetable(dataTable.SUKinet.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.S10c');
writetable(dataTable.SUKinet.distance,fileName,'FileType','spreadsheet','Sheet','Fig.S10d');
writetable(dataTable.SUKinet.align,fileName,'FileType','spreadsheet','Sheet','Fig.S10e');


%% Fig. S11 for the three smoothing kernels
cprintf('yellow','\nFigure S11');
fileName = '../SourceData/FigS11.xls'
writetable(dataTable.trajectories,fileName,'FileType','spreadsheet','Sheet','Fig.S11a-left');
writetable(dataTable.kinet.distance,fileName,'FileType','spreadsheet','Sheet','Fig.S11b-left');
writetable(dataTable.kinet.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.S11c-left');
writetable(dataTable.kinet.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.S11d-left');
writetable(dataTable.kinet.align,fileName,'FileType','spreadsheet','Sheet','Fig.S11e-left');

cprintf('yellow','\nFigure S11');
fileName = '../SourceData/FigS11.xls'
writetable(dataTable.traj15ms,fileName,'FileType','spreadsheet','Sheet','Fig.S11a-middle');
writetable(dataTable.Kinet15ms.distance,fileName,'FileType','spreadsheet','Sheet','Fig.S11b-middle');
writetable(dataTable.Kinet15ms.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.S11c-middle');
writetable(dataTable.Kinet15ms.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.S11d-middle');
writetable(dataTable.Kinet15ms.align,fileName,'FileType','spreadsheet','Sheet','Fig.S11e-middle');


cprintf('yellow','\nFigure S11');
fileName = '../SourceData/FigS11.xls'
writetable(dataTable.traj50ms,fileName,'FileType','spreadsheet','Sheet','Fig.S11a-right');
writetable(dataTable.Kinet50ms.distance,fileName,'FileType','spreadsheet','Sheet','Fig.S11b-right');
writetable(dataTable.Kinet50ms.velocity,fileName,'FileType','spreadsheet','Sheet','Fig.S11c-right');
writetable(dataTable.Kinet50ms.subspace,fileName,'FileType','spreadsheet','Sheet','Fig.S11d-right');
writetable(dataTable.Kinet50ms.align,fileName,'FileType','spreadsheet','Sheet','Fig.S11e-right');


