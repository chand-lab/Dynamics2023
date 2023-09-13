function  plotKinet(r)

% parameters for plotting KiNeT speed and distance
lineColor = [0 1 1 ; 1 0 0;  0 1 0; 1 0 1];
E_V=std(r.kinet.BootV,0,3);
E=std(r.kinet.BootDist,0,3);
x=r.kinet.tVect;
Xcoords = [x x(end:-1:1)];

%KiNeT speed plot
figure;
for i = 1:4
    %calculate and plot std of bootstrapped KiNeT
    E_V1=E_V(:,i);
    y=r.kinet.V(:,i);
    L = y' - E_V1';
    U = y' + E_V1';
    Ycoords = [U L(end:-1:1)]*1000-400;
    Pa=patch(Xcoords,Ycoords,lineColor(i,:), 'FaceAlpha',.15);
    set(Pa,'linestyle','none');
    hold on;
    
    %plot KiNeT velocity results
    line(r.kinet.tVect,y*1000-400, ...
        'Color',lineColor(i,:),'LineWidth',2);
end

% KiNeT velocity plot parameters
time=getTextLabel([0 0.2 0.4 0.6 0.8], {'-400', '-200', 'Cue', '200', '400'}, {'k', 'k', 'b', 'k','k'});
set(gca,'visible','off');
hold on
getAxesP([0 .8],[],50,-420,'Reference Time',[-400 500],[-400 -200 0 200 400],0.04,0,'Speed (ms)',[1 1],time);
plot([0 0.81], [0.5 0.5],'k--','LineWidth',1)
plot([0.4 0.4], [-400 400],'k--','LineWidth',1)
axis square;
axis tight;


%KiNeT distance plot
figure;
for i = 1:4
   %calculate plot std of bootstrapped KiNeT distance
    E1=E(:,i);
    y=-r.kinet.distancesAll(:,i)';
    L = y - E1';
    U = y + E1';
    Ycoords = [U L(end:-1:1)];
    Pa=patch(Xcoords,Ycoords,lineColor(i,:), 'FaceAlpha',.15);
    set(Pa,'linestyle','none');
    hold on;

    %plot KiNeT distance results
    line(r.kinet.tVect,y, ...
        'Color',lineColor(i,:),'LineWidth',2);
end

% KiNeT distance plot parameters
set(gca,'visible','off');
hold on
getAxesP([0 .81],[],4,-42,'Reference Time',[-40 40],[-40 -20 0 20 40],0.04,0,'Euclidean distance (a.u.)',[1 1],time);
plot([0.4 0.4], [-40 40],'k--','LineWidth',1)
axis square;
axis tight;

% plot difference from reference versus shuffles
if isfield(r.kinet,'shuffV')

kinetVsub=(r.kinet.V-r.kinet.V(:,3))*1000;
numshuf=size(r.kinet.shuffV,3);
ShuffleV = r.kinet.shuffV - repmat(r.kinet.shuffV(:,:,3),[1 1 numshuf]);
ShuffleV = mean(ShuffleV(:,[1 2 4], :),2);

ShuffleV =squeeze(ShuffleV);


figure; hold on;
line(r.kinet.tVect, prctile(1000*ShuffleV',[5 95])', 'Color', 'k','LineStyle','--','LineWidth',2);
lineColor = [0 1 1 ; 1 0 0;  0 1 0; 1 0 1];
for i = [1 2 4]
    line(r.kinet.tVect,kinetVsub(:,i), ...
        'Color',lineColor(i,:),'LineWidth',2);
end

time=getTextLabel([0 0.2 0.4 0.6 0.8], {'-400', '-200', 'Cue', '200', '400'}, {'k', 'k', 'b', 'k','k'});
ymin=min(min(kinetVsub));
ymax=max(max(kinetVsub));
set(gca,'visible','off');
hold on
getAxesP([0 .8],[],20,ymin-105,'Reference Time',[ymin-105 ymax+5],[ymin-105,-50,0,50,ymax+5],0.1,0,'Difference from reference (ms)',[1 1],time);
plot([0 0.81], [0.5 0.5],'k--','LineWidth',1)
plot([0.4 0.4], [ymin-105 ymax+5],'k--','LineWidth',1)
axis square;
axis tight;
end

end
