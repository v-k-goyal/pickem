function probs = outcomeProbabilities( p )
%outcomeProbabilities( p )  Probabilities of all outcomes
%   For input win probability vector p of length n, return 2^n outcome
%   in a canonical order.
n = length(p);
k = 2^n;
probs = zeros(1,k);
for i = 1:k
    z = bitget( i-1, 1:n );
    probs(i) = prod( p.^z .* (1-p).^(1-z) );
end