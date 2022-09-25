function points = outcomePoints( w, v )
%outcomePoints( w, v )  Points scored for all outcomes
%   For input picks v and weight vector w of length n, return 2^n points scored
%   in a canonical order.

if ~exist('v','var')
    v = ones(1,length(w));  % By default, chalk
end
n = length( w );
k = 2^n;
points = zeros(1,k);
for i = 1:k
    z = bitget( i-1, 1:n );
    points(i) = sum( w .* (v == z) );
end