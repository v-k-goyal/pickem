function V = indexes_to_strategies_v( n, indexes )

V = zeros(length(indexes),n);
for q = 1:length(indexes)
    V(q,:) = bitget( indexes(q)-1, 1:n );
end