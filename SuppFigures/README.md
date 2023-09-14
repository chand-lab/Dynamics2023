# Readme for Generating Supplementary Figures

## Figure List

* [Figure S3 - Simulations of Hypothetical Neurons](#figure-s3)
* [Figure S4 - Heterogeneous Single Neurons](#figure-s4)
* [Figure S5 - Percent Variance Explained](#figure-s5)
* [Figure S6 - Trial Counts](#figure-s6)
* [Figure S7 - Axes equalized PCA](#figure-s7)
* [Figure S8 - KiNeT](#figure-s8)
* [Figure S9 - RT and Coherence together](#figure-s9)
* [Figure S10 - Single Unit PCA](#figure-s10)
* [Figure S11 - KiNeT and PCA for different smoothing kernels](#figure-s11)
* [Figure S12 - Tensor Component Analysis](#figure-s12)
* [Figure S13 - Fits of a Linear Dynamical System](#figure-s13)
* [Figure S14 - LFADS analysis of sessions](#figure-s14)
* [Figure S15 - Reduced Rank Regression](#figure-s15)
* [Figure S16 - Shuffled vs. Real accuracy, and Decoder by RT bin](#figure-s16)
* [Figure S17 - Decoder by RT bin for easy and hard coherences,  and Regression analyses](#figure-s17)
* [Figure S18 - Streaks and Post Error Slowing](#figure-s18)
* [Figure S19 - CCE, and ECC analysis](#figure-s19)
* [Figure S20 - Subspace projection analyses](#figure-s20)
* [Figure S21 - Single trial and trial-averaged variance explained](#figure-s21)
* [Figure S22 - PC1 vs PC4 loadings](#figure-s21)


## Figure S3

Open 'plotFigureS3.m'.

Running the following code will initialize the data to recreate all of the plots in Figure S3:

```
kernel = 0.02;
[ucFR, ucFRc, ucRT, tNew, nNeuronsOut]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
[bcFR, bcFRc, bcRT, tNew, nNeuronsOut]=simulatePMdneurons('BiasedChoice',kernel,nNeurons,nTrials);
[rtFR, rtFRc, rtRT, tNew, nNeuronsOut]=simulatePMdneurons('RT',kernel,nNeurons,nTrials);
```

3A

```
plotPCA(ucFRc, ucRT, tNew, nNeuronsOut);
plotRegressionToRT(ucFR, ucRT, nTrials);
plotChoiceDecoding(ucFR, ucRT, nTrials);
```

3B

```
plotPCA(bcFRc, bcRT, tNew, nNeuronsOut);
plotRegressionToRT(bcFR, bcRT, nTrials);
plotChoiceDecoding(bcFR, bcRT, nTrials);
```
3C

```
plotPCA(rtFRc, rtRT, tNew, nNeuronsOut);
plotRegressionToRT(rtFR, rtRT, nTrials);
plotChoiceDecoding(rtFR, rtRT, nTrials);
```

[Back to Figure List](#figure-list)

## Figure S4

Open 'plotFigure3.m'. If you want to display the 1st unit with 30 ms (S4 A) or 15 ms Gaussian (S4 B) or 50 ms boxcar (S4 C) smoothing presented in Figure S4 run the following commands:

S4A

```
Fig3Neurons(1);
```


S4B
```
Fig3Neurons(1, smoothing='gauss15');
```

S4C
```
Fig3Neurons(1, smoothing='box50');
```

The number corresponds to the order of presentation in the figure and you can plot all 8 units in this manner

[Back to Figure List](#figure-list)

## Figure S5
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S5:

```
N30 = PMddynamics(M);

load 15msGaussFRs.mat
N15 = PMddynamics(M);

load 50msBoxcarFRs.mat
N50 = PMddynamics(M);
```


S5A
```
dataTable.varExplained = N30.plotVariance('n',10);
```

S5B
```
dataTable.var15ms = N15.plotVariance('n',10);
```

S5C

```
dataTable.var50ms = N50.plotVariance('n',10);
```

[Back to Figure List](#figure-list)

## Figure S6
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S6:

```
N30 = PMddynamics(M);
```

S6A & B

```
dataTable.trialCounts = N30.plotTrialCounts;
```

[Back to Figure List](#figure-list)

## Figure S7
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S7:

```
N30 = PMddynamics(M);
```

S7

```
N30.plotTrajectories('showPooled',1,'showGrid',1,'hideAxes',0);
axis equal
```

[Back to Figure List](#figure-list)

## Figure S9
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S9:

```
dataS9= outcome.pcaCohRT;
[pcDataS9]=calculatePCs_S9(dataS9);
```

S9A
```
plotComponents_S9(pcDataS9)
```

S9B
```
plotTrajectories_S9(pcDataS9)
```
[Back to Figure List](#figure-list)

## Figure S10
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S10:

```
NSU = PMddynamics(M,'useSingleNeurons',1);
```

S10A
```
dataTable.SUtrajectories = NSU.plotTrajectories;
```

S10B-E
```
dataTable.SUKinet = NSU.plotKinet;
```
[Back to Figure List](#figure-list)

## Figure S11
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S11:
```
N30 = PMddynamics(M);

load 15msGaussFRs.mat
N15 = PMddynamics(M);

load 50msBoxcarFRs.mat
N50 = PMddynamics(M);
```

S11A

```
dataTable.trajectories = N30.plotTrajectories('showPooled',1,'showGrid',0,'hideAxes',1);
dataTable.traj15ms = N15.plotTrajectories;
dataTable.traj50ms = N50.plotTrajectories;
```


S11B-E
```
dataTable.kinet = N30.plotKinet;
dataTable.kinet15ms = N15.plotKinet;
dataTable.kinet50ms = N50.plotKinet;
```


[Back to Figure List](#figure-list)


## Figure S12
Open 'plotFigureS12.m'.  

Run:

```
whichCV='hard';
[modelToUse,choiceV,RTs,trainError,testError,st,st1,tAxis,whichT]=populationTCA(whichCV);

whichCV='soft';
[~,~,~,trainError_soft,testError_soft,st_soft,st1_soft]=populationTCA(whichCV);
```

S12B

```
plotTCAmodel(modelToUse,tAxis,whichT)
```

S12C
```
plotTCAsessionDynamics(modelToUse,choiceV,RTs,tAxis,whichT)
```

S12D & E

```
plotTCAvar(testError_soft,trainError_soft,st_soft,st1_soft)
plotTCAvar(testError,trainError,st,st1)
```

[Back to Figure List](#figure-list)

## Figure S13
Open 'plotFigureS13.m'. Change directory to folder containing LFADS '.mat' files inside of DryadData (... /DryadData/DryadDataSupp/LFADSdata). 

Run:
```
files=dir('*.mat');
```

S13A
```
singleSessionLDS(files);
```

S13B-C
```
bothEpochs(files);
```

[Back to Figure List](#figure-list)

## Figure S14
Open 'plotFigureS14.m'. Change directory to folder containing LFADS '.mat' files inside of DryadData (... /DryadData/DryadDataSupp/FigureS14). 

Run:

```
lfadsR = load('Tsess1.mat');
folder=dir('*.mat');
```

S14A
```
plotLFADSFR(lfadsR);
```

S14B
```
lfadsSingleTrialVarianceExplained(folder);
```

S14C
```
lfadsFR_RT_regression(folder); 
```
[Back to Figure List](#figure-list)

## Figure S15
Open 'plotFigureS15.m'. 

Run:
```
[AllRsquare, AllRsquare_s,alignAngles,tAxis,timeValues,whichTimePoint,AllAngles] =redRank2023();
```

S15B
```
plotRedRank(AllRsquare, AllRsquare_s,alignAngles,tAxis,timeValues,whichTimePoint,AllAngles)
```

[Back to Figure List](#figure-list)

## Figure S16
Open 'plotFigureS16.m'. 

Load the following data for S16:
```
load regressions.mat
load 'decoderbyRTBins.mat'
```

S16A, B
```
plotRegScatters(regressions)
```

S16C
```
plotAccByBin(classifier);
```

[Back to Figure List](#figure-list)

## Figure S17
Open 'plotFigureS17.m'. 

Load the following data for S17:

```
load('ChoicePerRTbin_hardCoh.mat');
load('RTandChoice_hardCoh.mat')
load('RTandChoice_allCoh.mat');
load('decoderbyRTBinsAllCoh.mat')
```

S17A
```
plotDecodeByBin(allDecodes,1)
```

S17B
```
plotDecodeByBin(allDecodes,7)
```

S17C, D

```
ChoiceSignals(allFastHardCoh, allSlowHardCoh,justHardRTsigmap,allRTsigmap)
```

[Back to Figure List](#figure-list)

## Figure S18
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S18:
```
[r] = POA(outcome);
```

S18A
```
[accPer] = errorRate(outcome.bx.Y_logic);
```

S18B

```
 [CCEC_RT]=findBxErrs(outcome.bx.Y_logic,outcme.bx.RT,outcome.bx.ST_logic,'CCEC');
 plotCCEC(CCECC_RT)

```

S18C

```
r.plotVariance
```


S18D

```
load regressions.mat
load 14October2013_T.mat
plotLFADS_previousResult(regressions,Trials);
```

S18E

```
[CI, meanDist]=plotComponents(r,'moveAlign',1);
```

[Back to Figure List](#figure-list)

## Figure S19
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S19:

```
[r] = POA(outcome,trials ='CCE_ECC');
```

S19A
```
r.plotComponents
```

S19a (inset)

```
r.plotVariance
```

S19B

```
r.plotTrajectories
```

S19C
```
[CCEC_RT]=findBxErrs(outcome.bx.Y_logic,outcme.bx.RT,outcome.bx.ST_logic,'CCEC');
plotCCEC(CCECC_RT)
```

S19D, E, & inset
```
r.plotKinet
```

[Back to Figure List](#figure-list)

## Figure S20
Open 'plotFigure8.m'. Load Figure8data.mat and Figure4_5_7.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S20:

```
[r] = POA(outcome);
[r2]=PMddynamics(M);
```

S20B
```
plotComponents(r,'TrajIn', r.project.TrajIn, 'TrajOut', r.project.TrajOut);
```

S20C

```
plotComponents(r2,'TrajIn', r2.project.TrajInProjRT, 'TrajOut', r2.project.TrajOutProjRT);
```

[Back to Figure List](#figure-list)

## Figure S21
Open 'plotFigureS3.m'.

Running the following code will initialize the data to recreate all of the plots in Figure S21:

```
nNeurons = 200;
nTrials = 300;

kernel = 0.03;
[~, FRc_30, RT_30, tNew]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
V_30 = plotPCA(FRc_30, RT_30, tNew, nNeurons);

kernel = 0.02;
[~, FRc_20, RT_20, tNew, nNeurons]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
V_20 = plotPCA(FRc_20, RT_20, tNew, nNeurons);
```

S21A
```
plotSingleTrialPCA(FRc_30, tNew, nNeurons,V_30);
```
S21B
```
plotSingleTrialPCA(FRc_20, tNew, nNeurons,V_20);
```

[Back to Figure List](#figure-list)

## Figure S22
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S22:

```
[r] = POA(outcome, 'useSingleNeurons', 'true'); 
```

S22A & B

```
plotBiplot(r);
```

[Back to Figure List](#figure-list)

















