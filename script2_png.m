tag = '8d';
load( [tag,'_computations.mat'] );

plotPMFs( rand_PMF_v, strategies_v, n, 18 );
set( gcf, 'Position', [50, 50, 450, 1150] );
print( [tag,'_pmfs_v_18.png'], '-dpng' );

plotPMFs( rand_PMF,   strategies,   n, 18 );
set( gcf, 'Position', [50, 50, 450, 1150] );
print( [tag,'_pmfs_18.png'], '-dpng' );
