function [output] = findWeightVec(a, yNorm, eta)
% Determines the constants needed to determine the weight vector for an
% LDF. Max iterations = 300. Plot feature space and boundary  
% Outputs a vector where output = [w0 w1 w2]
% Input: a -> initial vector a0
%        yNorm -> normalized Y vector
%        eta -> constant value of eta

Aarr = a
for i = 1:300
    ay = a*yNorm
    temp = [transpose(ay(:)<0);yNorm]
    if (find(temp(1,:))) 
        ySum = [sum(temp(2,temp(1,:)==1))  sum(temp(3,temp(1,:)==1)) sum(temp(4,temp(1,:)==1))]
        a = a + eta*ySum
        Aarr (i,:) = a
    else
        output = Aarr
        break
    end
end
output = Aarr
end

