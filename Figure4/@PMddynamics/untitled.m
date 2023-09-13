nDimensions = 7;
dt = N.metaData.dt;

Vall = [];
for b=1:11
    for k=1:7
        tempData.TrajIn{k} = N.perCoh(k).pcaData.TrajIn{b};
        tempData.TrajOut{k} = N.perCoh(k).pcaData.TrajOut{b};
        tempData.Lens(k) = size(tempData.TrajIn{1},1);
        tempData.tData{k} = N.perCoh(k).pcaData.tData{b};
    end
    
    
    RTmodel = tempData;
    lenV = RTmodel.Lens;
    maxLen = max(RTmodel.Lens);
    nNans = [maxLen-lenV];
    rawData =[];
    rawData2 = [];
    
    for k=1:length(RTmodel.TrajIn)
        currData = RTmodel.TrajOut{k};
        NanMatrix = NaN*ones(nNans(k),nDimensions);
        rawData(:,k,:) = [currData(:,1:nDimensions); NanMatrix]';
        
        currData = RTmodel.TrajIn{k};
        NanMatrix = NaN*ones(nNans(k),nDimensions);
        
        rawData2(:,k,:) = [currData(:,1:nDimensions); NanMatrix]';
        
    end
    tValues = RTmodel.tData{1};
    
    rawDataKinet = rawData(:,:,1:dt:end);
    tCorrected = tValues(1:dt:end);
    [V, tVect, distancesAll, dataV.addData] = KiNeT(rawDataKinet, .01);
    dataV.V = V;
    dataV.tVect = tVect;
    dataV.distancesAll = distancesAll;
    
    li = plot(tVect-0.4, V);
    setLineColors(li)
    
    Vall(b,:,:) = V(1:68,:);
end


%%
X = squeeze(nanmean(Vall(3:end,:,:)));
X = X -repmat(X(:,4),[1 7]);

li = plot(X);
setLineColors(li);

plot(nanmean(X(10:20,:)),'ko-')
hold on
plot(nanmean(X(45:55,:)),'o-');
