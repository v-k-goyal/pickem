function [psuccess,best_w] = optimalWeightsAgainstChalk( p, minDiff )
%[psuccess,best_w] = optimalWeightsAgainstChalk( p, minDiff )
%   Return array of w vectors that achieve the best probability of
%   achieving at least minDiff against chalk weight.
%   (Picks are chalk for both players.)

epsilon = 1e-6; % tolerance for probability equality

n = length( p );
pcomeback = allProbsAchieveDiff_w( p, minDiff );
psuccess = max( pcomeback );
if psuccess > 0
    indexes = find( abs(pcomeback - psuccess) <= epsilon );
    best_w = indexes_to_strategies_w( n, indexes );
else
    best_w = [];
end