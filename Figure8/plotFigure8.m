% load data for Figure 8, S9, S18, S19, S20, S22
load Figure8data.mat

% process data for Figure 8, S18, S20b
[r] = POA(outcome); 

% 8a
r.plotComponents(); 

% 8b
r.plotTrajectories();

% 8c & e
r.plotKinet();

% 8d
r.plotDecoder();

%% plot Supplementary Figure 9

dataS9= outcome.pcaCohRT;
[pcDataS9]=calculatePCs_S9(dataS9);

% S9a
plotComponents_S9(pcDataS9)

% S9b
plotTrajectories_S9(pcDataS9)

%% plot Supplementary Figure 18

% S18a
[accPer] = errorRate(outcome.bx.Y_logic);
   
% S18b
[CCEC_RT]=findBxErrs(outcome.bx.Y_logic,outcome.bx.RT,outcome.bx.ST_Logic,'CCEC');
plotCCEC(CCEC_RT)

% S18c
r.plotVariance

% S18d
load regressions.mat
load 14October2013_T.mat
plotLFADS_previousResult(regressions,Trials);

% S18e
[CI, meanDist]=plotComponents(r,'moveAlign',1);

%% plot Supplementary Figure 19

[r] = POA(outcome,trials ='CCE_ECC');

% S19a
r.plotComponents

% S19a (inset)
r.plotVariance

% S19b
r.plotTrajectories

% S19c
[CCECC_RT]=findBxErrs(outcome.bx.Y_logic,outcome.bx.RT,outcome.bx.ST_Logic,'CCE_ECC');
plotCCEC(CCECC_RT)

% S19d, e, inset
r.plotKinet


%% plot Supplementary Figure 20

% S20b
[r] = POA(outcome); 

plotComponents(r,'TrajIn', r.project.TrajIn, 'TrajOut', r.project.TrajOut);

% S20c
load Figure4_5_7data.mat
[r2]=PMddynamics(M);

plotComponents(r2,'TrajIn', r2.project.TrajInProjRT, 'TrajOut', r2.project.TrajOutProjRT);


%% plot Supplementary Figure 22

[r] = POA(outcome, 'useSingleNeurons', 'true'); 

% S22a & b
plotBiplot(r)




