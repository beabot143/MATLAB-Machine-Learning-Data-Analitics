function [output] = myEntropy(X)
% Calculates relative occirense of different symbols within a given input
% sequence (X). the function returns a vector of probabilites corresponding
% to the elements in X

% test sequence: 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM'

symbols = unique(X)
numSymbols = numel(X)
numUniqueSymbols = numel(symbols)
entropy = 0
% arr(numUniqueSymbols)
for i = 1:numUniqueSymbols
    symbol = symbols(i);
    probability = (sum(X(:)==symbol))/numSymbols;
    arr(i) = probability;
end
output = arr

