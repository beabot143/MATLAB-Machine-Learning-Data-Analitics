%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE725 Lab2: myEntropy(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Y] = myEntropy(X)

% Y = vector of probabilities corresponding to X
% X = Input sequence

% Get list of unique symbols from input sequences
symbols = unique(X(:));

% Initialize vector of probabilities
prob = zeros(size(symbols));

% Populate probability vector with symbol count
for i = 1:length(symbols)
    prob(i) = sum(X(:)==symbols(i));
end

% Display all symbols found [Test]
%disp('# of symbols')
%disp(symbols)

% Get probability by divide count with total number of entries
Y = 1/prod(size(X)).*prob;
