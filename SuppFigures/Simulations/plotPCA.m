function [V, score, pcs] = plotPCA(FRc, RT, tNew, nNeurons)


% RT at different percentile
RTp = prctile(RT, [0:15:100]);
% lower and upper bound of RT percentile
RTl = RTp(1:end-1)
RTr = RTp(2:end)

FRnew = [];
for cId = 1:length(RTl)
    FRnew(:,:,cId,:) = squeeze(nanmean(FRc(:,RT > RTl(cId) & RT < RTr(cId),:,:),2));
end


tFinal = tNew > -0.2 & tNew < 0.6;
bigMatrix = [];
for choiceId = 1:2
    for RTid = 1:length(RTl)
        if isempty(bigMatrix)
            bigMatrix = squeeze(FRnew(:,choiceId, RTid, tFinal));
        else
            bigMatrix = cat(2, bigMatrix, squeeze(FRnew(:,choiceId, RTid, tFinal)));
        end
    end
end

bigMatrix = bigMatrix'./repmat(sqrt(prctile(bigMatrix',99)),[size(bigMatrix,2) 1]);

[coeff, score, V] = pca(bigMatrix);

score = bigMatrix*coeff;
% figure(2);
% I1 = reshape(score, [sum(tFinal) length(RTl) 2 size(score,2)]);
% li1 = plot(tNew(tFinal), squeeze(I1(:,:,1,4)),'-');
% hold on
% li2 = plot(tNew(tFinal), squeeze(I1(:,:,2,4)),'-');
% hold on
% setLineColors(li1);
% setLineColors(li2);


I1 = reshape(score, [sum(tFinal) length(RTl) 2 nNeurons]);

figure(1);
set(gcf,'position',[1000,1000,2000,600])

params = getParams;
params.posterColors;
colV = params.posterColors(ceil(linspace(1,size(params.posterColors,1),length(RTl))),:);

t0 = find(tNew(tFinal) >=0,1,'first');
iX = 1:30:size(I1,1);

orderX = [1:3];

I1(:,:,:,2:3) = -I1(:,:,:,2:3);


subplot(1,3,1)
bigD = [];
for nR = 1:length(RTl)
    plot3(squeeze(I1(:,nR,1,orderX(1))), squeeze(I1(:,nR,1,orderX(2))), squeeze(I1(:,nR,1,orderX(3))),'-','color',colV(nR,:));
    hold on
    plot3(squeeze(I1(:,nR,2,orderX(1))), squeeze(I1(:,nR,2,orderX(2))), squeeze(I1(:,nR,2,orderX(3))),'--','color',colV(nR,:));
    
    currD1 = squeeze(I1(:,nR,1,orderX));
    currD1(:,end+1) = 1;
    currD1(:,end+1) = nR;
    
    
    currD2 = squeeze(I1(:,nR,2,orderX));
    currD2(:,end+1) = 2;
    currD2(:,end+1) = nR;
    
    
    bigD = [bigD; currD1; currD2];
    
    hold on
    plot3(squeeze(I1(t0,nR,:,orderX(1))), squeeze(I1(t0,nR,:,orderX(2))),squeeze(I1(t0,nR,:,orderX(3))),'o','markerfacecolor','r','markeredgecolor','none','markersize',12);
    
    hold on
    plot3(squeeze(I1(end,nR,:,orderX(1))), squeeze(I1(end,nR,:,orderX(2))),squeeze(I1(end,nR,:,orderX(3))),'d','markerfacecolor',colV(nR,:),'markeredgecolor','none','markersize',12);
    
end

pcs = array2table(bigD, 'VariableNames',{'PC1','PC2','PC3','Choice','RT'});

xlabel('PC_1');
ylabel('PC_2');
zlabel('PC_3');


Tv = ThreeVector(gca);
ax = gca;
ax.SortMethod = 'ChildOrder';

% view([-7 72])
