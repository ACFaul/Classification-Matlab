load fisheriris;
% meas contains the first species in rows 1 to 50, the second species
% in rows 51 to 100, and the third sepcies in rows 101 to 150, while 
% the columns give the measurements of sepal length, sepal width, 
% petal length and petal width in this order.
% Extract two species and two attributes.
m = meas(1:100,1:2);
s = species(1:100);
% Fit a linear separation line using the Support Vector Machine.
SVMModel = fitcsvm(m,s);
% Retrieve support vectors.
sv = SVMModel.SupportVectors;
% Retrieve classes of support vectors.
sl = SVMModel.SupportVectorLabels;
% Retrieve Langrange multipliers.
a = SVMModel.Alpha;
% Calculate vector of weights as linear combination of support vectors
% with the coefficients being the Langange multipliers times the class
% labels.
w = (sl.*a)'*sv;
% Retrieve bias.
b = SVMModel.Bias;

figure
% Scatter plot of the data.
gscatter(m(:,1),m(:,2),s,'rg','os');
hold on
% Mark support vectors.
plot(sv(:,1),sv(:,2),'kx')
% Plot separation line.
h = plotpc(w,b);
set(h, 'Color','k');
% Label graph.
legend('Setosa','Versicolor',...
    'support vector','separation line','Location','northeast')
xlabel('Sepal length');
ylabel('Sepal width');
axis([4 7.3 1.5 4.5]);
hold off