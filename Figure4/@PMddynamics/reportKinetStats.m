function reportKinetStats(r)
% reports statistics for KiNeT speed and distance analysis
%

timePt = r.metaData.kinetTimePt;

params = getParams;
RTlimA = [params.RTpcH + params.RTpcL]/2;

prettyLine();
if ~isfield(r.kinet, 'shuffle')
    
    cprintf('yellow','Calculating shuffle stats');
    r.calcKinetStatistics;
    
else
    cprintf('magenta','\nUsing existing shuffle calculations');
end
shuffle = r.kinet.shuffle;


cprintf('magenta','\nStats computed at at %3.0f ms relative to checkerboard onset', 1000*r.kinet.tVect(timePt));
prettyLine();

trueV = nanmean(corr(RTlimA', squeeze(r.kinet.V(:,20,:))','type','spearman'));
shuffleV = corr(RTlimA', squeeze(shuffle.speed(:,20,:))','type','spearman');
printPvalues('Speed', shuffleV, trueV);


trueV = nanmean(corr(RTlimA', squeeze(r.kinet.distancesAll(:,20,:))','type','spearman'));
shuffleV = corr(RTlimA', squeeze(shuffle.distance(:,20,:))','type','spearman');
printPvalues('Distance', shuffleV, trueV);

prettyLine();
fprintf("\n");

end

function prettyLine()
    cprintf('yellow','\n -----------------------------');
end


function printPvalues(type, shuffleV, trueV)

nPermute = max([sum(shuffleV > trueV) 2]);
cprintf('green','\n%10s: p=%3.2f', type, nPermute/length(shuffleV));

end
