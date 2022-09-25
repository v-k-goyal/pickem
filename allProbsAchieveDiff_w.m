function pcomeback = allProbsAchieveDiff_w( p, minDiff )
%allProbsAchieveDiff_w( p, minDiff )
%
%  Return probability of achieving at least minDiff advantage over chalk.
%  Vary over all w vectors.  (Picks v are chalk.)
n = length( p );  % number of games
pmfs = allDiffWithChalkPMFs_w( p );
maxPoints = n*(n+1)/2;
pcomeback = sum( pmfs(:,(maxPoints+1+minDiff):(2*maxPoints+1)), 2 )';