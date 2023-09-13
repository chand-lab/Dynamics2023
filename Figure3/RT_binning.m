function [RTbinsInd, RTbins]=RT_binning(RT)

%Finds center of RT bins

%RT bins - N1 lower bounds, N2 upper bounds
N1 = [300 350 400 450 500 475 480 490 500 525  500];
N2 = [400 425 450 500 550 575 580 650 675 800 1200];

for i=1:length(N1)

    RTbinsInd(:,i)=logical(sum(RT==(N1(i):N2(i)),2));
    RTbins{i,1}=RT(RTbinsInd(:,i));

end

end

