function [TrajIn, TrajOut] = chopScoreMatrix(score, Lens)
%
%
% CC, Shenoylab, March 2014
Din = score(1:sum(Lens),:);
Dout = score(sum(Lens)+1:end,:);


TrajIn = {};
TrajOut = {};
i = 1;
for k=1:length(Lens)
    idx = i:i+Lens(k)-1;
    if idx > size(Din,1)
        idx = idx(1):size(Din,1);
    end
    TrajIn{k} = Din(idx,:);
    TrajOut{k} = Dout(idx,:);
    i = i + Lens(k);
end
