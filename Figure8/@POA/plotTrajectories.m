function plotTrajectories(r, varargin)
dimsToShow = [1 3 4];
marker = 's';
step = 20;
lW = 2;
m300size = 20;
TrajIn = r.signalplusnoise.TrajIn;
TrajOut = r.signalplusnoise.TrajOut;
assignopts(who, varargin)
f = figure('units','normalized','position',[0.2049 0.1292 0.6026 0.6394],'color',[1 1 1]);

tData = r.signalplusnoise.tData;
cValues = r.metaData.condColors;
for k=1:4

    timePts = tData{k};
    zeroPt = find(timePts >-0.002 & timePts < 0.0,1,'first');
    movePt = find(timePts >.25,1,'first');

    S1 = TrajIn{k}(:,dimsToShow(1));
    S2 = TrajIn{k}(:,dimsToShow(2));
    S3 = TrajIn{k}(:,dimsToShow(3));
    X = 1:step:length(S1);

    hold on;
    plot3(S1(X),S2(X),S3(X),'color',cValues(k,:),'MarkerFaceColor', cValues(k,:),'MarkerEdgeColor','none','marker',marker,'markersize',10, 'linewidth',lW);
    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        plot3(S1(movePt),S2(movePt),S3(movePt),'color',cValues(k,:),'marker','d','markerFaceColor',cValues(k,:),'markersize',m300size);
    end

    S1 = TrajOut{k}(:,dimsToShow(1));
    S2 = TrajOut{k}(:,dimsToShow(2));
    S3 = TrajOut{k}(:,dimsToShow(3));
    plot3(S1,S2,S3,'color',cValues(k,:),'color', cValues(k,:),  'linewidth',lW,'linestyle','--');
    plot3(S1(X),S2(X),S3(X),'color',cValues(k,:),'MarkerFaceColor', cValues(k,:),'MarkerEdgeColor','none','marker',marker,'markersize',10, 'linewidth',lW,'linestyle','--');

    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        plot3(S1(movePt),S2(movePt),S3(movePt),'color',cValues(k,:),'marker','d','markerFaceColor',cValues(k,:),'markersize',m300size);
    end

end

str1 = sprintf('X%d', dimsToShow(1));
str2 = sprintf('X%d', dimsToShow(2));
str3 = sprintf('X%d', dimsToShow(3));
xlabel(str1,'interpreter','latex');
ylabel(str2);
zlabel(str3);
axis square;
axis tight;
clear ThreeVector;
Tv = ThreeVector(gca);
Tv.vectorLength = 2;
Tv.axisInset = [3 3];

set(gca,'CameraPosition',[-220 -549 68]);

text(-50, 60,'Correct','Color',cValues(1,:))
text(-50, 50,'Post-correct','Color',cValues(2,:))
text(-25, 60,'Error','Color',cValues(3,:))
text(-25, 50,'Post-error','Color',cValues(4,:))


end
