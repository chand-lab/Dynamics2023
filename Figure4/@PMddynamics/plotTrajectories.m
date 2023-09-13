function dataTable = plotTrajectories(r, varargin)
% plotTrajectories - plots 3D PCA trajectories for for the specified dimensions from PCA on firing rates organized by RT and choice
%
% Needed Inputs:
%
%   r - the object from the PMddynamics class.
%
% Variable Inputs
%     dimsToShow - Which dimensions to plot.
%     marker - marker for the trajectories
%     mSize - marker size
%     step - time between adjacent points on the trajectories
%     mEdgeColor - color of the edge of the markers
%     lW - linewidth for trajectories
%     m300Size - Marker size for the 300 ms point
%     showPooled - show pooled or individual coherences
%     hideAxes - hide or show axes
%     showGrid - show the grid
%     vectorLength - length of the three vector axes
%
% see also PMddynamics
% Chand, Mar 30th 2023
% Chand, April 2023




dimsToShow = r.metaData.dimsToShow;
marker = 's';
mSize = 9;
step = r.metaData.dt*3;
mEdgeColor = [0.8 0.8 0.8];
lW = 2;
m300size = 14;
showPooled= true;
hideAxes = false;
showGrid = true;
vectorLength = 2;
whichCoh = 1;
axisInset = [5 5];

assignopts(who, varargin);
% Decide if we want to show pooled data or nonpooled data
% If non pooled then select the coherence that you want.
if showPooled
    tData = r.signalplusnoise.tData;
    cValues = r.metaData.condColors;
    TrajIn = r.signalplusnoise.TrajIn;
    TrajOut = r.signalplusnoise.TrajOut;
else
    tData = r.signalplusnoise.tData;
    cValues = r.metaData.condColors;
    TrajIn = r.perCoh(whichCoh).pcaData.TrajIn;
    TrajOut = r.perCoh(whichCoh).pcaData.TrajOut;
end



cIds = ceil(linspace(1,11,length(tData)));
cValues = cValues(cIds,:);

% Create a new figure
f = figure('units','normalized','position',[0.2049 0.1292 0.6026 0.6394],'color',[1 1 1]);

AllD = {};
for k=1:length(r.signalplusnoise.tData)
    
    timePts = tData{k};
    zeroPt = find(timePts >-0.002 & timePts < 0.0,1,'first');
    movePt = find(timePts >.225,1,'first');
    
    S1 = TrajIn{k}(:,dimsToShow(1));
    S2 = TrajIn{k}(:,dimsToShow(2));
    if r.processingFlags.useSingleUnits == 1
        S2 = -S2;
    end
    S3 = TrajIn{k}(:,dimsToShow(3));
    
    
    cData1 = [S1 S2 S3];
    cData1(:,end+1) = k;
    cData1(:,end+1) = 1;
    
    % Plot the left trajectories
    X = 1:step:length(S1);
    ixV = 1:length(S1);
    
    hold on;
    plot3(S1(ixV),S2(ixV),S3(ixV),'color',cValues(k,:),'color', cValues(k,:), 'linewidth',lW);
    E = plot3(S1(X),S2(X),S3(X),'color',cValues(k,:),'MarkerFaceColor', [cValues(k,:)],'MarkerEdgeColor',mEdgeColor,'marker',marker,'markersize',mSize,'linestyle','none');
    
    
    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        plot3(S1(movePt),S2(movePt),S3(movePt),'color',cValues(k,:),'marker','d','markerFaceColor',cValues(k,:),'markersize',m300size);
    end
    
    S1 = TrajOut{k}(:,dimsToShow(1));
    S2 = TrajOut{k}(:,dimsToShow(2));
    
    if r.processingFlags.useSingleUnits == 1
        S2 = -S2;
    end
    
    
    % Plot the right trajectories.
    S3 = TrajOut{k}(:,dimsToShow(3));
    
    
    cData2 = [S1 S2 S3];
    cData2(:,end+1) = k;
    cData2(:,end+1) = 2;
    
    
    plot3(S1(ixV),S2(ixV),S3(ixV),'color',cValues(k,:),'color', cValues(k,:),  'linewidth',lW,'linestyle','--');
    plot3(S1(X),S2(X),S3(X),'color',cValues(k,:),'MarkerFaceColor', cValues(k,:),'MarkerEdgeColor',mEdgeColor,'marker',marker,'markersize',mSize, 'linestyle','none');
    
    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        plot3(S1(movePt),S2(movePt),S3(movePt),'color',cValues(k,:),'marker','d','markerFaceColor',cValues(k,:),'markersize',m300size);
    end
    
    AllD{k} = [cData1; cData2];
    
end

for b=1:length(dimsToShow)
    vNames{b} = sprintf('Dim%d',dimsToShow(b));
end
vNames{end+1} = 'Id';
vNames{end+1} = 'Choice';

dataTable = array2table(vertcat(AllD{:}), 'VariableNames',vNames);


% Plot with nice data
str1 = sprintf('X%d', dimsToShow(1));
str2 = sprintf('X%d', dimsToShow(2));
str3 = sprintf('X%d', dimsToShow(3));
xlabel(str1,'interpreter','latex');
ylabel(str2);
zlabel(str3);
axis square;
axis tight;
clear ThreeVector;

try
    Tv = ThreeVector(gca);
    % Tv.positionFrozenCorner = [0.22 0.2];
    
    
    
    Tv.hideAxes = hideAxes;
    Tv.niceGrid = showGrid;
    Tv.vectorLength = vectorLength;
    Tv.axisInset = axisInset;
catch
end
set(gca,'CameraPosition',r.metaData.camPosition);

% Allows proper exporting
ax = gca;
ax.SortMethod = 'ChildOrder';


end

