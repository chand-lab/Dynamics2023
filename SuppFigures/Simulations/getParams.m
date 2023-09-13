function aP = getParams()
% getParams - gives params for the different analysis run
%
% CC - 8th July 2013

aP.remoteDir = '/net/data/Tiberius/Data/';
aP.sortDir = [aP.remoteDir 'nexFilesForSort/'];
aP.dataDir  = [aP.remoteDir 'dataLoggerFiles/'];
aP.figSaveDir = ['/net/home/mouli/projects/ColorGrid/Results/analFigures/'];




X = [ 11 45 67 78 90 101 108 117 124 135 147 158 180 214 ];
aP.numValues = X;
aP.pairs = [X(1:length(X)/2)' fliplr(X(length(X)/2+1:end))'];
aP.coherence = diff(aP.pairs,1,2)/2.25;

N1 = [300 400 500 575];
N2 = [500 500 600 1000];

N1 = [200 325 350 375 400 425 450 475 500 525  500 300 300  420];
N2 = [425 425 450 475 500 525 550 575 600 625 1000 450 1000 1000];

N1 = [300 325 350 375 400 425 450 475 500 525  500 300 425 500 525];
N2 = [425 425 450 475 500 525 550 575 600 625 1000 400 500 1400 2000];


aP.RTpcL = N1;
aP.RTpcH = N2;

N1 = [300 325 350 400 450 500 600];
N2 = [400 425 450 500 550 600 1000] ;
N1 = [300 325 350 375 400 425 450 475 500 525  500 ];
N2 = [425 425 450 475 500 525 550 575 600 625 1000 ];

aP.eRTpcL = N1;
aP.eRTpcH = N2;
N1 = [300 400 475 525];
N2 = [400 500 550 1000];


N1 = [300];
N2 = [1000];
aP.comRTpcL = N1;
aP.comRTpcH = N2;



aP.gpfa.RTpcL = N1;
aP.gpfa.RTpcH = N2;

aP.binSize = 100;
aP.stepSize = 1;
aP.drawBinSize = 100;
aP.gaussSD = 0.03;
aP.drawGaussSD = 0.020;
aP.minTrials = 3;
aP.tauDecay = 50;
aP.minRT = 300;



hsv = redgreencmap(32);
aP.lineColors = hsv;
aP.posterColors = getEGcolors();
aP.Colors = {'g','k','r',[102 0 0]./255,'m'};
X = getHSVcolors();
aP.cohColors = X([1 3 4 5 7 9 11],:);



T = redgreencmap(16);
aP.leftLineColors = T(1:size(T,1)/2,:);
aP.rightLineColors = T(end:-1:size(T,1)/2,:);



aP.axesWidth = 0.23;
aP.axesHeight = 0.4;
aP.deltaAxes = 0.24;
aP.textOffset = 20;



aP.errorColor = [0.9 0.9 0.9];


aP.markerSize = 8;
aP.checkerboard = 'd';
aP.m100ms = 's';
aP.monset = 'o';
aP.textSize = 12;


aP.movLims = [-1101 700]; % in ms around movement onset
aP.goCueLims = [-600 1200]; % in ms around go cue onset
aP.targetLims = [-301 1800]; % in ms around target onset


aP.Hand.goCueLims = [600 1200];
aP.Hand.MovLims = [600 1200];

baseDir = '/net/derived/chand/';

% Population Data Neurons Save Directory
aP.popdata.saveDir = [baseDir 'populationData/'];
aP.popdata.cattimes = [-0.6 -0.2];
checkDir(aP.popdata.saveDir);

% Population Data behavior save Directory
aP.behavior.saveDir = [baseDir 'behavior/'];
checkDir(aP.behavior.saveDir);

% population Data classifiers save Directory
aP.classifier.saveDir = [baseDir 'classifers/'];
checkDir(aP.classifier.saveDir);
aP.classifier.nFolds = 200;

N1 = [350 400 450 500];
N2 = [450 500 600 1000];

%N1 = [300 325 350 375 400 425 450 475 500 525 525];
%N2 = [400 425 450 475 500 525 550 575 600 625 1000];
%

N1 = [325 350 375 400 425 450 475 500];
N2 = [425 450 475 500 525 550 575 1000];
%
% N1 = [350 430 500];
% N2 = [430 500 1000];
aP.classifier.RTpcL = N1;
aP.classifier.RTpcH = N2;


aP.classifier.types = {'linear','quadratic','diagLinear'};



end

function R = getCohColors()
Cols = {'BF 00 68','3D 04 A1','09 06 A5','04 33 9E','00 83 8F','EC AF 00','EC 6D 00'};
R = zeros(length(Cols),3);
for z = 1:length(Cols)
    T = textscan(Cols{z},'%s');
    T = [T{1}'];
    R(z,:) = [hex2dec(T)]./255;
end

end


function X = getEGcolors()

E = [
    0.7901    0.6094    0.7235;
    0.7207    0.5588    0.6875;
    0.6424    0.5926    0.6353;
    0.6067    0.6404    0.6980;
    0.5556    0.7945    0.8588;
    0.5316    0.8407    0.8863;
    0.4124    0.5079    0.7490;
    0.1402    0.8289    0.8941;
    0.1111    0.8122    0.8980;
    0.0847    0.8186    0.8863;
    0.0570    0.8166    0.8980;
    ];
X = E;
try
    X = hsv2rgb(E);
catch
end
end


function X = getHSVcolors()

E = [
    0.7901    0.6094    0.7235;
    0.7207    0.5588    0.6875;
    0.6424    0.5926    0.6353;
    0.6067    0.6404    0.6980;
    0.5556    0.7945    0.8588;
    0.5316    0.8407    0.8863;
    0.4124    0.5079    0.7490;
    0.1402    0.8289    0.8941;
    0.1111    0.8122    0.8980;
    0.0847    0.8186    0.8863;
    0.0570    0.8166    0.8980;
    0.0270    0.95000   0.95000;
    0  0 0;
    0.6 0.6 0.6;
    ];

X = E;
try
    X = hsv2rgb(E);
catch
end
end

function checkDir(dirV)
if ~exist(dirV,'dir')
    
    [success] = mkdir(dirV);
    if success
        fprintf('\n Making directory : %s', dirV);
    end
end
end

