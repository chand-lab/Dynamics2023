
% this function loads and processes session data for the TCA figure
whichCV='hard';
[modelToUse,choiceV,RTs,trainError,testError,st,st1,tAxis,whichT]=populationTCA(whichCV);

whichCV='soft';
[~,~,~,trainError_soft,testError_soft,st_soft,st1_soft]=populationTCA(whichCV);

% S12b
plotTCAmodel(modelToUse,tAxis,whichT)

% S12c
plotTCAsessionDynamics(modelToUse,choiceV,RTs,tAxis,whichT)

% S12d & e

% Top - 'soft'
plotTCAvar(testError_soft,trainError_soft,st_soft,st1_soft)

% Bottom - 'hard' 
plotTCAvar(testError,trainError,st,st1)

