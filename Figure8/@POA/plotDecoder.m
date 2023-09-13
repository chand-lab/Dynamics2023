function plotDecoder(r)

figure;
binAcc2=vertcat(r.decode.binAcc{:});
binAcc3=[binAcc2{:}];

xlin=linspace(-600,1200,r.decode.bins);
y=[mean(binAcc3,2)*100]';
%                     plot(xlin,y,'LineWidth',3)
w=0;
err=std(binAcc3*100,w,2)./sqrt(size(binAcc3*100,1));
err=err'*1;
L = y - err;
U = y + err;

hold on;
plot([-600 1200],[50 50],'--k','LineWidth',2)
ShadedError8(xlin,y,err)



%Make axes
ymin=floor(min([mean(binAcc3,2);(L'/100)])*100);
ymax=ceil(max([mean(binAcc3,2);(U'/100)])*100);
yLims=[ymin,ymax];
yTicks=[ymin, 50, ymax];
xLims=[-600, 1200];
xTicks= [-600 -300 0 300 600 900 1200];
plot([0 0],[ymin ymax],'--k','LineWidth',2)
axis off
getAxesP(xLims, xTicks,0.5, ymin-0.1, 'Time (ms)', yLims, yTicks, 0.1, -630, 'Accuracy (%)',[1 1]);
axis square;
axis tight;

end