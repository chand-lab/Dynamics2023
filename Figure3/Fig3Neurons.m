function [y,y2,t,t2,SEM,SEM2]=Fig3Neurons(unit,varargin)

% choose the smoothing - 'gauss30', 'gauss15', 'box50'
smoothing='gauss30';
offset=0;
% choose RT ('RT') coherence ('Coh') for main figure
cond='RT';
assignopts(who, varargin);

%Load in data for the neuron
load('HetNeurons.mat','Data')
Data=Data(unit).Unit;


FR_Cue=getfield(Data.FRs.Cue,smoothing);
FR_Move=getfield(Data.FRs.Cue,smoothing);


%Figure creation with title
figure('units','normalized','outerposition',[0.1 0.1 0.6 0.6])


center_title=sgtitle(['Monkey ', Data.Monkey,'; ',Data.Date, '; Channel ' num2str(Data.Ch), ', Unit ', num2str(Data.Unit)]);
center_title.FontWeight = 'bold';
center_title.FontSize = 12;

%Top left plot - FR by coherence; cue aligned
tLeftHand=subplot(2,2,1);
[y,~,t,SEM]=plotConv(FR_Cue,Data.Choice,Data.Coherence,Data.RT,'Coh',Data.bound1,Data.bound2,'Cue');
hold on;
set(gca,'visible','off');
tc = getTextLabel(0,{'Cue'},{'b'});
axis tight


%Top right plot - FR by RT; cue aligned
tRightHand=subplot(2,2,2);
[~,y2,t2,SEM2]=plotConv(FR_Cue,Data.Choice,Data.Coherence,Data.RT,'RT',Data.bound1,Data.bound2,'Cue');
set(gca,'visible','off');
axis tight


%Bottom left plot - FR by coherence; movement aligned
bLeftHand=subplot(2,2,3);
[y3]=plotConv(FR_Move,Data.Choice,Data.Coherence,Data.RT,'Coh',Data.bound1,Data.bound2,'Mov');
set(gca,'visible','off');
tm = getTextLabel(0,{'Move'},{'b'});
axis tight

%Bottom right plot - FR by RT; movement aligned
bRightHand=subplot(2,2,4);
[~,y4]=plotConv(FR_Move,Data.Choice,Data.Coherence,Data.RT,'RT',Data.bound1,Data.bound2,'Mov');
set(gca,'visible','off');
axis tight



%Determine y axes height and x label offset
y_max=ceil(max(max(cellfun(@max,[y,y2,y3,y4])))/10)*10;
if y_max == 20
    hlaboff = 3;
elseif y_max == 40 || y_max == 50
    hlaboff = 6;
else
    hlaboff = 9;
end

cxLims = [-100 600];
cxTicks = [-100 100 300 500];

mxLims = [-600 100];
mxTicks = [-600:200:-200 100];

%Place axes
set(gcf,'CurrentAxes',tLeftHand)
getAxesP(cxLims,cxTicks,hlaboff,-1, 'Time (ms)', [0 y_max],[0 y_max],10,-110, 'Firing rate (Spikes /s)',[1 1], tc);
drawRestrictedLines(0,[0 y_max]);

set(gcf,'CurrentAxes',tRightHand)
getAxesP(cxLims,cxTicks,hlaboff,-1, 'Time (ms)', [0 y_max],[0 y_max],10,-110, 'Firing rate (Spikes /s)',[1 1], tc);
drawRestrictedLines(0,[0 y_max]);

set(gcf,'CurrentAxes',bLeftHand)
getAxesP(mxLims,mxTicks,hlaboff,-1, 'Time (ms)', [0 y_max],[0 y_max],10,-610, 'Firing rate (Spikes /s)',[1 1], tm);
drawRestrictedLines(0,[0 y_max]);

set(gcf,'CurrentAxes',bRightHand)
getAxesP(mxLims,mxTicks,hlaboff,-1, 'Time (ms)', [0 y_max],[0 y_max],10,-610, 'Firing rate (Spikes /s)',[1 1], tm);
drawRestrictedLines(0,[0 y_max]);


%left/right reach legend

h = zeros(2, 1);
h(1) = plot(NaN,NaN,'k-','LineWidth',2);
h(2) = plot(NaN,NaN,'k--','LineWidth',2);
legend(h, 'Left Reach','Right Reach','Location','northwest','FontSize',12,'TextColor','black');
legend('boxoff')

%plot color bars

% xy positioning
Params = getParams;
cbPos=[0.205 .94];
cbSize=[0.2 0.012];
fSize=12;
cbLyPos=1.8;

%coherence color bar
newMap=custColorBar(Params.cohColors_gs,tLeftHand,cbPos,cbSize,fSize,cbLyPos,...
    'string','Coherence','labLeft','90','labRight','4');
 
% RT color bar
cbPos2=[0.65 .94];
custColorBar(Params.posterColors,tRightHand,cbPos2,cbSize,fSize,cbLyPos);

% % plot individual 
% 
fig=figure('units','normalized','outerposition',[0 0 1 1]);
plotConv(FR_Cue,Data.Choice,Data.Coherence,Data.RT,cond,Data.bound1,Data.bound2,'Cue');
set(gca,'visible','off');
tc = getTextLabel(0,{'Cue'},{'b'});
axis tight;
getAxesP(cxLims,cxTicks,hlaboff,-1, 'Time (ms)', [0 y_max+offset],[0 y_max+offset],10,-110, 'Firing rate (Spikes /s)',[1 1], tc);
drawRestrictedLines(0,[0 y_max+offset]);


end