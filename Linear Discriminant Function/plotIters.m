function [output] = plotIters(A)
iteration = length(A(:,1))
for i = 1:iteration
    x = -50:0.1:50
    y = -(A(i,2)/A(i,3))*x-(A(i,1)/A(i,3))
    plot (x,y)
end

