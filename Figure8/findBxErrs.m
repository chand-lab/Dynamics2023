function [CCEC_RT]=findBxErrs(Y_logic,RT,ST_Logic,type)

switch(type)
    case 'CCEC'
    % Find all CCEC's and CC's to compare to EC's
cmp_err= [0;1];
cmp_corr=[1;1];
errInd.Err=[];
errInd.Corr=[];

   
%Find all EC's and all CC's
for sess=1:length(Y_logic)
    cnt_err=0;
    cnt_corr=0;
    for i=1:length(Y_logic{sess,1})-1
        test= Y_logic{sess,1}(i:i+1,1); % test - current section to compare to cmp to find template for PES
        if all(test==cmp_err)
            cnt_err=cnt_err+1;
            errInd.Err{sess,1}(cnt_err,1)=i; % PERTS captures i's where the desired sequence begins
        elseif all(test==cmp_corr)
            cnt_corr=cnt_corr+1;
            errInd.Corr{sess,1}(cnt_corr,1)=i; %
        else
        end
    end
end
%         
 %Find CC's to match with EC's        
 for sess=1:length(errInd.Err)
     i=1;
     errInd.errCorrMatch{sess,1}=[];
     buff=2;
     back=0;
     while length(errInd.errCorrMatch{sess,1})<length(errInd.Err{sess,1})
         test=errInd.Err{sess,1}(i)-buff;
         if any(test==errInd.Corr{sess,1}) && ~any(test==errInd.errCorrMatch{sess,1})
             errInd.errCorrMatch{sess,1}(i,1)=test;
             buff=2;
             i=i+1;
         else
             buff=buff+1;
             if buff>max(errInd.Err{sess,1})
                 corrSort=sort(errInd.Corr{sess,1},'descend');
                 errInd.errCorrMatch{sess,1}(i,1)=corrSort(1+back);
                 i=i+1;
                 buff=2;
                 back=back+1;
             else
             end
         end
     end
 end
%   

errInd.errCorrMatchAll=[];
for sess=1:length(errInd.Err)
    errInd.errCorrMatchAll{sess,1}=[errInd.errCorrMatch{sess,1},errInd.errCorrMatch{sess,1}+1 ...
        errInd.Err{sess,1},errInd.Err{sess,1}+1];
end

for sess=1:141
    STs=find(ST_Logic{sess,1});
    for i =1: length(errInd.errCorrMatchAll{sess,1})
        STs_Errs{sess,1}(i,1)=sum(sum(errInd.errCorrMatchAll{sess,1}(i,:)==STs,2))==4;
    end
end


for sess=1:length(errInd.Err)
    trials=errInd.errCorrMatchAll{sess,1}(STs_Errs{sess,1}==1,:);
    errInd.PES_CCEC_RT{sess,1}=RT{sess,1}(trials);
end


CCEC_RT=vertcat(errInd.PES_CCEC_RT{:});

fastInd=sum(CCEC_RT<200,2)==1;
CCEC_RT_filt=CCEC_RT;
CCEC_RT_filt(fastInd,:)=[];

CCEC_RT=CCEC_RT_filt;


case 'CCE_ECC'

for sess=1:141
    Errs{sess,1}=find(~Y_logic{sess,1} & ST_Logic{sess,1});
end

for sess=1:141
    cntECC=0;
    cntCCE=0;
    for tr=1: length(Errs{sess,1})
        errLoc=Errs{sess,1}(tr,1);
        if errLoc+2 > length(Y_logic{sess,1})
            %do nothing
        else
            ECC_tmp=Y_logic{sess,1}(errLoc:errLoc+2)';
            if all(ECC_tmp == [0,1,1])
                cntECC=cntECC+1;
                ECC_Bx{sess,1}(cntECC,:)=errLoc;
                ECC_BxLocs{sess,1}(cntECC,:)=errLoc:errLoc+2;
            else
                %do nothing
            end
            if errLoc-2 < 1
                %do nothing
            else
                CCE_tmp=Y_logic{sess,1}(errLoc-2:errLoc)';
                if all(CCE_tmp == [1,1,0])
                    cntCCE=cntCCE+1;
                    CCE_Bx{sess,1}(cntCCE,:)=errLoc;
                    CCE_BxLocs{sess,1}(cntCCE,:)=errLoc-2:errLoc;
                else
                    %do nothing
                end
            end
        end
    end
end


for sess=1:141
    STs=find(ST_Logic{sess,1});
    for i =1: length(CCE_BxLocs{sess,1})
        CCE_STs_Errs{sess,1}(i,1)=sum(sum(CCE_BxLocs{sess,1}(i,:)==STs,2))==3;
    end
end

for sess=1:141
    STs=find(ST_Logic{sess,1});
    for i =1: length(ECC_BxLocs{sess,1})
        ECC_STs_Errs{sess,1}(i,1)=sum(sum(ECC_BxLocs{sess,1}(i,:)==STs,2))==3;
    end
end


for sess=1:length(CCE_BxLocs)
    CCE_trials{sess,1}=CCE_BxLocs{sess,1}(CCE_STs_Errs{sess,1},:);
    ECC_trials{sess,1}=ECC_BxLocs{sess,1}(ECC_STs_Errs{sess,1},:);
    CCE_RT{sess,1}=RT{sess,1}(CCE_trials{sess,1});
    ECC_RT{sess,1}=RT{sess,1}(ECC_trials{sess,1});
end

CCE_trials2=vertcat(CCE_trials{:});
ECC_trials2=vertcat(ECC_trials{:});


CCE_RT2=vertcat(CCE_RT{:});
ECC_RT2=vertcat(ECC_RT{:});



CCE_fastInd=find(sum(CCE_RT2<200,2));
CCE_RT_filt=CCE_RT2;
CCE_RT_filt(CCE_fastInd,:)=[];
CCE_trials2(CCE_fastInd,:)=[];

ECC_fastInd=find(sum(ECC_RT2<200,2));
ECC_RT_filt=ECC_RT2;
ECC_RT_filt(ECC_fastInd,:)=[];
ECC_trials2(ECC_fastInd,:)=[];

numWeak=length(ECC_RT_filt)-length(CCE_RT_filt);
% remove numWeak randomly from ECC_RT_filt so columns can be same size 
% 81 random numbers with range from 1 - 23,094
a = 1;
b = length(ECC_RT_filt);
r = round((b-a).*rand(numWeak,1) + a);
ECC_RT_filt(r,:)=[];

CCECC_RT=[CCE_RT_filt(:,1:2),ECC_RT_filt(:,1:2)];

CCEC_RT= CCECC_RT;


end
end
