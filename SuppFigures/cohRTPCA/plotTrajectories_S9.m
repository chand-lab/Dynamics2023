
function plotTrajectories_S9(pcData)
%plot the components for S9
TrajIn = pcData.TrajIn;
TrajOut = pcData.TrajOut;
tData = pcData.tData;
%cValues = pcData.cValues;
dimsToShow = [1 3 4];
marker = 's';
step = 20;
lW = 2;
m300size = 20;
f = figure('units','normalized','position',[0.2049 0.1292 0.6026 0.6394],'color',[1 1 1]);

params=getParams();
cVs = params.posterColors(1:11,:);
McVs=repmat(cVs([1 6 11],:),[3,1]);
cValues = [cVs(1,:) 1; cVs(6,:) 1; cVs(11,:) 1; cVs(1,:) 0.4; cVs(6,:) 0.4; cVs(11,:) 0.4; cVs(1,:) 0.1; cVs(6,:) 0.1; cVs(11,:) 0.1];
alphas=[1;1;1;.4;.4;.4;.1;.1;.1];
for k=1:9

    timePts = tData{k};
    zeroPt = find(timePts >-0.002 & timePts < 0.0,1,'first');
    movePt = find(timePts >.25,1,'first');

    S1 = TrajIn{k}(:,dimsToShow(1));
    S2 = TrajIn{k}(:,dimsToShow(2));
    S3 = TrajIn{k}(:,dimsToShow(3));
    X = 1:step:length(S1);

    hold on;
    plot3(S1(X),S2(X),S3(X),'color',cValues(k,:), 'linewidth',lW);
    s0=scatter3(S1(X),S2(X),S3(X),90,'Marker','square','MarkerFaceColor',McVs(k,:),'MarkerEdgeColor','none');
    s0.MarkerFaceAlpha = alphas(k,1);

    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        s1=scatter3(S1(movePt),S2(movePt),S3(movePt),m300size*10,'marker','d','MarkerFaceColor',McVs(k,:),'MarkerEdgeColor','none');
        s1.MarkerFaceAlpha = alphas(k,1);
    end

    S1 = TrajOut{k}(:,dimsToShow(1));
    S2 = TrajOut{k}(:,dimsToShow(2));
    S3 = TrajOut{k}(:,dimsToShow(3));
    plot3(S1(X),S2(X),S3(X),'color',cValues(k,:),'color', cValues(k,:),  'linewidth',lW,'linestyle','--');
    s2=scatter3(S1(X),S2(X),S3(X),90,'Marker','square','MarkerFaceColor',McVs(k,:),'MarkerEdgeColor','none');
    s2.MarkerFaceAlpha = alphas(k,1);

    if ~isempty(zeroPt)
        plot3(S1(zeroPt),S2(zeroPt),S3(zeroPt),'color',[0.8 0 0 0.5],'marker','o','markerFaceColor','r','markersize',m300size);
        s3=scatter3(S1(movePt),S2(movePt),S3(movePt),m300size*10,'marker','d','MarkerFaceColor',McVs(k,:),'MarkerEdgeColor','none');
        s3.MarkerFaceAlpha = alphas(k,1);
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
Tv.axisInset = [2 2];

set(gca,'CameraPosition',[-352 -599  107]);

end

