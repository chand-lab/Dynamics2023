# Dataset for recreating figures from Boucher et al., 2023
---
Experimental data used to construct the figures found in:

> P. O. Boucher, T. Wang, L. Carceroni, G. Kane, K. V. Shenoy, C. Chandramouli.
> *** Initial conditions combine with sensory evidence to induce decision-related dynamics in premotor cortex ***


Experimental data ([doi:10.5061/dryad.9cnp5hqn0](doi:10.5061/dryad.9cnp5hqn0)) and scripts ([https://github.com/chand-lab/Dynamics2023](https://github.com/chand-lab/Dynamics2023)) are organized based on the order of figures in the manuscript (tested in Matlab R2021b).

Download Github repository:        `git clone https://github.com/chand-lab/Dynamics2023.git`

For the repository to work on your computer please add the Dynamics2023 folder with all subfolders to your MATLAB path (add utils separately).

Toolboxes needed: 
- Curve Fitting Toolbox
- Statistics and Machine Learning Toolbox
- Bioinformatics Toolbox

Size of data files (>1 MB):
- HetNeurons.mat - 188.6 MB
- Figure4_5_7.mat - 14.7GB
- regressions.mat - 30 MB
- Figure8data.mat - 16 GB
- LFADSdata (folder) - 3.2 GB
- FigureS14 (folder) - 705 MB
- TCAdata (folder) - 10.7 GB
- 14October2013_Tiberius.mat - 1.2 GB

## Description of the data and file structure

To make replotting the figures as easy as possible a script entitled 'plotAllFigures.m' can be used as a guide to open scripts to plot specific figures (e.g., 'plotFigure2.m'). All figures, except schematic figures (Figures 1, & 2a-c,g; Supplementary Figures 1, 8, 12a, 15a, & 20a) and Supplementary Figure 2, can be plotted in this manner. Data for replotting Supplmentary Figure 2 is available upon request (Dr. Chandramouli Chandrasekaran: cchandr1@bu.edu).

### Figure 2: Psychometric curves for the monkey, and RT and box plots

Open 'plotFigure2.m'. Run this script to load behavioral data for both monkeys. Script then displays psychometric curves (percent responded red as a function of signed coherence), reaction time (RT) curves as a function of signed coherence, and boxplots of RTs organized by stimulus coherence for both monkeys.

### Figure 3: Heterogeneous and time-varying activity of PMd neurons 
 
Open 'plotFigure3.m'. If you want to display the first unit presented in Figure 3 run the following command:

```
 Fig3Neurons(1)
```

The number corresponds to the order of presentation in the figure. You can plot all 6 units in this manner (e.g., Fig3Neurons(2) will plot the second and so on). Plotted units are shown organized by coherence and RT, as well as aligned to cue and movement onset. Scaling may be slightly different between the figures in the paper and what is plotted from MATLAB.

## Figure 4: Initial conditions predict subsequent dynamics and RT

Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. This should give you a structure M with fields coherence and RT that are themselves structs with various fields including firing rates smoothed with appropriate filter and trial averaged.

Running the following code will initialize the data to recreate all of the plots in Figure 4:

```
N30 = PMddynamics(M); 
N30.calcWinCoh(M);
```

The following commands will plot all parts of Figure 4: 

4A & H
```
N30.plotComponents;
```

4B
```
N30.plotTrajectories('showPooled',1,'showGrid',0,'hideAxes',1); 
```

4C-G

```
N30.plotKinet
```

- A sister plot to the average raw speed plot is included (bottom right). This plot shows change in firing rate (Euclidean distance between adjacent time points) averaged across trials and within RT bins.  Esentially, firing rates associated with faster RT bins move through state space faster than firing rates in slower RT bins.

## Figure 5: Replicates main findings in Figure 4 using non-overlapping RT bins

Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure 5:

```
Nnon = PMddynamics(M,'useNonOverlapping',1);
```

The following commands will plot all parts of Figure 5: 

5A

```
Nnon.plotTrajectories('showPooled',1,'showGrid',0, 'hideAxes',1);
```

5B-E

```
Nnon.plotKinet;
```



## Figure 6: Single-trial analysis and decoding

Open 'plotFigure6.m'. Load regressions.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure 6. 

```
D= PMDdecoding(regressions) 
```

The following commands will plot all parts of Figure 6: 

6A
> D.plotRTLFADS() 

6B
> D.plotChoiceLFADS()

6C & E
> D.plotR2() 

6D & F
> D.plotAcc()


## Figure 7: Initial conditions and inputs contribute to choice-related dynamics 
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure 7:
> N30 = PMddynamics(M); 
> N30.calcWinCoh(M);

> Nnon = PMddynamics(M,'useNonOverlapping',1);
> Nnon.calcWinCoh(M);

The following commands will plot all parts of Figure 7: 

7C
> dataTable.trajectories1 = N30.plotTrajectories('showPooled',0,'whichCoh',1, 'showGrid',0, 'hideAxes',1);
>
> dataTable.trajectories2 = N30.plotTrajectories('showPooled',0,'whichCoh',4, 'showGrid',0, 'hideAxes',1);
> 
> dataTable.trajectories3 = N30.plotTrajectories('showPooled',0,'whichCoh',7,'showGrid',0, 'hideAxes',1);

7 D-G
> [~, ~, ~, ~, ~, inputsAndIC] = N30.calcInputsAndIC;

7 H-K
> [~, ~, ~, ~, ~, nonOverlapping] = Nnon.calcInputsAndIC;


## Figure 8: Outcome changes initial conditions

Open 'plotFigure8.m'. Load Figure8Data.mat from DryadData.

Running the following command in POA.m will initialize the data to recreate all of the plots in Figure 8: 
>[r] = POA_plotting(outcome) 

8A
> r.plotComponents()

8B
> r.plotTrajectories()

8C & E
> r.plotKinet()

8D
> r.plotDecoder()

## Figure S3
Open 'plotFigureS3.m'.

Running the following code will initialize the data to recreate all of the plots in Figure S3:
kernel = 0.02;
[ucFR, ucFRc, ucRT, tNew, nNeuronsOut]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
[bcFR, bcFRc, bcRT, tNew, nNeuronsOut]=simulatePMdneurons('BiasedChoice',kernel,nNeurons,nTrials);
[rtFR, rtFRc, rtRT, tNew, nNeuronsOut]=simulatePMdneurons('RT',kernel,nNeurons,nTrials);

3A
> plotPCA(ucFRc, ucRT, tNew, nNeuronsOut);
> plotRegressionToRT(ucFR, ucRT, nTrials);
> plotChoiceDecoding(ucFR, ucRT, nTrials);

3B
> plotPCA(bcFRc, bcRT, tNew, nNeuronsOut);
> plotRegressionToRT(bcFR, bcRT, nTrials);
> plotChoiceDecoding(bcFR, bcRT, nTrials);

3C
> plotPCA(rtFRc, rtRT, tNew, nNeuronsOut);
> plotRegressionToRT(rtFR, rtRT, nTrials);
> plotChoiceDecoding(rtFR, rtRT, nTrials);

## Figure S4

Open 'plotFigure3.m'. If you want to display the 1st unit with 30 ms (S4 A) or 15 ms Gaussian (S4 B) or 50 ms boxcar (S4 C) smoothing presented in Figure S4 run the following commands:

S4A
> Fig3Neurons(1);

S4B
> Fig3Neurons(1, smoothing='gauss15');

S4C
> Fig3Neurons(1, smoothing='box50');

The number corresponds to the order of presentation in the figure and you can plot all 8 units in this manner

## Figure S5
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S5:
> N30 = PMddynamics(M);

> load 15msGaussFRs.mat
> N15 = PMddynamics(M);

> load 50msBoxcarFRs.mat
> N50 = PMddynamics(M);


S5A
dataTable.varExplained = N30.plotVariance('n',10);

S5B
dataTable.var15ms = N15.plotVariance('n',10);

S5C
dataTable.var50ms = N50.plotVariance('n',10);

## Figure S6
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S6:
> N30 = PMddynamics(M);

S6A & B
> dataTable.trialCounts = N30.plotTrialCounts;

## Figure S7
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S7:
> N30 = PMddynamics(M);

S7
> N30.plotTrajectories('showPooled',1,'showGrid',1,'hideAxes',0);
> axis equal

## Figure S9
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S9:
> dataS9= outcome.pcaCohRT;
> [pcDataS9]=calculatePCs_S9(dataS9);

S9A
plotComponents_S9(pcDataS9)

S9B
plotTrajectories_S9(pcDataS9)


## Figure S10
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S10:
> NSU = PMddynamics(M,'useSingleNeurons',1);

S10A
> dataTable.SUtrajectories = NSU.plotTrajectories;

S10B-E
> dataTable.SUKinet = NSU.plotKinet;


## Figure S11
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData. 

Running the following code will initialize the data to recreate all of the plots in Figure S11:
> N30 = PMddynamics(M);

> load 15msGaussFRs.mat
> N15 = PMddynamics(M);

> load 50msBoxcarFRs.mat
> N50 = PMddynamics(M);

S11A
> dataTable.trajectories = N30.plotTrajectories('showPooled',1,'showGrid',0,'hideAxes',1);
> dataTable.traj15ms = N15.plotTrajectories;
> dataTable.traj50ms = N50.plotTrajectories;


S11B-E
> dataTable.kinet = N30.plotKinet;
> dataTable.kinet15ms = N15.plotKinet;
> dataTable.kinet50ms = N50.plotKinet;

## Figure S12
Open 'plotFigureS12.m'.  

Run:
> whichCV='hard';
> [modelToUse,choiceV,RTs,trainError,testError,st,st1,tAxis,whichT]=populationTCA(whichCV);

> whichCV='soft';
> [~,~,~,trainError_soft,testError_soft,st_soft,st1_soft]=populationTCA(whichCV);

S12B
> plotTCAmodel(modelToUse,tAxis,whichT)

S12C
> plotTCAsessionDynamics(modelToUse,choiceV,RTs,tAxis,whichT)

S12D & E
> plotTCAvar(testError_soft,trainError_soft,st_soft,st1_soft)
> plotTCAvar(testError,trainError,st,st1)



## Figure S13
Open 'plotFigureS13.m'. Change directory to folder containing LFADS '.mat' files inside of DryadData (... /DryadData/DryadDataSupp/LFADSdata). 

Run:
> files=dir('*.mat');

S13A
> singleSessionLDS(files);

S13B-C
> bothEpochs(files);


## Figure S14
Open 'plotFigureS14.m'. Change directory to folder containing LFADS '.mat' files inside of DryadData (... /DryadData/DryadDataSupp/FigureS14). 

Run:
> lfadsR = load('Tsess1.mat');
> folder=dir('*.mat');

S14A
> plotLFADSFR(lfadsR);

S14B
> lfadsSingleTrialVarianceExplained(folder);

S14C
> lfadsFR_RT_regression(folder); 


## Figure S15
Open 'plotFigureS15.m'. 

Run:
> [AllRsquare, AllRsquare_s,alignAngles,tAxis,timeValues,whichTimePoint,AllAngles] =redRank2023();

S15B
> plotRedRank(AllRsquare, AllRsquare_s,alignAngles,tAxis,timeValues,whichTimePoint,AllAngles)

## Figure S16
Open 'plotFigureS16.m'. 

Load the following data for S16:
> load regressions.mat
> load 'decoderbyRTBins.mat'

S16A, B
plotRegScatters(regressions)

S16C
plotAccByBin(classifier);

## Figure S17
Open 'plotFigureS17.m'. 

Load the following data for S17:
> load('ChoicePerRTbin_hardCoh.mat');
> load('RTandChoice_hardCoh.mat')
> load('RTandChoice_allCoh.mat');
> load('decoderbyRTBinsAllCoh.mat')

S17A
> plotDecodeByBin(allDecodes,1)

S17B
> plotDecodeByBin(allDecodes,7)

S17C, D
> ChoiceSignals(allFastHardCoh, allSlowHardCoh,justHardRTsigmap,allRTsigmap)



## Figure S18
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S18:
> [r] = POA(outcome);

S18A
> [accPer] = errorRate(outcome.bx.Y_logic);

S18B
> [CCEC_RT]=findBxErrs(outcome.bx.Y_logic,outcme.bx.RT,outcome.bx.ST_logic,'CCEC');
> plotCCEC(CCECC_RT)

S18C
> r.plotVariance

S18D
> load regressions.mat
> load 14October2013_T.mat
> plotLFADS_previousResult(regressions,Trials);

S18E
> [CI, meanDist]=plotComponents(r,'moveAlign',1);

## Figure S19
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S19:
> [r] = POA(outcome,trials ='CCE_ECC');

S19A
> r.plotComponents

S19a (inset)
r.plotVariance

S19B
> r.plotTrajectories

S19C
> [CCEC_RT]=findBxErrs(outcome.bx.Y_logic,outcme.bx.RT,outcome.bx.ST_logic,'CCEC');
> plotCCEC(CCECC_RT)

S19D, E, & inset
> r.plotKinet

## Figure S20
Open 'plotFigure8.m'. Load Figure8data.mat and Figure4_5_7.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S20:
> [r] = POA(outcome);
> [r2]=PMddynamics(M);

S20B
> plotComponents(r,'TrajIn', r.project.TrajIn, 'TrajOut', r.project.TrajOut);

S20C
> plotComponents(r2,'TrajIn', r2.project.TrajInProjRT, 'TrajOut', r2.project.TrajOutProjRT);


## Figure S21
Open 'plotFigureS3.m'.

Running the following code will initialize the data to recreate all of the plots in Figure S21:
nNeurons = 200;
nTrials = 300;

kernel = 0.03;
[~, FRc_30, RT_30, tNew]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
V_30 = plotPCA(FRc_30, RT_30, tNew, nNeurons);

kernel = 0.02;
[~, FRc_20, RT_20, tNew, nNeurons]=simulatePMdneurons('UnbiasedChoice',kernel,nNeurons,nTrials);
V_20 = plotPCA(FRc_20, RT_20, tNew, nNeurons);

S21A
plotSingleTrialPCA(FRc_30, tNew, nNeurons,V_30);

S21B
plotSingleTrialPCA(FRc_20, tNew, nNeurons,V_20);


## Figure S22
Open 'plotFigure8.m'. Load Figure8data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure S22:
> [r] = POA(outcome, 'useSingleNeurons', 'true'); 

S22A & B
> plotBiplot(r);



















