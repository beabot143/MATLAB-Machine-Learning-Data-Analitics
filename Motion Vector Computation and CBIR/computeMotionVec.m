function [dx,dy] = computeMotionVec(framePrev,frameCurr,p,q,k)
% Performs a sequential search in the colocated region of the first frame
% with radius of k=7.
%       (p,q) -> co-located block position
%        k    -> search radius
%     (dx,dy) -> hold the values of the offset (in terms of pixel location)
%   framePrev -> First frame (colocation), dimension 48-by-48
%   frameCurr -> Second frame (target), dimension 16-by-16
 
mn = prod(size(frameCurr));
MV_i = 1;

for i = -k:k
    for j = -k:k
        if (p+i+15> size(frameCurr,1) || p+i < 1 || q+j < 1 ||  q+j+15>size(frameCurr,2))
            difference = 99999;
        else
            difference = abs(frameCurr(p:p+15, q:q+15)-framePrev(p+i:p+i+15,q+j:q+j+15));
              MAD = sum(difference(:))/mn;
            MAD_data(MV_i,:) = [i j MAD];
            MV_i = MV_i + 1;
        end
      
    end
end

MV_smallest = MAD_data(find(MAD_data(:,3)==min(MAD_data(:,3))),:);
dx = MV_smallest(1,1);
dy = MV_smallest(1,2);

end
