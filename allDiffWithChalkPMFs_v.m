function pmfs = allDiffWithChalkPMFs_v( p )

% Compared with allDiffWithChalkPMFs, this only varies the picks v.
% (Weights are chalk.)

n = length( p );  % number of games
m = 2^n;          % number of possibilities for the picks vector v

maxPoints = n*(n+1)/2;
pmfs = zeros(m,2*maxPoints+1);
outcome_probs = outcomeProbabilities( p );
pointsChalk = outcomePoints( 1:n, ones(1,n) );
wChalk = 1:n;

for j = 1:m
    pmf = diffWithChalkPMF( p, wChalk, bitget( j-1, 1:n ), outcome_probs, pointsChalk );
    pmfs(j,:) = pmf;
end