function [psuccess,strategies,rand_v_diff_PMF,E_diff] = allOptimalPicksAgainstChalk( p )
%[psuccess,strategies,rand_v_diff_PMF,E_diff] = allOptimalPicksAgainstChalk( p )
%  Varying v over all binary vectors, compute optimal strategies.
%  (Weights are chalk for both players.)
% 
%  maxPoints = n*(n+1)/2 is the largest deficit that can be overcome.
%  Outputs:
%    psuccess (1-by-maxPoints): entry d is the best probability of scoring
%                 at least d more points than chalk
%    strategies (maxPoints-element struct): for each value of d, return the
%                 optimizing v, resulting difference PMF diffPMF, and its
%                 expected E_diff. (Each could have multiple rows for ties.)
%    rand_v_diff_PMF: the difference PMF for choosing v uniformly at random
%    E_diff (2^n-by-1): expected differences for each possible v

% Running optimalPicksAgainstChalk is the expensive step, so this should
% be done just once and then used for all of the deficit values.

epsilon = 1e-7; % tolerance for floating-point probability equality

n = length( p );
maxPoints = n*(n+1)/2;
num_v = 2^n;
max_d = maxPoints; % maximum difference from varying v

% The expensive step of finding the PMF of the point differential for each
% of the num_v possible picks (weights w are chalk):
diffPMFs = allDiffWithChalkPMFs_v( p ); % num_v by 2*maxPoints+1 matrix

diffPoints = -maxPoints:maxPoints;
% Expected values of score differentials:
E_diff = sum( diffPMFs .* kron( ones(num_v,1), diffPoints ), 2 );

% Calculations for v chosen uniformly at random over num_v permutations:
rand_v_diff_PMF = mean( diffPMFs );
%E_diff_rand_w = sum( rand_w_diff_PMF .* diffPoints );

% Make a num_v by max_d matrix so that (i,j) element is the probability
% of the i-indexed v vector achieving point differential j
ps = zeros(num_v,max_d);
for j = 1:max_d
    ps(:,j) = sum( diffPMFs(:,(maxPoints+1+j):(2*maxPoints+1)), 2 )';
end
psuccess = max( ps ); % each column is for different point differential
for j = 1:max_d
    indexes = find( abs(ps(:,j) - psuccess(j)) <= epsilon );
    strategies(j).v = indexes_to_strategies_v( n, indexes );
    strategies(j).diffPMF = diffPMFs(indexes,:);
    strategies(j).E_diff = E_diff(indexes);
end