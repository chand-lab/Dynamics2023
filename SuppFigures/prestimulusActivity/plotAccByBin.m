%% plot average accuracy
function plotAccByBin(classifier)
% create the average accuracy matrix over 51 sessions
aveAccuracy = [];
% load the data created by code above
%a = load('decoderbyRTBins.mat').classifier;
a = classifier;




for jj = 1:length(a)
    aveAccuracy(:,:,jj) = a(jj).accuracy;
end

result = nanmean(aveAccuracy, 3);

cc = [
   0.6091    0.2826    0.7235;
    0.4279    0.3033    0.6875;
    0.2588    0.3136    0.6353;
    0.2510    0.4118    0.6980;
    0.1765    0.6312    0.8588;
    0.1412    0.7450    0.8863;
    0.3686    0.7490    0.5491;
    0.8941    0.7764    0.1530;
    0.8980    0.6548    0.1686;
    0.8863    0.5295    0.1608;
    0.8980    0.4155    0.1647
];

%figure; 
hold on
t = linspace(-600,1200,90);
% for ip = 1:size(result,2)
%     plot(t, result(:,ip), 'color', cc(ip,:), 'linewidth', 2)
% end

for ip = 1:size(aveAccuracy,2)
    
    
    % prepare data without nans
    % validData: data without nans
    bin1Data = squeeze(aveAccuracy(:,ip,:));
    validData = [];
    for n = 1:size(bin1Data,2)
        if sum(isnan(bin1Data(:,n))) == 0
            validData = [validData bin1Data(:,n)];
        end
    end
    

    % specify plot parameters
    options.color_line = cc(ip,:);
    options.color_area = cc(ip,:);
    options.alpha = 0.3;
    options.x_axis = t;
    options.error = 'sem';
    options.handle = figure(1);
    
    % generate error bar; export to excel source data
    [data_mean(ip,:), upperBd(ip,:), lowerBd(ip,:)] = plot_areaerrorbar(validData'*100, options);
end


% cosmetic code
%addpath('./LabCode');

ylimit = 0.4*100;
yUp = 0.9*100;
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

%title('Accuracy with RT Bins', 'fontsize', 20)

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
