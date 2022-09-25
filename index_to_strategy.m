function [w,v] = index_to_strategy( n, index )

%k = 2^n;          % number of possibilities for the picks vector v
m = factorial(n); % number of possibilities for the weights vector w
W_mat = perms(n:-1:1); % each row is a possible w

j = mod(index-1,m) + 1;
i = (index-j)/m + 1;
w = W_mat(j,:);
v = bitget( i-1, 1:n );