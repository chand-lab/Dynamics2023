function dataTable = plotVariance(r, varargin)
%
%
% plots variance for signal and signal plus noise as in Machens
% et al.
n = r.metaData.nComponents;
assignopts(who, varargin);



figure;
ShadedError(1:n,nanmean(r.signalerror.varExplained(:,1:n)),1*nanstd(r.signalerror.varExplained(:,1:n))); %,'o-','markerfacecolor','m','markersize',12);
hold on
plot(1:n,nanmean(r.signalerror.varExplained(:,1:n)),'kd','markersize',10,'markerfacecolor',[0.9 0.9 0.9]);
plot(1:n,r.noise.varExplained(1:n),'ko-','markerfacecolor',[0.9 0.9 0.9]-0.4,'markersize',10);
hold on;
set(gca,'visible','off');
getAxesP([1 n],[1:6 n],5,-2,'Component',[0 70],0:10:70,0.5,0.5,'Variance(%)',[1 1]);
line([1 n],[1 1],'color','k','linestyle','--');

cprintf('magenta', 'Variance from the first 6 components: %3.2f%% \n', sum(r.signalplusnoise.varExplained(1:6)))


dataTable = array2table([ [1:n]' nanmean(r.signalerror.varExplained(:,1:n))' nanstd(r.signalerror.varExplained(:,1:n))'],...
            'VariableNames',{'Dimensions','Variance','SEM'});


end