function dataV = calcSpeed(r,temp, varargin)

nDimensions = 6;
assignopts(who, varargin);

model = temp;
Lens = [];
for n=1:length(model.tData)
    Lens(n) = length(model.tData{n});
end

[maxLen, ind]= max(Lens);
nNans = maxLen-Lens;
rawData =[];
rawData2 = [];


for k=1:length(model.TrajIn)
    currDataIn = model.TrajOut{k};
    NanMatrix = NaN*ones(nNans(k),nDimensions);
    rawData(:,k,:) = [currDataIn(:,1:nDimensions); NanMatrix]';

    currDataOut = model.TrajIn{k}; %r.signalplusnoise
    NanMatrix = NaN*ones(nNans(k),nDimensions);
    rawData2(:,k,:) = [currDataOut(:,1:nDimensions); NanMatrix]';

end
tValues = model.tData{ind};



dt=.01;

rawDataKinet = rawData(:,[2 3 1 4],1:10:end);
rawDataKinet2 = rawData2(:,[2 3 1 4],1:10:end);
[Sp, tVect, distAll] = KiNeT(rawDataKinet, dt);
[Sp2, ~, distAll2] = KiNeT(rawDataKinet2, dt);

dataV.V = mean(cat(3,Sp,Sp2),3);
dataV.tVect = tVect;
dataV.distancesAll = mean(cat(3,distAll,distAll2),3); %Taking absolute value here as there should be no negative values

end