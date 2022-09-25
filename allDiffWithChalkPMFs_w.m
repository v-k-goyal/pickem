function pmfs = allDiffWithChalkPMFs_w( p )

% Compared with allDiffWithChalkPMFs, this only varies the weight w.
% (Picks are chalk.)

n = length( p );  % number of games
m = factorial(n); % number of possibilities for the weights vector w
W_mat = perms(n:-1:1); % each row is a possible w

maxPoints = n*(n+1)/2;
pmfs = zeros(m,2*maxPoints+1);
outcome_probs = outcomeProbabilities( p );
pointsChalk = outcomePoints( 1:n, ones(1,n) );
vChalk = ones(1,n);

for j = 1:m
    pmf = diffWithChalkPMF( p, W_mat(j,:), vChalk, outcome_probs, pointsChalk );
    pmfs(j,:) = pmf;
end