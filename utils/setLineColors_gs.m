function setLineColors_gs(b, varargin)
%
linewidth = 1;
linestyle = '-';
assignopts(who, varargin);

Params = getParams;
D = floor(linspace(1,size(Params.cohColors_gs,1),length(b)));
for k=1:length(b)
    set(b(k),'color',Params.cohColors_gs(D(k),:), 'linewidth',linewidth, 'linestyle',linestyle);
end
set(gca,'visible','off','clipping','off');