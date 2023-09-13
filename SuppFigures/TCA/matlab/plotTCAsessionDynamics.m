function plotTCAsessionDynamics(modelToUse,choiceV,RTs,tAxis,whichT)
figure;
X1 = modelToUse.u;
Vl = choiceV' == 1 & RTs < 350;
Vl = find(Vl);
Vl = Vl(1:1:min(length(Vl),50));
Vr = choiceV' == 1 & RTs > 600;
Vr = find(Vr);
Vr = Vr(1:1:min(length(Vr),50));

ix = [2 3 4];
Y1 = X1{3}(:,ix(1)).*X1{2}(:,ix(1))';
Y2 = X1{3}(:,ix(2)).*X1{2}(:,ix(2))';
Y3 = X1{3}(:,ix(3)).*X1{2}(:,ix(3))';



tId = 1:size(Y1,2);
hold on
tAll = tAxis(whichT);
bigD = [];



for i=1:length(Vl)
    currT = find(tAll*1000 >= RTs(Vl(i)),1,'first');
    if isempty(currT) | currT > length(tAll)
        currT = length(tAll);
    end
    % for the legend
    d1=plot3(Y1(Vl(i),currT)', Y2(Vl(i),currT)', Y3(Vl(i),currT)', 'kd','markerfacecolor','k','markeredgecolor','none','markersize',12);

    plot3(Y1(Vl(i),currT)', Y2(Vl(i),currT)', Y3(Vl(i),currT)', 'bd','markerfacecolor','b','markeredgecolor','none','markersize',12);
    hold on;
    currT = currT + 4;
    plot3(Y1(Vl(i),:)', Y2(Vl(i),:)', Y3(Vl(i),:)', 'b-');

    currD1 = [Y1(Vl(i),:); Y2(Vl(i),:); Y3(Vl(i),:)]';
    currD1(:,end+1) = 1;
    currD1(:,end+1) = Vl(i);
    bigD = [bigD; currD1];
end



tAll = tAxis(whichT);
for i=1:length(Vr)
    currT = find(tAll*1000 >= RTs(Vr(i)),1,'first');
    if isempty(currT) | currT > length(tAll)
        currT = length(tAll);
        hold on;
        plot3(Y1(Vr(i),1:currT)', Y2(Vr(i),1:currT)', Y3(Vr(i),1:currT)', 'm-');
    else
        plot3(Y1(Vr(i),1:currT)', Y2(Vr(i),1:currT)', Y3(Vr(i),1:currT)', 'm-');
        plot3(Y1(Vr(i),currT)', Y2(Vr(i),currT)', Y3(Vr(i),currT)', 'mo','markerfacecolor','m','markeredgecolor','none','markersize',12);
    end
    currD1 = [Y1(Vr(i),:); Y2(Vr(i),:); Y3(Vr(i),:)]';
    currD1(:,end+1) = 2;
    currD1(:,end+1) = Vr(i);
    bigD = [bigD; currD1];

end

TCAtable.Trajectories = array2table(bigD,'VariableNames',{'X','Y','Z','Type','ID'});

tAll = find(tAll >= 0,1,'first');
% for the legend
o1=plot3(Y1(Vl(1),tAll)', Y2(Vl(1),tAll)', Y3(Vl(1),tAll)', 'ko','markerfacecolor','k','markeredgecolor','none','markersize',12);
plot3(Y1(Vl,tAll)', Y2(Vl,tAll)', Y3(Vl,tAll)', 'bo','markerfacecolor','b','markeredgecolor','none','markersize',12);
hold on
plot3(Y1(Vr,tAll)', Y2(Vr,tAll)', Y3(Vr,tAll)','mo','markerfacecolor','m','markeredgecolor','none','markersize',12);


legend([o1,d1],{'Checkerboard onset', 'Movement onset'},'Box','off');

xlabel('S_2');
ylabel('S_3');
zlabel('S_4');

ThreeVector(gca);

ax = gca;
set(ax,'CameraPosition', [0.0592 0.0475 0.0455]);
set(ax,'CameraTarget', [0.0055 0.0040 0.0100]);

end