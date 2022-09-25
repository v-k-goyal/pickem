function [W,V] = indexes_to_strategies( n, indexes )

%k = 2^n;          % number of possibilities for the picks vector v
m = factorial(n); % number of possibilities for the weights vector w
W_mat = perms(n:-1:1); % each row is a possible w

W = zeros(length(indexes),n);
V = zeros(length(indexes),n);
for q = 1:length(indexes)
    j = mod(indexes(q)-1,m) + 1;
    i = (indexes(q)-j)/m + 1;
    W(q,:) = W_mat(j,:);
    V(q,:) = bitget( i-1, 1:n );
end