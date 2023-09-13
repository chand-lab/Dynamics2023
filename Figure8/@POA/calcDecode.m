function  calcDecode(r,outcome)

bins=size(r.decode.binnedSpikeTimes{1,1}{1,1},1); %numBins
sess = r.decode.sessions;

for s=1:length(sess)
    for c=1:length(r.decode.binnedSpikeTimes{s})
        if isempty(r.decode.binnedSpikeTimes{s}{c}) == 0

            preOutInd=outcome.errInd.errCorrMatchAll{sess(s),1}{c,1}(:,[1,3]);
            preOutInd=preOutInd(:);
            Y_train=outcome.Y_logic{sess(s),1}{c,1}(preOutInd);
            spInd=outcome.errInd.errCorrMatchAll{sess(s),1}{c,1}(:,[2,4]);
            spInd= spInd(:);

            for spkb = 1:bins

                spikes=squeeze(r.decode.binnedSpikeTimes{s,1}{c,1}(spkb,spInd,:));
                X_train=[ones(length(spikes),1),spikes];
                Mdl=fitclinear(X_train,Y_train,'Learner','logistic','Kfold',5);
                error = kfoldLoss(Mdl);
                r.decode.binAcc{s,1}{c,1}(spkb,1)=abs(1-error);
                r.decode.binAcc2{s,1}(spkb,c)=abs(1-error);

            end
        else
            %do nothing
        end
    end
end

r.decode.bins=bins;
end