%tag = '8f';
%tag = '8c';
tag = '8a';
load( [tag,'_computations.mat'] );

figure;
plot( 1:length(ps), ps, 'b.-', 'MarkerSize', 15, 'DisplayName', 'full search' );
hold on;
plot( 1:length(ps_w), ps_w, 'ks:', 'MarkerSize', 8, 'DisplayName', 'vary w' );
plot( 1:length(ps_v), ps_v, 'kv:', 'MarkerSize', 8, 'DisplayName', 'vary v' );
set( gca, 'FontSize', 16 );
set( gca, 'YScale', 'log' );
xlabel( 'Deficit d' );
ylabel( 'P[success]' );
legend;
print( [tag,'_psuccess_comparison_log.eps'], '-depsc' );