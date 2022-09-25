function W = indexes_to_strategies_w( n, indexes )

% Compared to indexes_to_strategies, here we only vary weights (v is chalk)

W_mat = perms(n:-1:1); % each row is a possible w
W = W_mat(indexes,:);