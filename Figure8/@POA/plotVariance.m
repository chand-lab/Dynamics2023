function plotVariance(r, varargin)


n = r.metaData.nComponents;
assignopts(who, varargin);

figure;
plot(1:n,r.signalplusnoise.varExplained(1:n),'md-','markerfacecolor','m','markersize',6)
hold on
plot(1:n,r.noise.varExplained(1:n),'ko-','markerfacecolor',[0.9 0.9 0.9]-0.4,'markersize',6);
set(gca,'visible','off');
getAxesP([1 n],[1 n/2 n],5,-1,'Component',[0 70], [0 10 20 30 40 50 60 70],1,0,'Variance (%)',[1 1]);

line([1 n],[1 1],'color','k','linestyle','--');
axis square;
axis tight;

cprintf('magenta', 'Variance from the first 6 components: %3.2f%% \n', sum(r.signalplusnoise.varExplained(1:6)))


end