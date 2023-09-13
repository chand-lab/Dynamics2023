
unTid = unique(D.dataTable.Fig6b.TrialId);

V = [D.dataTable.Fig6b.X D.dataTable.Fig6b.Y D.dataTable.Fig6b.Z];
for i = 1:length(unTid)
    iX = D.dataTable.Fig6b.TrialId==i;
    types = D.dataTable.Fig6b.Type(iX);
    colV = 'b';
    if strcmp(types{1}, 'Right')
        colV = 'r';
    end
    plot3(V(iX,1),V(iX,2), V(iX,3), 'color', colV);
    hold on
    
end

%%