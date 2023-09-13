%% plot the results
function plotDecodeByBin(allDecodes,coherence)
cc = [
   0.6091    0.2826    0.7235;
    0.1412    0.7450    0.8863;
    0.8980    0.4155    0.1647
];

% time 
t = linspace(-600,1200,90);

coherences={'90','60','40','31','20','10','4'};

ic=coherence;
easy = allDecodes(ic).classifier;

totalAccuracy = [];
for im = 1:length(easy)
    totalAccuracy(:,:,im) = easy(im).accuracy;
end


for ip = 1:3
    % extract decoding results of 1 RT bin
    oneAcc = squeeze(totalAccuracy(:,ip,:));

    % remove all nans 
    nonNanAcc = oneAcc(:,find(all(~isnan(oneAcc),1)))*100;


    options.x_axis = t;
    options.alpha      = 0.5;
    options.line_width = 5;
    options.error      = 'sem';
    options.handle     = figure(ic);
    options.color_area = cc(ip,:);    
    options.color_line = cc(ip,:);

    % plot error bar; generate source excel data
    [data_mean(ip,:), upperBd(ip,:), lowerBd(ip,:)]= plot_areaerrorbar(nonNanAcc', options);

end



ylimit = 0.39*100;
yUp = 0.8*100;
xpatch = [-600 -600 ylimit ylimit];
ypatch = [ylimit yUp yUp ylimit];
p1 = patch(xpatch, ypatch, 'cyan');
p1.FaceAlpha = 0.1;
p1.EdgeAlpha = 0;

plot([0,0], [ylimit,yUp], 'color', [0 0 0], 'linestyle', '--', 'linewidth',3)
yline(0.5*100, 'k--', 'linewidth', 3);



hLimits = [-600,1200];
hTickLocations = -600:300:1200;
hLabOffset = 0.025*100;
hAxisOffset =  ylimit - 0.015;
hLabel = "Time (ms)"; 

vLimits = [ylimit,yUp];
vTickLocations = linspace(ylimit, yUp, 3); 
vLabOffset = 180;
vAxisOffset =  -650;
vLabel = "Accuracy (%)"; 

title([coherences{ic},'% Coherence'], 'fontsize', 12)

plotAxis = [1 1];

[hp,vp] = getAxesP(hLimits,...
    hTickLocations,...
    hLabOffset,...
    hAxisOffset,...
    hLabel,...
    vLimits,...
    vTickLocations,...
    vLabOffset,...
    vAxisOffset,...
    vLabel, plotAxis);

set(gcf, 'Color', 'w');
axis off; 
axis square;
axis tight;
end