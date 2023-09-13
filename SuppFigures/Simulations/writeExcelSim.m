%%
fileName = '../../SourceData/FigS3.xls'
cprintf('yellow','\n Fig S3');
writetable(simData.PCA,fileName,'FileType','spreadsheet','Sheet','fig.S3c-left');
writetable(simData.R2,fileName,'FileType','spreadsheet','Sheet','fig.S3c-middle');
writetable(simData.choice,fileName,'FileType','spreadsheet','Sheet','fig.S3c-right');



%%
fileName = '../../SourceData/FigS3.xls'
cprintf('yellow','\n Fig S3');
writetable(simData.PCA,fileName,'FileType','spreadsheet','Sheet','fig.S3b-left');
writetable(simData.R2,fileName,'FileType','spreadsheet','Sheet','fig.S3b-middle');
writetable(simData.choice,fileName,'FileType','spreadsheet','Sheet','fig.S3b-right');

%%

fileName = '../../SourceData/FigS3.xls'
cprintf('yellow','\n Fig S3');
writetable(simData.PCA,fileName,'FileType','spreadsheet','Sheet','fig.S3a-left');
writetable(simData.R2,fileName,'FileType','spreadsheet','Sheet','fig.S3a-middle');
writetable(simData.choice,fileName,'FileType','spreadsheet','Sheet','fig.S3a-right');


%%


fileName = '../../SourceData/FigS21.xls'
cprintf('yellow','\n Fig S21');
writetable(simTable.variance,fileName,'FileType','spreadsheet','Sheet','fig.S21a');


%%

fileName = '../../SourceData/FigS21.xls'
cprintf('yellow','\n Fig S21');
writetable(simTable.variance,fileName,'FileType','spreadsheet','Sheet','fig.S21b');
