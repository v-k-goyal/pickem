function pcomeback = allProbsAchieveDiff( p, minDiff )
%allProbsAchieveDiff( p, minDiff )
%
%  Return probability of achieving at least minDiff advantage over chalk.
n = length( p );  % number of games
pmfs = allDiffWithChalkPMFs( p );
maxPoints = n*(n+1)/2;
pcomeback = sum( pmfs(:,(maxPoints+1+minDiff):(2*maxPoints+1)), 2 )';