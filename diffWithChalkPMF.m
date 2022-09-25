function [pmf,pmf_domain] = diffWithChalkPMF( p, w, v, probs, pointsChalk )
%diffWithChalkPMF( p, v, w )  PMF of points beating chalk
%   For game probablities p, input picks v, and weight vector w,
%   return the PMF for the points scored in excess of chalk.

% Unchecked error condition: inputs of different lengths

n = length( p );
% if ~exist('probs','var')
%     probs = outcomeProbabilities( p );
% end
% if ~exist('pointsChalk','var')
%     pointsChalk = outcomePoints( 1:n, ones(1,n) );
% end

% if ~exist('v','var')
%     v = vchalk;  % By default, chalk
% end
% if ~exist('w','var')
%     w = wchalk;  % By default, chalk
% end

points = outcomePoints( w, v );
pointsExcess = points - pointsChalk;

maxPoints = n*(n+1)/2;
pmf = zeros( 1, 2*maxPoints+1 );
pmf_domain = -maxPoints:maxPoints;

for i = 1:length(pmf_domain)
    indexes = find( pointsExcess == pmf_domain(i) );
    pmf(i) = sum( probs(indexes) );
end