function [psuccess,best_w,best_v] = optimalStrategiesAgainstChalk( p, minDiff )
%[psuccess,best_w,best_v] = optimalStrategiesAgainstChalk( p, minDiff )
%   Return arrays of (w,v) pairs that achieve the best probability of
%   achieving at least minDiff against chalk.

epsilon = 1e-6; % tolerance for probability equality

n = length( p );
pcomeback = allProbsAchieveDiff( p, minDiff );
psuccess = max( pcomeback );
if psuccess > 0
    indexes = find( abs(pcomeback - psuccess) <= epsilon );
    [best_w,best_v] = indexes_to_strategies( n, indexes );
else
    best_w = [];
    best_v = [];
end