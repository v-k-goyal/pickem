function [psuccess,strategies,rand_w_diff_PMF,E_diff] = allOptimalWeightsAgainstChalk( p )
%[psuccess,strategies,rand_w_diff_PMF,E_diff] = allOptimalWeightsAgainstChalk( p )
%  Varying w over all permutations, compute optimal strategies.
%  (Picks are chalk for both players.)
% 
%  max_d = floor(n^2/4) is the largest deficit that can be overcome.
%  Outputs:
%    psuccess (1-by-max_d): entry d is the best probability of scoring
%                 at least d more points than chalk
%    strategies (max_d-element struct): for each value of d, return the
%                 optimizing w, resulting difference PMF diffPMF, and its
%                 expected E_diff. (Each could have multiple rows for ties.)
%    rand_w_diff_PMF: the difference PMF for choosing w uniformly at random
%    E_diff (n!-by-1): expected differences for each possible w

% This function exists (rather than using optimalWeightsAgainstChalk)
% because the expensive step is to compute allDiffWithChalkPMFS_w, so this
% should be done just once and then used for all of the deficit values.

epsilon = 1e-7; % tolerance for floating-point probability equality

n = length( p );
maxPoints = n*(n+1)/2;
num_w = factorial(n);
max_d = floor(n^2/4); % maximum difference from varying w

% The expensive step of finding the PMF of the point differential for each
% of the num_w possible weights (picks v are chalk):
diffPMFs = allDiffWithChalkPMFs_w( p ); % num_w by 2*maxPoints+1 matrix

diffPoints = -maxPoints:maxPoints;
% Expected values of score differentials:
E_diff = sum( diffPMFs .* kron( ones(num_w,1), diffPoints ), 2 );

% Calculations for w chosen uniformly at random over num_w permutations:
rand_w_diff_PMF = mean( diffPMFs );
%E_diff_rand_w = sum( rand_w_diff_PMF .* diffPoints );

% Make a num_w by max_d matrix so that (i,j) element is the probability of
% the i-indexed w vector achieving point differential j
ps = zeros(num_w,max_d);
for j = 1:max_d
    ps(:,j) = sum( diffPMFs(:,(maxPoints+1+j):(2*maxPoints+1)), 2 )';
end
psuccess = max( ps ); % each column is for different point differential
for j = 1:max_d
    indexes = find( abs(ps(:,j) - psuccess(j)) <= epsilon );
    strategies(j).w = indexes_to_strategies_w( n, indexes );
    strategies(j).diffPMF = diffPMFs(indexes,:);
    strategies(j).E_diff = E_diff(indexes);
end