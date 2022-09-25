function plotPMFs( rand_PMF, strategies, n, d_subplots )

maxPoints = n*(n+1)/2;
max_d = length(strategies);
if ~exist('d_subplots','var')
    d_subplots = max_d;
end

figure;
subplot(d_subplots+1,1,1);
bar( -maxPoints:maxPoints, rand_PMF );
a = axis; a(1:2)=[-(max_d+0.9),(max_d+0.9)]; axis( a );
text( 0.92*max_d, 0.6*a(4), 'uniform', 'HorizontalAlignment', 'right' );
for i = 1:d_subplots
    subplot(d_subplots+1,1,i+1);
    bar( -maxPoints:maxPoints, strategies(i).diffPMF(1,:) );
    a = axis; a(1:2)=[-(max_d+0.9),(max_d+0.9)]; axis( a );
    text( 0.92*max_d, 0.6*a(4), ['d = ',num2str(i)], 'HorizontalAlignment', 'right' );
    hold on;
    bar( i, strategies(i).diffPMF(1,maxPoints+1+i), 'r' );
end
xlabel('Score differential above chalk' );