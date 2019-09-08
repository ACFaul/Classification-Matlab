load fisheriris;
% meas contains the first species in rows 1 to 50, the second species
% in rows 51 to 100, and the third sepcies in rows 101 to 150, while 
% the columns give the measurements of sepal length, sepal width, 
% petal length and petal width in this order.
% Extract two species and two attributes.
m = meas(1:100,1:2)';
s = species(1:100);
% Plot data.
figure;
gscatter(m(1,:), m(2,:), s,'rg','os');
hold on;
% Generate binary true/false class labels. Frist 50 samples belong to 
% class zero, next 50 to class 1
s = [zeros(1,50) ones(1,50)];
% Generate random permutation matrix, so that the samples arrive in 
% a random order
P = eye(100);
% Create a random stream.
st = RandStream('mt19937ar','Seed',1);
idx = randperm(st,100);
P = P(idx, :);
% Permute data.
m = m*P;
s = s*P;
% Fit a linear separation line using the Perceptron
PerceptronModel = perceptron;
PerceptronModel = configure(PerceptronModel,m(:,1),s(1));
% Use all samples for training.
PerceptronModel.divideFcn = 'dividetrain';
% Set learning rate to 1.
PerceptronModel.trainParam.lr = 1;
% Specify maximum number of epochs.
PerceptronModel.trainParam.epochs = 1000;
% Train the perceptron.
PerceptronModel = train(PerceptronModel,m,s);
% Plot separation line.
w = PerceptronModel.iw{1,1};
b = PerceptronModel.b{1};
h = plotpc(w,b);
set(h, 'Color','k');
% Label graph.
legend('Setosa','Versicolor','Location','Northeast')
xlabel('Sepal length');
ylabel('Sepal width');
axis([4 7.3 1.5 4.5]);

