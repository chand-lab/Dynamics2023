% load data for Figure 6
load regressions.mat

% process data for Figure 6
D= PMDdecoding(regressions); 

% 6a
D.plotRTLFADS() 

% 6b
D.plotChoiceLFADS()

% 6c & e
D.plotR2() 

% 6d & f
D.plotAcc() 