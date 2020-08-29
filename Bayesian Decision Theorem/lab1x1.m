%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE 888/ EE 8209: LAB 1: Bayesian Decision Theory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [posteriors_x,g_x]=lab1x1(x,Training_Data)
% x = individual sample to be tested (to identify its probable class label)
% featureOfInterest = index of relevant feature (column) in Training_Data 
% Train_Data = Matrix containing the training samples and numeric class labels
% posterior_x  = Posterior probabilities
% g_x = value of the discriminant function

D=Training_Data;

% D is MxN (M samples, N columns = N-1 features + 1 label)
[M,N]=size(D);    
 
f=D(:,1);  % feature samples
la=D(:,N); % class labels

%% %%%%Prior Probabilities%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hint: use the commands "find" and "length"

disp('Prior probabilities:');
Pr1 = length(find(la(:)==1))/length(la)
Pr2 = length(find(la(:)==2))/length(la)

%% %%%%%Class-conditional probabilities%%%%%%%%%%%%%%%%%%%%%%%

disp('Mean & Std for class 1 & 2');

% mean of the class conditional density p(x1/w1)
m11 = mean(f(find(la(:)==1)))  

% Standard deviation of the class conditional density p(x1/w1)
std11 = std(f(find(la(:)==1)))

% mean of the class conditional density p(x1/w2)
m12 = mean(f(find(la(:)==2)))  

% Standard deviation of the class conditional density p(x1/w2)
std12 = std(f(find(la(:)==2)))

disp(['Conditional probabilities for x=' num2str(x)]);
% use the above mean, std and the test feature to calculate p(x/w1)
cp11 = (1/sqrt(2*pi*std11))*exp(-0.5*((x-m11)/std11)^2)

% use the above mean, std and the test feature to calculate p(x/w2)
cp12 = (1/sqrt(2*pi*std11))*exp(-0.5*((x-m12)/std12)^2)

%% %%%%%%Compute the posterior probabilities%%%%%%%%%%%%%%%%%%%%

disp('Posterior prob. for the test feature');

% p(w1/x) for the given test feature value
pos11 = cp11*Pr1 

% p(w2/x) for the given test feature value
pos12 = cp12*Pr2 
posteriors_x = [pos11, pos12]

%% %%%%%%Discriminant function for min error rate classifier%%%

disp('Discriminant function for the test feature');

% compute the g(x) for min err rate classifier.
g_x = pos11 - pos12


