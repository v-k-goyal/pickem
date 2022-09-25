function pmfs = allDiffWithChalkPMFs( p )

n = length( p );  % number of games
k = 2^n;          % number of possibilities for the picks vector v
m = factorial(n); % number of possibilities for the weights vector w
W_mat = perms(n:-1:1); % each row is a possible w

maxPoints = n*(n+1)/2;
pmfs = zeros(k*m,2*maxPoints+1);
outcome_probs = outcomeProbabilities( p );
pointsChalk = outcomePoints( 1:n, ones(1,n) );

r = 1;
for i = 1:k
    for j = 1:m
        pmf = diffWithChalkPMF( p, W_mat(j,:), bitget( i-1, 1:n ), outcome_probs, pointsChalk );
        pmfs(r,:) = pmf;
        r = r+1;
    end
end