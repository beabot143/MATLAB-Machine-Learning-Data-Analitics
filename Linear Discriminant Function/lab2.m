%%*************************************************************************
% ELE888 LAB2: LINEAR DISCRIMINANT FUNTION
% Author: Bethany Santos
% Date: Feb 22, 2019
%**************************************************************************
% Attribute Information for IRIS data:
%    x1. sepal length in cm
%    x2. sepal width in cm
%    x3. petal length in cm
%    x4. petal width in cm

%    class label/numeric label: 
%       -- Iris Setosa / 1 
%       -- Iris Versicolour / 2
%       -- Iris Virginica / 3

clear
close all
%% Creating Data Sets
% Data Set A -> [50,2] matrix. class: Iris Setosa. features: x2, x3
% Data Set B -> [50,2] matrix. class: Iris Versicolor. features: x2, x3
% Data Set C -> [50,2] matrix. class: Iris Virginia. features: x2, x3

load ('irisdata.mat')
labels = unique(irisdata_labels);

% generate numeric labels
numericLabels = zeros(size(irisdata_features,1),1);
for i = 1:size(labels,1)
    numericLabels(find(strcmp(labels{i},irisdata_labels)),:)= i;
end
trainingSet = [irisdata_features(1:150,2:3) numericLabels(1:150,1)];

dataSetA = trainingSet((trainingSet(:,3) == 1),1:3)
dataSetB = trainingSet((trainingSet(:,3) == 2),1:3)
dataSetC = trainingSet((trainingSet(:,3) == 3),1:3)

AB30 = [dataSetA(1:15,:); dataSetB(1:15,:)]
AB70 = [dataSetA(16:50,:); dataSetB(16:50,:)]

BC30 = [dataSetB(1:15,:); dataSetC(1:15,:)]
BC70 = [dataSetB(16:50,:); dataSetC(16:50,:)]

%% 1. Compute the weight vector using the perceptron criterion
% Use eta = 0.01, a(0) = [0 0 1]
% Use AB30 as training set and AB70 as testing set.
%   i)   Augment y
%   ii)  Normalize y
%   iii) Compute Jp(a) = a(k)T*y-> is there any misclassification?
%   iv)  If YES -> find new a vector by approaching negative decent
%        If NO  -> Use a vector to determine weigth vector
%   v)  Repeat iii) - v)

% %Test Data
% eta = 0.1
% a = [1 -.5 .5]
% yNorm = [1 1 -1 -1; -1 -1 -1 -1; -2 -1 -1 -3]

eta = 0.01
a = [0 0 1]

yAug1 = [ones(1,30); transpose(AB30(:,1)); transpose(AB30(:,2))]
yNorm1 = [yAug1(:,1:15) -yAug1(:,16:30)]

% find weight vector
A1 = findWeightVec(a, yNorm1, eta)

% LDF
gx1 = LDF(A1,AB70)

%% 2. Calculate the accuracy of the LDF classifier
accuracy1 = LDFaccuracy(AB70(:,3),gx1,1,2)

%% 3. Repeat 1 but use AB70 as training set and AB30 as testing set
yAug3 = [ones(1,70); transpose(AB70(:,1)); transpose(AB70(:,2))]
yNorm3 = [yAug3(:,1:35) -yAug3(:,36:70)]

A3 = findWeightVec(a, yNorm3, eta)
gx3 = LDF(A3,AB30)
accuracy3 = LDFaccuracy(AB30(:,3),gx3,1,2)

%% 4. Repeat (1-3) for Dataset BC

% Training set = BC30; Testing set = BC70
yAug4a = [ones(1,30); transpose(BC30(:,1)); transpose(BC30(:,2))]
yNorm4a = [yAug4a(:,1:15) -yAug4a(:,16:30)]
A4a = findWeightVec(a, yNorm4a, eta)
gx4a = LDF(A4a,BC70)
accuracy4a = LDFaccuracy(BC70(:,3),gx4a,2,3)

% Training set = BC70; Testing set = BC30
yAug4b = [ones(1,70); transpose(BC70(:,1)); transpose(BC70(:,2))]
yNorm4b = [yAug4b(:,1:35) -yAug4b(:,36:70)]
A4b = findWeightVec(a, yNorm4b, eta)
gx4b = LDF(A4b,BC30)
accuracy4b = LDFaccuracy(BC30(:,3),gx4b,2,3)

%% 5. Plot
% r - setosa; b - versicolour; g - virginia
close ALL;

subplot(2,2,1);
scatter(AB30(1:15,1), AB30(1:15,2),12, 'filled','r');
hold;
scatter(AB30(16:30,1), AB30(16:30,2),12, 'filled','b');
plotIters(A1)
grid minor;
xlabel('petal length in cm');
ylabel('sepal width in cm');
title('Data Set AB 30 Samples')
legend ('Iris-Setosa','Iris-Versicolour')
axis([ -5 10 -5 10]);


subplot(2,2,2);
scatter(AB70(1:35,1), AB70(1:35,2),12, 'filled','r');
hold;
scatter(AB70(36:70,1), AB70(36:70,2),12, 'filled','b');
plotIters(A3)
grid minor;
xlabel('petal length in cm');
ylabel('sepal width in cm');
title('Data Set AB 70 Samples')
legend ('Iris-Setosa','Iris-Versicolour')
axis([ -5 10 -5 10]);

subplot(2,2,3);
scatter(BC30(1:15,1), BC30(1:15,2),12, 'filled','b');
hold;
scatter(BC30(16:30,1), BC30(16:30,2),12, 'filled','g');
plotIters(A4a)
grid minor;
xlabel('petal length in cm');
ylabel('sepal width in cm');
title('Data Set BC 30 Samples')
legend ('Iris-Versicolour','Iris-Virginia')
axis([ -5 10 -5 10]);

subplot(2,2,4);
scatter(BC70(1:35,1), BC70(1:35,2),12, 'filled','b');
hold;
scatter(BC70(36:70,1), BC70(36:70,2),12, 'filled','g');
plotIters(A4b)
grid minor;
xlabel('petal length in cm');
ylabel('sepal width in cm');
title('Data Set BC 70 Samples');
legend ('Iris-Versicolour','Iris-Virginia')
axis([ -5 10 -5 10]);

suptitle('IrisData Feature Space')

%% Summary of results
% Training set, Weight vector, accuracy

summary = cell(5,4)
summary(1,:) = {'Training Set', 'Solution Vector a','# of iteration', 'LDF accuracy'}
summary(2,:) = {'AB30', mat2str(A1(length(A1(:,1)),:)),length(A1(:,1)), accuracy1}
summary(3,:) = {'AB70', mat2str(A3(length(A3(:,1)),:)),length(A3(:,1)), accuracy3}
summary(4,:) = {'BC30', mat2str(A4a(length(A4a(:,1)),:)),length(A4a(:,1)), accuracy4a}
summary(5,:) = {'BC70', mat2str(A4b(length(A4b(:,1)),:)),length(A4b(:,1)), accuracy4b}




