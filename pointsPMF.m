function pmf = pointsPMF( p, w, v )
%pointsPMF( p, v, w )  PMF of points scored
%   For game probablities p, input picks v, and weight vector w,
%   return the PMF for the points scored.

% Unchecked error condition: inputs of different lengths
% Used only for finding marginal PMFs (not PMFs of differences).

if ~exist('v','var')
    v = ones(1,length(w));  % By default, chalk
end
n = length( w );

probs = outcomeProbabilities( p );
points = outcomePoints( w, v );

maxPoints = n*(n+1)/2;
pmf = zeros( 1, maxPoints+1 );

for x = 0:maxPoints
    indexes = find( points == x );
    pmf(x+1) = sum( probs(indexes) );
end