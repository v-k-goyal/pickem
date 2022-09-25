function E_X = allExpectedValues( p )

n = length( p );  % number of games
k = 2^n;          % number of possibilities for the picks vector v
m = factorial(n); % number of possibilities for the weights vector w
W_mat = perms(n:-1:1); % each row is a possible w

probs = outcomeProbabilities( p );

E_X = zeros(k,m);
for i = 1:k
    for j = 1:m
        points = outcomePoints( W_mat(j,:), bitget( i-1, 1:n ) );
        E_X(i,j) = sum( probs .* points );
    end
end