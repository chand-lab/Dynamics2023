function [accPer]=errorRate(Y_logic,varargin)
%
%
%
% Function that plots error streaks across sessions as in SFigure18a
%

perc=5;

assignopts(who,varargin)

CR = Y_logic;

% Organize sessions into fifths; with -1 to fill in columns
percentile= cell(length(CR),1);
for sess =1:length(CR)
    
    r=mod(length(CR{sess,1}),perc);
    div=ones(perc-r,1)*-1;
    percentile{sess,1}=reshape([CR{sess,1};div],perc,[])'; 

end

%number of errors over number number of trials per division of a session
accPer = zeros(length(CR),perc);
for sess = 1:length(CR)%141
    for col = 1:perc

        Y_quintile=percentile{sess,1}(:,col);
        countNeg=sum(Y_quintile == -1); % to remove -1s from the length
        accPer(sess,col)=length(find(~Y_quintile))/(length(Y_quintile)-countNeg);


    end
end

% Performance streak plot
accPer=accPer*100;
figure; boxplot(accPer,'Notch','on');
axis off

% parameters for the plot
ymin=round(min(min(accPer)),2);
ymax=round(max(max(accPer)),2);
yLims=[ymin,ymax];
ymed=median(median(accPer));
Q1=floor(mean(quantile(accPer,0.25)));
Q3=ceil(mean(quantile(accPer,0.75)));
yTicks=[ymin, Q1,ymed,Q3, ymax];
xLims=[1, perc];
xTicks= 1:perc;
hold on;
getAxesP(xLims, xTicks,1, ymin-(ymin/5), 'Part of session', yLims, yTicks, 0.5, 0.5, 'Error Rate (%)',[1 1]);
axis square;
axis tight;




end