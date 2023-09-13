%% load in data set needed for all the following figures
load Figure4_5_7data.mat

%% Create object for recreating figure 4 and figure 7c-g
N30 = PMddynamics(M);
N30.calcWinCoh(M);

%% Replicates figures that use non-overlapping bins (e.g., Figure 5, 7h-k);
Nnon = PMddynamics(M,'useNonOverlapping',1);
Nnon.calcWinCoh(M);


%% Figure 4,a-g

dataTable = N30.plotComponents;
sgt = sgtitle('Figure 4A, H');

dataTable.trajectories = N30.plotTrajectories('showPooled',1,'showGrid',0,'hideAxes',1);
sgtitle('Figure 4B');

dataTable.kinet = N30.plotKinet;
sgtitle('Fig. 4C-G');


%% Figure 5, a-e
dataTable.noTraj = Nnon.plotTrajectories('showPooled',1,'showGrid',0, 'hideAxes',1);
sgtitle('Fig. 5A');

dataTable.noKinet = Nnon.plotKinet;
sgtitle('Fig. 5B-E');

%% Figure 7, c-k

% Figure 7a, b
% a. plotTrajectories M.coherence.FR
%N30 = PMddynamics(M);

% b. plotComponents

% Calculate within coh trajectories (Figure 7c & 4b inset)
dataTable.trajectories1 = N30.plotTrajectories('showPooled',0,'whichCoh',1, 'showGrid',0, 'hideAxes',1);
 sgtitle('Fig. 7C: 90%');

dataTable.trajectories2 = N30.plotTrajectories('showPooled',0,'whichCoh',4, 'showGrid',0, 'hideAxes',1);
 sgtitle('Fig. 7C: 31%');

dataTable.trajectories3 = N30.plotTrajectories('showPooled',0,'whichCoh',7,'showGrid',0, 'hideAxes',1);
 sgtitle('Fig. 7C: 4%');

 % Figure 7,d-g
[~, ~, ~, ~, ~, inputsAndIC] = N30.calcInputsAndIC;

% Figure 7, h-k
[~, ~, ~, ~, ~, nonOverlapping] = Nnon.calcInputsAndIC;


%% Figure S5
load 15msGaussFRs.mat
N15 = PMddynamics(M);

load 50msBoxcarFRs.mat
N50 = PMddynamics(M);


% S5a
dataTable.varExplained = N30.plotVariance('n',10);

% S5b
dataTable.var15ms = N15.plotVariance('n',10);

% S5c
dataTable.var50ms = N50.plotVariance('n',10);

%% Replicate Figure S6, which plots Trial counts for various RT bins
dataTable.trialCounts = N30.plotTrialCounts;

%% Replicate Supplemental Figure S7
N30.plotTrajectories('showPooled',1,'showGrid',1,'hideAxes',0);
axis equal
sgtitle('Figure S7');

%% Replicate Figure that uses single neurons (Figure S10)

NSU = PMddynamics(M,'useSingleNeurons',1);
dataTable.SUtrajectories = NSU.plotTrajectories;
dataTable.SUKinet = NSU.plotKinet;

%% Replicate Figure that uses different smoothing kernals (Figure S11)

% uses 15ms gaussian
dataTable.traj15ms = N15.plotTrajectories;
dataTable.kinet15ms = N15.plotKinet;


% uses 50 ms boxcar
dataTable.traj50ms = N50.plotTrajectories;
dataTable.kinet50ms = N50.plotKinet;




