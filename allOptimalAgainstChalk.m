function [psuccess,strategies,rand_diff_PMF,E_diff] = allOptimalAgainstChalk( p )
%[psuccess,strategies,rand_diff_PMF,E_diff] = allOptimalAgainstChalk( p )
%  Varying w over all permutations and v over all binary vectors, compute
%  optimal strategies.
% 
%  maxPoints = n*(n+1)/2 is the largest deficit that can be overcome.
%  Outputs:
%    psuccess (1-by-maxPoints): entry d is the best probability of scoring
%                 at least d more points than chalk
%    strategies (max_d-element struct): for each value of d, return the
%                 optimizing w, optimizing v, resulting difference PMF
%                 diffPMF, and its expected E_diff. (Each could have
%                 multiple rows for ties.)
%    rand_diff_PMF: the difference PMF for choosing w and v uniformly at random
%    E_diff (n!2^n-by-1): expected differences for each possible (w,v) pair

% Running optimalStrategiesAgainstChalk is the expensive step, so this
% should be done just once and then used for all of the deficit values.

epsilon = 1e-7; % tolerance for floating-point probability equality

n = length( p );
maxPoints = n*(n+1)/2;
num_w = factorial(n);
num_v = 2^n;
max_d = maxPoints; % maximum difference from varying w and v

% The expensive step of finding the PMF of the point differential for each
% of the num_w*num_v possible plays:
diffPMFs = allDiffWithChalkPMFs( p ); % num_w*num_v by 2*maxPoints+1 matrix

diffPoints = -maxPoints:maxPoints;
% Expected values of score differentials:
E_diff = sum( diffPMFs .* kron( ones(num_w*num_v,1), diffPoints ), 2 );

% Calculations for (w,v) chosen uniformly at random over all possibilities:
rand_diff_PMF = mean( diffPMFs );
%E_diff_rand_w = sum( rand_w_diff_PMF .* diffPoints );

% Make a num_w*num_v by max_d matrix so that (i,j) element is the
% probability of the i-indexed (w,v) pair achieving point differential j
ps = zeros(num_w*num_v,max_d);
for j = 1:max_d
    ps(:,j) = sum( diffPMFs(:,(maxPoints+1+j):(2*maxPoints+1)), 2 )';
end
psuccess = max( ps ); % each column is for different point differential
for j = 1:max_d
    indexes = find( abs(ps(:,j) - psuccess(j)) <= epsilon );
    [W,V] = indexes_to_strategies( n, indexes );
    strategies(j).w = W;
    strategies(j).v = V;
    strategies(j).diffPMF = diffPMFs(indexes,:);
    strategies(j).E_diff = E_diff(indexes);
end