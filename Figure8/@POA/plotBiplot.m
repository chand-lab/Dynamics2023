function plotBiplot(r)

figure;
x=r.signalplusnoise.eigenVectors(:,1);
y=abs(r.signalplusnoise.eigenVectors(:,4));
sz=25;
scatter(x,y,sz,"filled")
axis off
%ymin=0;
yLims=[0,.22];
yTicks=0:.05:0.22;
xLims=[-.2,.2];
xTicks= -.2:.05:.2;
hold on;
getAxesP(xLims, xTicks,0.019, -0.01, 'PC 1', yLims, yTicks, 0.05, -0.2, 'PC 4',[1 1]);
axis tight;
axis square;

figure;
biplot(r.signalplusnoise.eigenVectors(:,[1,4]))
axis off
%ymin=-.2;
yLims=[-.2,.22];
yTicks=-.2:.05:.22;
xLims=[-.2,.2];
xTicks= -.2:.05:.2;
hold on;
getAxesP(xLims, xTicks,0.04, -.25, 'PC 1', yLims, yTicks, 0.07, -.25, 'PC 4',[1 1]);
axis tight;
axis square;




end