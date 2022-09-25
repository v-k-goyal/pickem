%tag = '6a'; p = linspace(0.68,0.72,6);
%tag = '6b'; p = [0.51, 0.52, 0.53, 0.7, 0.71, 0.72];
%tag = '6c'; p = linspace(0.6,0.8,6);
%tag = '6d'; p = linspace(0.5,0.5,6);
%tag = '7a'; p = linspace(0.6,0.8,7);
%tag = '8a'; p = linspace(0.6,0.8,8);
%tag = '8b'; p = linspace(0.74,0.747,8);
%tag = '8c'; p = linspace(0.55,0.97,8);
%tag = '8d'; p = linspace(0.55,0.69,8);
%tag = '8e'; p = linspace(0.85,0.99,8);
tag = '8f'; p = linspace(0.79,0.797,8);

n = length( p );
tstart = tic;

%% Try all w vectors
[ps_w,strategies_w,rand_PMF_w,E_diff_w] = allOptimalWeightsAgainstChalk( p );

figure;
histogram( E_diff_w, 200 );
set( gca, 'FontSize', 16 );
xlabel( 'E[point differential]' );
ylabel( 'Counts' );
title( 'Histogram over all w' );
print( [tag,'_hist_w.eps'], '-depsc' );

figure;
plot( 1:length(ps_w), ps_w, '-o' );
set( gca, 'FontSize', 16 );
xlabel( 'Deficit d' );
ylabel( 'P[success]' );
title( 'Optimization over w' );
print( [tag,'_psuccess_w.eps'], '-depsc' );

plotPMFs( rand_PMF_w, strategies_w, n );
set( gcf, 'Position', [50, 50, 450, 1150] );
print( [tag,'_pmfs_w.eps'], '-depsc' );

%% Try all v vectors
[ps_v,strategies_v,rand_PMF_v,E_diff_v] = allOptimalPicksAgainstChalk( p );

figure;
histogram( E_diff_v, 200 );
set( gca, 'FontSize', 16 );
xlabel( 'E[point differential]' );
ylabel( 'Counts' );
title( 'Histogram over all v' );
print( [tag,'_hist_v.eps'], '-depsc' );

figure;
plot( 1:length(ps_v), ps_v, '-o' );
set( gca, 'FontSize', 16 );
xlabel( 'Deficit d' );
ylabel( 'P[success]' );
title( 'Optimization over v' );
print( [tag,'_psuccess_v.eps'], '-depsc' );

plotPMFs( rand_PMF_v, strategies_v, n );
set( gcf, 'Position', [50, 50, 450, 1150] );
print( [tag,'_pmfs_v.eps'], '-depsc' );

%% Try all (w,v) pairs
[ps,strategies,rand_PMF,E_diff] = allOptimalAgainstChalk( p );

figure;
histogram( E_diff, 200 );
set( gca, 'FontSize', 16 );
xlabel( 'E[point differential]' );
ylabel( 'Counts' );
title( 'Histogram over all (w,v)' );
print( [tag,'_hist.eps'], '-depsc' );

figure;
plot( 1:length(ps), ps, '-o' );
set( gca, 'FontSize', 16 );
xlabel( 'Deficit d' );
ylabel( 'P[success]' );
title( 'Optimization over (w,v)' );
print( [tag,'_psuccess.eps'], '-depsc' );

plotPMFs( rand_PMF, strategies, n );
set( gcf, 'Position', [50, 50, 450, 1150] );
print( [tag,'_pmfs.eps'], '-depsc' );

figure;
plot( 1:length(ps), ps, 'b.-', 'MarkerSize', 15, 'DisplayName', 'full search' );
hold on;
plot( 1:length(ps_w), ps_w, 'ks:', 'MarkerSize', 8, 'DisplayName', 'vary w' );
plot( 1:length(ps_v), ps_v, 'kv:', 'MarkerSize', 8, 'DisplayName', 'vary v' );
set( gca, 'FontSize', 16 );
xlabel( 'Deficit d' );
ylabel( 'P[success]' );
legend;
print( [tag,'_psuccess_comparison.eps'], '-depsc' );

telapsed = toc(tstart)
save( [tag,'_computations.mat'] );
