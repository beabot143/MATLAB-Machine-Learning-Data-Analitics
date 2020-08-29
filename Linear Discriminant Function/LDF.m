function [output] = LDF(A,dataSet)
% outputs a vector containing result from the LDF classifier 
% inputs: A -> solution vector where [w0 w1 w2]
%         dataSet -> vector containing data set to be tested. col1 as x1, 
%                    col2 as x2
output = A(length(A(:,1)),3)*dataSet(:,2) + A(length(A(:,1)),2)*dataSet(:,1) + A(length(A(:,1)),1)
end

