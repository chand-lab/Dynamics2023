# Code for recreating figures from Boucher et al., 2023

MATLAB and Python code used to construct the figures found in:

> _Boucher PO, Wang T, Carceroni L, Kane G, Shenoy KV, Chandramouli C_
> __Initial conditions combine with sensory evidence to induce decision-related dynamics in premotor cortex__

Experimental data ([https://doi:10.5061/dryad.9cnp5hqn0](doi:10.5061/dryad.9cnp5hqn0)) and scripts ([https://github.com/chand-lab/Dynamics2023](https://github.com/chand-lab/Dynamics2023)) are organized based on the order of figures in the manuscript (tested in Matlab R2021b).

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


- [Data Description](#Description-of-the-data-and-file-structure)
- [Figure 2](#Figure-2:-Psychometric-curves-for-the-monkey,-and-RT-and-box-plots)

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

```
D.plotRTLFADS() 
```
6B
```
D.plotChoiceLFADS()
```
6C & E
```
D.plotR2() 
```
6D & F
```
D.plotAcc()
```

## Figure 7: Initial conditions and inputs contribute to choice-related dynamics 
Open 'plotFigure4_5_7.m'. Load Figure4_5_7data.mat from DryadData.

Running the following code will initialize the data to recreate all of the plots in Figure 7:

```
N30 = PMddynamics(M); 
N30.calcWinCoh(M);
```

```
Nnon = PMddynamics(M,'useNonOverlapping',1);
Nnon.calcWinCoh(M);
```

The following commands will plot all parts of Figure 7: 

7C

```
dataTable.trajectories1 = N30.plotTrajectories('showPooled',0,'whichCoh',1, 'showGrid',0, 'hideAxes',1);
dataTable.trajectories2 = N30.plotTrajectories('showPooled',0,'whichCoh',4, 'showGrid',0, 'hideAxes',1);
dataTable.trajectories3 = N30.plotTrajectories('showPooled',0,'whichCoh',7,'showGrid',0, 'hideAxes',1);
``` 

7 D-G

```
[~, ~, ~, ~, ~, inputsAndIC] = N30.calcInputsAndIC;
```

7 H-K

```
[~, ~, ~, ~, ~, nonOverlapping] = Nnon.calcInputsAndIC;
```

## Figure 8: Outcome changes initial conditions

Open 'plotFigure8.m'. Load Figure8Data.mat from DryadData.

Running the following command in POA.m will initialize the data to recreate all of the plots in Figure 8: 

```
[r] = POA_plotting(outcome) 
```

8A

```
r.plotComponents()
```

8B
```
r.plotTrajectories()
```

8C & E

```
r.plotKinet()
```

8D

```
r.plotDecoder()
```













