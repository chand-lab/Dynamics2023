function newMap=custColorBar(colors,axesVar,cbPos,cbSize,fSize,cbLyPos,varargin)

string='RT';
labLeft='Fast';
labRight='Slow';
assignopts(who, varargin);

%custom colormap creation
map=colors;
for row=1:length(map)-1
    interpMap{row,1}=[linspace(map(row,1), map(row+1,1), 27)', linspace(map(row,2), map(row+1,2), 27)', linspace(map(row,3), map(row+1,3), 27)'];
    if row > 1
        interpMap{row,1}=interpMap{row,1}(2:end,:);
    end
end
newMap=vertcat(interpMap{:});

%plot colorbar
colormap(axesVar,newMap)
c=colorbar(axesVar,'Ticks',[0 1],'location','northoutside','FontSize',fSize);
c.Label.String = string;
c.Label.Position= [0.5 cbLyPos 0];
c.Label.FontName = 'Arial';
c.Label.FontSize = fSize;
c.Position = [cbPos cbSize];
c.TickLabels{1} = [sprintf('\\color[rgb]{%f,%f,%f} ', map(1,:)), labLeft];
c.TickLabels{2} = [sprintf('\\color[rgb]{%f,%f,%f} ', map(length(map),:)), labRight];
end