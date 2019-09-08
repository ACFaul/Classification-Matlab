load fisheriris;
% meas contains the first species in rows 1 to 50, the second species
% in rows 51 to 100, and the third sepcies in rows 101 to 150, while 
% the columns give the measurements of sepal length, sepal width, 
% petal length and petal width in this order.
% Extract two species and two attributes.
m = meas(1:100,1:2);
s = species(1:100);
% Calculate the mean for each species.
mean0 = mean( m(1:50,:));
mean1 = mean( m(51:100,:));
% Calculate the covariance for each species.
cov0 = cov( m(1:50,:));
cov1 = cov( m(51:100,:));
% Find the direction of the projection line.
w = ((cov0 + cov1) \ (mean0 - mean1)')';
% Find vector perpendicular to direction.
perp = transpose(null(w));
% Find midpoint between means.
mid = mean0 + 0.5 * (mean1 - mean0);
% Plot data.
figure;
h(1:2) = gscatter(m(:,1), m(:,2), s,'rg','os');
hold on;
% Plot means.
h(3) = scatter(mean0(1),mean0(2),[],'r','filled');
h(4) = scatter(mean1(1),mean1(2),[],'g','filled','s');
% Plot projection line.
temp1 = mid + 0.2 * w;
temp2 = mid - 0.2 * w;
plot([temp1(1) temp2(1)], [temp1(2) temp2(2)], 'k');
% Plot separation line.
temp1 = mid + 1.5 * perp;
temp2 = mid - 2.5 * perp;
plot([temp1(1) temp2(1)], [temp1(2) temp2(2)], 'k');
% Label graph.
legend(h,{'Setosa','Versicolor','Setosa mean','Versicolor mean'},...
    'Location','Northeast')
xlabel('Sepal length');
ylabel('Sepal width');
axis([4 7.3 1.5 4.5]);