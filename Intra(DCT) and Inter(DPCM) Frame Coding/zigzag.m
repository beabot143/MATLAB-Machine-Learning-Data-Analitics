function [ind] = zigzag(matrix)
%iterate through the input 2D matrix in a zigzag fashion
%outputs the ordered index iteration

M = matrix;                      %# input matrix

ind = reshape(1:numel(M), size(M));         %# indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );     %# get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );  %# reverse order of odd columns
ind(ind==0) = [];       


end

