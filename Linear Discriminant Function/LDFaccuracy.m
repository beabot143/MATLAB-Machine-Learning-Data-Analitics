function [output] = LDFaccuracy(actual,gx,w1,w2)
% calculates and outputs the accuracy of the LDF classifier
% Inputs: actual -> vector containing correct results from the test set
%         gx     -> vector output from the LDFclassifier function
%         w1     -> numeric label for class 1
%         w2     -> numeric label for class2
accuracy = 0
for i = 1:length(gx)
    if (((actual(i,1)==w1) && (gx(i,1)>0)) || ((actual(i,1)==w2) && (gx(i,1)<0)))
        accuracy = accuracy + 1
    end
end
output = (accuracy/length(gx))*100

end

