function reportMeanAndCI(Xv)
%
%
%
mu = nanmean([Xv.rIC]);
sd = nanstd([Xv.rIC]);
tV = tinv(0.005,50);

cprintf('magenta', sprintf('\n Initial Condition: %3.3f(%3.3f - %3.3f)', mu, mu-tV*sd, mu + tV*sd));



mu = nanmean([Xv.rCoh]);
sd = nanstd([Xv.rCoh]);

cprintf('yellow', sprintf('\n Coherence: %3.3f(%3.3f - %3.3f)', mu, mu-tV*sd, mu + tV*sd));
