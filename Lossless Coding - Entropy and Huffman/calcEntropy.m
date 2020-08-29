function [output] = calcEntropy(prob)
% Calculates Entropy of a sequence
%   X - data sequence
%   prob - output of myEntropy() function
entropy = 0
for i = 1:length(prob)
entropy = entropy -(prob(i)*log2(prob(i)))
end
output = entropy

