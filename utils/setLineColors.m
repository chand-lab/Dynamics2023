function setLineColors(b, varargin)
%
linewidth = 1;
linestyle = '-';
assignopts(who, varargin);

Params = getParams;
D = floor(linspace(1,size(Params.posterColors,1),length(b)));
for k=1:length(b)
    set(b(k),'color',Params.posterColors(D(k),:), 'linewidth',linewidth, 'linestyle',linestyle);
end
set(gca,'visible','off','clipping','off');